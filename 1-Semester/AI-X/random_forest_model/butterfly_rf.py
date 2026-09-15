#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# 필요한 라이브러리
# numpy
# pandas
# matplotlib
# seaborn
# scikit-learn
# scipy
# mlxtend
# shap (선택적, SHAP 시각화용)

import os
import glob
import pickle
import warnings
from xml.sax.handler import all_features
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import (
    accuracy_score, recall_score, precision_score, f1_score,
    classification_report, confusion_matrix
)
from sklearn.tree import plot_tree
from scipy.cluster.hierarchy import dendrogram, linkage

warnings.filterwarnings('ignore')

# --- 설정 및 상수 ---
#plt.rcParams['font.family'] = 'Malgun Gothic' # Windows 환경
plt.rcParams['font.family'] = 'AppleGothic' # macOS 환경
plt.rcParams['axes.unicode_minus'] = False
OUTPUT_DIR = './output'
CSV_DIR = os.path.expanduser('~/Study/CourseWork/Coursework/AI-X/random_forest_model/data')
CSV_PATTERN = '*.csv'

CLASS_NAMES = {1: '제비나비', 2: '왕오색나비', 3: '흰나비', 4: '박각시나방', 5: '누에나방'}
FEATURE_COLS = ['wing_color_brightness', 'wing_pattern_complexity', 'body_thickness', 
                'antenna_shape', 'wing_aspect_ratio', 'size_estimate']
LABEL_COL = 'label'

def print_section(title):
    print(f"\n{'='*60}\n  {title}\n{'='*60}")

# 1. 데이터 로드 및 전처리
def prepare_data():
    search_path = os.path.join(CSV_DIR, CSV_PATTERN)
    file_list = sorted(glob.glob(search_path))
    if not file_list:
        raise FileNotFoundError("CSV 파일을 찾을 수 없습니다.")

    dfs = []
    for fpath in file_list:
        df_tmp = pd.read_csv(fpath)
        df_tmp.columns = [c.strip().lower().replace(' ', '_') for c in df_tmp.columns]
        dfs.append(df_tmp)
    
    df = pd.concat(dfs, ignore_index=True)
    
    # 전처리: 1~5 범위 및 유효 라벨 필터링
    for col in FEATURE_COLS:
        df[col] = pd.to_numeric(df[col], errors='coerce')
        df = df[df[col].between(1, 5)]
    df = df[df[LABEL_COL].isin(CLASS_NAMES.keys())]
    
    return df

# 병렬 좌표 그래프 시각화 (Parallel Coordinates Plot)
import pandas as pd
from pandas.plotting import parallel_coordinates


def dendrogram_decision_tree(X_train, target_names) :
        print("\n> 랜덤 포레스트 모델의 트리 덴드로그램을 생성합니다...")

        # 데이터가 너무 많으면 덴드로그램이 뭉쳐서 보이지 않으므로 일부만 사용합니다.
        sample_size = min(100, len(X_train))  # 최대 100개 샘플 사용
        X_samples = X_train[:sample_size]

        
        # leaf_rotation을 주면 하단 인덱스 라벨이 보기 편해집니다.
        plt.figure(figsize=(20, 10))
        Z = linkage(X_samples, method='ward')
        dendrogram(
            Z, 
            leaf_rotation=90., 
            leaf_font_size=10.,
            labels=X_samples.index.astype(str) if hasattr(X_samples, 'index') else None
        )
        
        plt.title("학습 데이터 샘플 간의 유사도 (Dendrogram of Training Samples)")
        plt.xlabel("Sample Index (Data Row)")
        plt.ylabel("Distance (Euclidean)")
        plt.show()
        
        predictions = np.array([tree.predict(X_train[:100]) for tree in model.estimators_])
        Z = linkage(predictions, method='ward')
        plt.figure(figsize=(20, 10))
        dendrogram(Z)
        plt.title("Dendrogram of Trees in Random Forest (개별 의사결정나무의 유사도)")
        plt.xlabel("Tree Index")
        plt.ylabel("Distance")
        plt.show()

        # for i in range(len(model.estimators_)):  # RF 내 모든 트리를 시각화
        max_treees_to_plot = min(3, len(model.estimators_))  # 최대 3개 트리만 시각화
        for i in range(max_treees_to_plot): 

            plt.figure(figsize=(20, 15))
            plot_tree(model.estimators_[i], 
                feature_names=FEATURE_COLS,
                max_depth=3,        # 트리 깊이 제한 (너무 복잡한 트리는 시각화 어려움)
                class_names=target_names,
                # proportion=True, 
                filled=True, 
                rounded=True, 
                fontsize=8,
                impurity=False,
                precision=1)

            plt.title(f"Random Forest - {len(model.estimators_)} 결정 트리 중 {i+1}번째 트리")
            plt.show()


