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

import os
import glob
import pickle
import warnings
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.neighbors import KNeighborsClassifier
from sklearn.svm import SVC
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
#CSV_DIR = '.'
CSV_DIR = os.path.expanduser('~/Study/CourseWork/Coursework/AI-X')
CSV_PATTERN = 'butterfly.csv'
#CSV_PATTERN = '*.csv'

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

def visualize_parallel_coordinates(df, class_names):
    # 1. 시각화를 위한 데이터프레임 복사
    plot_df = df[FEATURE_COLS + [LABEL_COL]].copy()
    
    # 2. 라벨(숫자)을 실제 이름으로 변환 (범례 가독성)
    plot_df[LABEL_COL] = plot_df[LABEL_COL].map(class_names)
    
    # 3. 그래프 그리기
    plt.figure(figsize=(12, 7))
    
    # 색상 맵 설정 (종류가 5가지이므로 구분이 잘 되는 색상 선택)
    colors = ('#FF5733', '#33FF57', '#3357FF', '#F333FF', '#FF33A1')
    
    parallel_coordinates(plot_df, LABEL_COL, color=colors, alpha=0.5, marker='o')
    
    plt.title('나비·나방 종별 특성 패턴 비교 (Parallel Coordinates)', fontsize=15, fontweight='bold')
    plt.xlabel('특성 항목 (Features)')
    plt.ylabel('특성 값 (1~5 Scale)')
    plt.xticks(rotation=15)
    plt.grid(axis='y', linestyle='--', alpha=0.3)
    plt.legend(title="종류", loc='upper right', bbox_to_anchor=(1.15, 1))
    
    plt.tight_layout()
    plt.show()

# SVM/KNN 학습 결과 시각화
from sklearn.decomposition import PCA
from sklearn.neighbors import KNeighborsClassifier
from sklearn.svm import SVC
from mlxtend.plotting import plot_decision_regions

def visualize_boundaries(X_train, y_train, class_names, model_type='KNN'):
    """
    특정 모델(KNN 또는 SVM)을 선택하여 결정 경계를 시각화합니다.
    
    Args:
        X_train: 훈련 데이터
        y_train: 훈련 라벨
        class_names: 클래스 이름 리스트
        model_type: 'KNN' 또는 'SVM'
    """
    # 1. 고차원 데이터를 2차원(PCA)으로 압축
    pca = PCA(n_components=2)
    X_pca = pca.fit_transform(X_train)
    
    # 2. 파라미터에 따른 모델 설정
    if model_type.upper() == 'KNN':
        model = KNeighborsClassifier(n_neighbors=5)
        title_name = 'KNN (K=5)'
    elif model_type.upper() == 'SVM':
        model = SVC(kernel='rbf', C=1.0, gamma='auto')
        title_name = 'SVM (RBF Kernel)'
    else:
        print("지원하지 않는 모델 타입입니다. 'KNN' 또는 'SVM'을 입력하세요.")
        return

    # 3. 모델 학습
    model.fit(X_pca, y_train)
    
    # 4. 단일 그래프 생성
    plt.figure(figsize=(10, 7))
    
    # 결정 경계 시각화
    plot_decision_regions(X_pca, y_train, clf=model, legend=2)
    
    # 그래프 꾸미기
    plt.title(f'{title_name} 결정 경계 시각화', fontsize=15, fontweight='bold', pad=20)
    plt.xlabel('주성분 1 (PCA 1)')
    plt.ylabel('주성분 2 (PCA 2)')
    
    # 범례 설정
    handles, labels = plt.gca().get_legend_handles_labels()
    plt.legend(handles, [class_names[int(l)] for l in labels], 
               frameon=True, loc='upper right')

    plt.tight_layout()
    plt.show()

def dendrogram_decision_tree(X_train, target_names) :
        print("\n  > RF 트리 덴드로그램을 생성합니다...")
        predictions = np.array([tree.predict(X_train[:100]) for tree in model.estimators_])
        Z = linkage(predictions, method='ward')
        plt.figure(figsize=(10, 5))
        dendrogram(Z)
        plt.title("Dendrogram of Trees in Random Forest")
        plt.xlabel("Tree Index")
        plt.ylabel("Distance")
        plt.show()

        plt.figure(figsize=(25, 20))
        plot_tree(model.estimators_[0], 
                feature_names=FEATURE_COLS, 
                class_names=target_names, 
                filled=True, 
                rounded=True, 
                fontsize=8)

        plt.show()

        # RF 내의 개별 Decision Tree 출력
        n_trees_to_show = 3

        for i in range(n_trees_to_show):
            plt.figure(figsize=(15, 10))
            plot_tree(model.estimators_[i], 
                    feature_names=FEATURE_COLS, 
                    class_names=[CLASS_NAMES[k] for k in sorted(CLASS_NAMES)], 
                    filled=True, 
                    rounded=True, 
                    fontsize=10)
            plt.title(f"Random Forest - {i+1}번째 트리")
            plt.show()