# 3. 상세 시각화 (Confusion Matrix, Feature Importance, Dendrogram)
def visualize_detailed(model, X_train, X_test, y_test, y_pred):

    os.makedirs(OUTPUT_DIR, exist_ok=True)

    target_names = [CLASS_NAMES[i] for i in sorted(CLASS_NAMES)]

    # 레이아웃 설정
    fig, axes = plt.subplots(1, 2, figsize=(14, 6))
    
    # 혼동 행렬
    cm = confusion_matrix(y_test, y_pred)
    sns.heatmap(cm, annot=True, fmt='d', cmap='YlGnBu', ax=axes[0],
                xticklabels=target_names, yticklabels=target_names)
    axes[0].set_title(f'랜덤 포레스트 혼동 행렬')
    
    importances = model.feature_importances_
    indices = np.argsort(importances)
    axes[1].barh(range(len(indices)), importances[indices], color='skyblue')
    axes[1].set_yticks(range(len(indices)))
    axes[1].set_yticklabels([FEATURE_COLS[i] for i in indices])
    axes[1].set_title('특성 중요도 (Feature Importance)')

    plt.tight_layout()
    plt.savefig(os.path.join(OUTPUT_DIR, f'detail_RandomForest.png'))
    plt.show()

    dendrogram_decision_tree(X_train, target_names)


from sklearn.inspection import PartialDependenceDisplay
import shap