# 2. 모든 모델 성능 비교
def compare_all_models(X_train, X_test, y_train, y_test):
    print_section("1단계. 모델별 정확도 비교")
    models = {
        'RF': RandomForestClassifier(n_estimators=100, random_state=42),
        'KNN': KNeighborsClassifier(n_neighbors=5),
        'SVM': SVC(kernel='rbf', probability=True, random_state=42)
    }
    
    results = {}
    for name, m in models.items():
        m.fit(X_train, y_train)
        acc = accuracy_score(y_test, m.predict(X_test))
        results[name] = acc
        print(f"  [{name:3s}] 정확도: {acc:.1%} {'█' * int(acc*20)}")
    
    return results

# 3. 상세 시각화 (Confusion Matrix, Feature Importance, Dendrogram)
def visualize_detailed(model, model_name, X_train, X_test, y_test, y_pred):
    print_section(f"3단계. [{model_name}] 상세 분석 시각화")
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    
    target_names = [CLASS_NAMES[i] for i in sorted(CLASS_NAMES)]
    
    # 레이아웃 설정
    fig, axes = plt.subplots(1, 2, figsize=(14, 6))
    
    # (1) 혼동 행렬
    cm = confusion_matrix(y_test, y_pred)
    sns.heatmap(cm, annot=True, fmt='d', cmap='YlGnBu', ax=axes[0],
                xticklabels=target_names, yticklabels=target_names)
    axes[0].set_title(f'[{model_name}] 혼동 행렬')
    
    # (2) 모델별 특화 시각화
    if model_name == 'RF':
        importances = model.feature_importances_
        indices = np.argsort(importances)
        axes[1].barh(range(len(indices)), importances[indices], color='skyblue')
        axes[1].set_yticks(range(len(indices)))
        axes[1].set_yticklabels([FEATURE_COLS[i] for i in indices])
        axes[1].set_title('특성 중요도 (Feature Importance)')
    else:
        axes[1].text(0.5, 0.5, f'{model_name} 모델은\n중요도 시각화를\n지원하지 않습니다.', 
                     ha='center', va='center', fontsize=12)

    plt.tight_layout()
    plt.savefig(os.path.join(OUTPUT_DIR, f'detail_{model_name}.png'))
    plt.show()

    
    if model_name == 'RF': # RF일 경우 : 덴드로그램과 결정트리 (max 3) 시각화 출력
        dendrogram_decision_tree(X_train, target_names)

    else :  # KNN/SVM의 경우, 경계 및 병렬좌표 시각화

        visualize_boundaries(X_train, y_train, CLASS_NAMES,model_name)

        # pandas data frame 으로 변형
        train_combined = np.column_stack((X_train, y_train))
        df_train = pd.DataFrame(train_combined, columns=FEATURE_COLS + [LABEL_COL])
        df_train[LABEL_COL] = df_train[LABEL_COL].astype(int)
        visualize_parallel_coordinates(df_train, CLASS_NAMES)

# 4. 실시간 추론
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
    
    # 1. 모든 모델 비교
    compare_all_models(X_train, X_test, y_train, y_test)
    
    # 2. 사용자 모델 선택
    choice = input("\n상세 분석할 모델을 선택하세요 (RF / KNN / SVM) > ").upper()
    if choice not in ['RF', 'KNN', 'SVM']:
        print("잘못된 선택입니다. RF를 기본으로 진행합니다.")
        choice = 'RF'
        
    # 선택된 모델 재학습 및 평가
    if choice == 'RF':
        model = RandomForestClassifier(n_estimators=100, random_state=42)
    elif choice == 'KNN':
        model = KNeighborsClassifier(n_neighbors=5)
    else:
        model = SVC(kernel='rbf', probability=True, random_state=42)
        
    model.fit(X_train, y_train)
    y_pred = model.predict(X_test)
    
    # 3. 상세 시각화
    visualize_detailed(model, choice, X_train, X_test, y_test, y_pred)
    
    # 4. 추론
    run_inference(model)