def visualize_rf_ensemble(model, X_train, FEATURE_COLS, target_names):
    """
    Random Forest 앙상블 모델의 전체 학습 결과 시각화 (다중 클래스 지원)
    """
    # 모델이 다중 클래스 분류기인지 확인
    is_classifier = hasattr(model, 'classes_')
    is_multiclass = is_classifier and len(model.classes_) > 2

    # ---------------------------------------------------------
    # 1. Feature Importance (Mean Decrease in Impurity) 및 트리 간 분산
    # ---------------------------------------------------------
    print("\n[1] Random Forest 전체 변수 중요도(Feature Importance)를 생성합니다...")
    
    importances = model.feature_importances_
    std = np.std([tree.feature_importances_ for tree in model.estimators_], axis=0)
    
    indices = np.argsort(importances)[::-1]
    sorted_features = [FEATURE_COLS[i] for i in indices]
    sorted_importances = importances[indices]
    sorted_std = std[indices]

    plt.figure(figsize=(12, 6))
    plt.title("Feature Importances across the Random Forest Ensemble", fontsize=14)
    plt.bar(range(X_train.shape[1]), sorted_importances, yerr=sorted_std, align="center", capsize=5, alpha=0.8)
    plt.xticks(range(X_train.shape[1]), sorted_features, rotation=45, ha='right')
    plt.xlim([-1, X_train.shape[1]])
    plt.ylabel("Mean Decrease in Impurity (MDI)")
    plt.tight_layout()
    plt.show()

    # ---------------------------------------------------------
    # 2. Partial Dependence Plot (PDP) 
    # ---------------------------------------------------------
    print("\n[2] 주요 변수에 대한 앙상블 부분 의존성(PDP)을 시각화합니다...")
    print (target_names)
    all_features = indices
    
    # if is_multiclass:
    
    for target_idx in (3,4) :   # 다중 클래스인 경우 각 클래스별로 PDP를 생성합니다. (예시로 3번 흰나비,4번 박각시 클래스 선택)
        fig, ax = plt.subplots(2, 3, figsize=(20, 12))
        target_label = target_names[target_idx] if target_names is not None else model.classes_[target_idx]
        
        PartialDependenceDisplay.from_estimator(
            model, X_train, features=all_features, feature_names=FEATURE_COLS,
            kind='both', target=target_idx, ax=ax
        )
        plt.suptitle(f"Partial Dependence of Features (Target: {target_label})", fontsize=14)
        plt.tight_layout()
        plt.show()

    # ---------------------------------------------------------
    # 3. SHAP (SHapley Additive exPlanations) Summary Plot
    # ---------------------------------------------------------
    print("\n[3] 앙상블 모델 예측에 대한 SHAP 요약 플롯을 생성합니다...")
    
    try:
        # TreeExplainer 설정
        explainer = shap.TreeExplainer(model)
        X_train_df = pd.DataFrame(X_train, columns=FEATURE_COLS) if not isinstance(X_train, pd.DataFrame) else X_train
        
        # 전체 데이터에 대한 SHAP 값 계산
        shap_values = explainer.shap_values(X_train_df)
        
        plt.figure(figsize=(10, 6))

        # 6개의 클래스(또는 타겟)를 시각화한다고 가정 (0~5 index)
        for i in range(5):
            # 2행 3열 중 i+1번째 자리에 서브플롯 생성
            plt.subplot(3, 2, i+1)
            
            target_idx = i # 루프 인덱스를 타겟 인덱스로 사용
            
            # 데이터 형태 처리
            if isinstance(shap_values, list):
                display_shap_values = shap_values[target_idx]
            else:
                # numpy 배열 (samples, features, classes) 형태 대응
                display_shap_values = shap_values[:, :, target_idx]

            # 클래스 이름 가져오기
            target_label = CLASS_NAMES.get(model.classes_[target_idx], f"Class {target_idx}")
            
            # SHAP 시각화 수행
            # ax 파라미터 대신 현재 활성화된 subplot에 그려지도록 설정
            shap.summary_plot(
                display_shap_values, 
                X_train_df, 
                show=False,        # 즉시 출력 방지
                plot_type="dot"    # 또는 "bar"
            )
            
            # 각 서브플롯의 제목 설정
            plt.title(f"Target: {target_label}")

        # 전체 레이아웃 조정 및 제목
        plt.suptitle("SHAP Summary 비교", fontsize=14)
        plt.tight_layout() # 기본적인 자동 배치를 먼저 적용한 후
        plt.subplots_adjust(left=0.2, right=0.9, top=0.9, bottom=0.1, wspace=0.5, hspace=0.5)
        plt.show()

    except Exception as e:
        print(f" > SHAP 시각화 중 오류 발생: {e}")
        # 상세 디버깅
        import traceback
        traceback.print_exc()

# 실시간 추론
def run_inference(model):
    print_section("4단계. 새 데이터 추론")
    print("  입력 순서: [날개밝기, 날개무늬, 몸통두께, 더듬이모양, 날개비율, 크기] (1~5 정수)")
    while True:
        raw = input("\n  데이터 입력 (종료: Enter) > ").strip()
        if not raw: break
        try:
            vals = list(map(int, raw.split()))
            if len(vals) != 6: continue
            
            pred = model.predict([vals])[0]
            proba = model.predict_proba([vals])[0] if hasattr(model, 'predict_proba') else None
            
            print(f"  [결과] 이 곤충은 【{CLASS_NAMES[pred]}】로 예측됩니다.")
            if proba is not None:
                print(f"  [신뢰도] {max(proba):.1%}")
        except:
            print("  올바른 형식으로 입력해주세요.")

# --- 메인 실행 흐름 ---
if __name__ == "__main__":
    # 데이터 준비
    data = prepare_data()
    X = data[FEATURE_COLS].values
    y = data[LABEL_COL].values
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42, stratify=y)
       
    model = RandomForestClassifier(n_estimators=10, random_state=42)
        
    model.fit(X_train, y_train)
    acc = accuracy_score(y_test, model.predict(X_test))
    print(f"정확도: {acc:.1%}")

    y_pred = model.predict(X_test)
    
    # 3. 상세 시각화
    visualize_detailed(model, X_train, X_test, y_test, y_pred)
    visualize_rf_ensemble(model, X_train, FEATURE_COLS, CLASS_NAMES)

    # 모델 저장
    import joblib
    
    joblib.dump(model, os.path.join('/Users/hyun/Study/CourseWork/Coursework/AI-X/random_forest_model', 'random_forest_model.pkl'))
    print (f"모델이 'random_forest_model.pkl'에 저장되었습니다.")

    # 4. 추론
    run_inference(model)