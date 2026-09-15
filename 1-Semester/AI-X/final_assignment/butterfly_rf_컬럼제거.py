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
import warnings
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import (
    accuracy_score,
    classification_report,
    confusion_matrix
)
from sklearn.tree import plot_tree
from scipy.cluster.hierarchy import dendrogram, linkage
from sklearn.inspection import PartialDependenceDisplay

import shap
import joblib

warnings.filterwarnings('ignore')

# -------------------------------------------------
# 설정 및 상수
# -------------------------------------------------

# macOS 환경
plt.rcParams['font.family'] = 'AppleGothic'
plt.rcParams['axes.unicode_minus'] = False

OUTPUT_DIR = './output'

CSV_DIR = os.path.expanduser(
    '~/Study/CourseWork/Coursework/AI-X/final_assignment/컬럼제거'
)

CSV_PATTERN = '*.csv'

CLASS_NAMES = {
    1: '제비나비',
    2: '왕오색나비',
    3: '흰나비',
    4: '박각시나방',
    5: '누에나방'
}

# 제거된 컬럼 반영
FEATURE_COLS = [
    'wing_color_brightness',
    'antenna_shape',
    'wing_aspect_ratio',
    'size_estimate'
]

LABEL_COL = 'label'


# -------------------------------------------------
# 출력용 함수
# -------------------------------------------------

def print_section(title):
    print(f"\n{'=' * 60}")
    print(f"  {title}")
    print(f"{'=' * 60}")


# -------------------------------------------------
# 1. 데이터 로드 및 전처리
# -------------------------------------------------

def prepare_data():

    search_path = os.path.join(CSV_DIR, CSV_PATTERN)
    file_list = sorted(glob.glob(search_path))

    if not file_list:
        raise FileNotFoundError("CSV 파일을 찾을 수 없습니다.")

    dfs = []

    for fpath in file_list:

        df_tmp = pd.read_csv(fpath)

        # 컬럼명 정리
        df_tmp.columns = [
            c.strip().lower().replace(' ', '_')
            for c in df_tmp.columns
        ]

        dfs.append(df_tmp)

    df = pd.concat(dfs, ignore_index=True)

    print("\n[데이터 컬럼]")
    print(df.columns.tolist())

    # 숫자형 변환 및 범위 필터링
    for col in FEATURE_COLS:

        if col not in df.columns:
            print(f"[경고] {col} 컬럼 없음")
            continue

        df[col] = pd.to_numeric(df[col], errors='coerce')

        # 1~5 범위 필터
        df = df[df[col].between(1, 5)]

    # label 필터
    df = df[df[LABEL_COL].isin(CLASS_NAMES.keys())]

    return df


# -------------------------------------------------
# 덴드로그램 및 트리 시각화
# -------------------------------------------------

def dendrogram_decision_tree(model, X_train, target_names):

    print("\n> 랜덤 포레스트 모델의 트리 덴드로그램 생성")

    sample_size = min(100, len(X_train))
    X_samples = X_train[:sample_size]

    # 샘플 간 유사도
    plt.figure(figsize=(20, 10))

    Z = linkage(X_samples, method='ward')

    dendrogram(
        Z,
        leaf_rotation=90.,
        leaf_font_size=10.
    )

    plt.title("학습 데이터 샘플 간 유사도")
    plt.xlabel("Sample Index")
    plt.ylabel("Distance")
    plt.show()

    # 트리 간 유사도
    predictions = np.array([
        tree.predict(X_train[:100])
        for tree in model.estimators_
    ])

    Z = linkage(predictions, method='ward')

    plt.figure(figsize=(20, 10))

    dendrogram(Z)

    plt.title("Random Forest 내부 트리 유사도")
    plt.xlabel("Tree Index")
    plt.ylabel("Distance")

    plt.show()

    # 일부 트리 시각화
    max_trees_to_plot = min(3, len(model.estimators_))

    for i in range(max_trees_to_plot):

        plt.figure(figsize=(20, 15))

        plot_tree(
            model.estimators_[i],
            feature_names=FEATURE_COLS,
            max_depth=3,
            class_names=target_names,
            filled=True,
            rounded=True,
            fontsize=8,
            impurity=False,
            precision=1
        )

        plt.title(
            f"Random Forest - {i + 1}번째 트리"
        )

        plt.show()


# -------------------------------------------------
# 상세 시각화
# -------------------------------------------------

def visualize_detailed(
        model,
        X_train,
        X_test,
        y_test,
        y_pred
):

    os.makedirs(OUTPUT_DIR, exist_ok=True)

    target_names = [
        CLASS_NAMES[i]
        for i in sorted(CLASS_NAMES)
    ]

    fig, axes = plt.subplots(1, 2, figsize=(14, 6))

    # 혼동 행렬
    cm = confusion_matrix(y_test, y_pred)

    sns.heatmap(
        cm,
        annot=True,
        fmt='d',
        cmap='YlGnBu',
        ax=axes[0],
        xticklabels=target_names,
        yticklabels=target_names
    )

    axes[0].set_title('혼동 행렬')

    # Feature Importance
    importances = model.feature_importances_

    indices = np.argsort(importances)

    axes[1].barh(
        range(len(indices)),
        importances[indices],
        color='skyblue'
    )

    axes[1].set_yticks(range(len(indices)))

    axes[1].set_yticklabels(
        [FEATURE_COLS[i] for i in indices]
    )

    axes[1].set_title('특성 중요도')

    plt.tight_layout()

    plt.savefig(
        os.path.join(
            OUTPUT_DIR,
            'detail_RandomForest.png'
        )
    )

    plt.show()

    dendrogram_decision_tree(
        model,
        X_train,
        target_names
    )


# -------------------------------------------------
# Random Forest Ensemble 시각화
# -------------------------------------------------

def visualize_rf_ensemble(
        model,
        X_train,
        FEATURE_COLS,
        target_names
):

    # -------------------------------------------------
    # 1. Feature Importance
    # -------------------------------------------------

    print("\n[1] Feature Importance 시각화")

    importances = model.feature_importances_

    std = np.std(
        [tree.feature_importances_
         for tree in model.estimators_],
        axis=0
    )

    indices = np.argsort(importances)[::-1]

    sorted_features = [
        FEATURE_COLS[i]
        for i in indices
    ]

    sorted_importances = importances[indices]

    sorted_std = std[indices]

    plt.figure(figsize=(12, 6))

    plt.title(
        "Feature Importances"
    )

    plt.bar(
        range(X_train.shape[1]),
        sorted_importances,
        yerr=sorted_std,
        align="center",
        capsize=5,
        alpha=0.8
    )

    plt.xticks(
        range(X_train.shape[1]),
        sorted_features,
        rotation=45,
        ha='right'
    )

    plt.ylabel("Importance")

    plt.tight_layout()

    plt.show()

    # -------------------------------------------------
    # 2. PDP
    # -------------------------------------------------

    print("\n[2] PDP 시각화")

    all_features = indices

    for target_idx in range(len(model.classes_)):

        fig, ax = plt.subplots(
            2,
            2,
            figsize=(14, 10)
        )

        target_label = target_names[target_idx]

        PartialDependenceDisplay.from_estimator(
            model,
            X_train,
            features=all_features,
            feature_names=FEATURE_COLS,
            kind='both',
            target=target_idx,
            ax=ax
        )

        plt.suptitle(
            f"PDP - {target_label}"
        )

        plt.tight_layout()

        plt.show()

    # -------------------------------------------------
    # 3. SHAP
    # -------------------------------------------------

    print("\n[3] SHAP 시각화")

    try:

        explainer = shap.TreeExplainer(model)

        X_train_df = pd.DataFrame(
            X_train,
            columns=FEATURE_COLS
        )

        shap_values = explainer.shap_values(X_train_df)

        for i in range(len(model.classes_)):

            plt.figure(figsize=(10, 6))

            if isinstance(shap_values, list):

                display_shap_values = shap_values[i]

            else:

                display_shap_values = shap_values[:, :, i]

            target_label = CLASS_NAMES.get(
                model.classes_[i],
                f"Class {i}"
            )

            shap.summary_plot(
                display_shap_values,
                X_train_df,
                show=False,
                plot_type="dot"
            )

            plt.title(
                f"SHAP Summary - {target_label}"
            )

            plt.show()

    except Exception as e:

        print(f"SHAP 오류 발생: {e}")

        import traceback
        traceback.print_exc()


# -------------------------------------------------
# 실시간 추론
# -------------------------------------------------

def run_inference(model):

    print_section("4단계. 새 데이터 추론")

    print(
        "입력 순서: "
        "[날개밝기, 더듬이모양, 날개비율, 크기]"
        " (1~5 정수)"
    )

    while True:

        raw = input(
            "\n데이터 입력 (종료: Enter) > "
        ).strip()

        if not raw:
            break

        try:

            vals = list(map(int, raw.split()))

            if len(vals) != 4:
                print("4개의 값을 입력하세요.")
                continue

            pred = model.predict([vals])[0]

            if hasattr(model, 'predict_proba'):

                proba = model.predict_proba([vals])[0]

            else:

                proba = None

            print(
                f"\n[결과] "
                f"【{CLASS_NAMES[pred]}】 "
                f"로 예측됩니다."
            )

            if proba is not None:

                print(
                    f"[신뢰도] {max(proba):.1%}"
                )

        except:

            print(
                "올바른 형식으로 입력해주세요."
            )


# -------------------------------------------------
# 메인 실행
# -------------------------------------------------

if __name__ == "__main__":

    # 데이터 준비
    data = prepare_data()

    X = data[FEATURE_COLS].values
    y = data[LABEL_COL].values

    X_train, X_test, y_train, y_test = train_test_split(
        X,
        y,
        test_size=0.2,
        random_state=42,
        stratify=y
    )

    # 모델 생성
    model = RandomForestClassifier(
        n_estimators=10,
        random_state=42
    )

    # 학습
    model.fit(X_train, y_train)

    # 예측
    y_pred = model.predict(X_test)

    # 정확도
    acc = accuracy_score(y_test, y_pred)

    print(f"\n전체 정확도: {acc:.1%}")

    # 상세 리포트
    print("\n" + "=" * 50)
    print("곤충별 상세 평가지표")
    print("=" * 50)

    target_names = [
        CLASS_NAMES[i]
        for i in sorted(CLASS_NAMES)
    ]

    print(
        classification_report(
            y_test,
            y_pred,
            target_names=target_names
        )
    )

    print("=" * 50)

    # 시각화
    visualize_detailed(
        model,
        X_train,
        X_test,
        y_test,
        y_pred
    )

    visualize_rf_ensemble(
        model,
        X_train,
        FEATURE_COLS,
        target_names
    )

    # 모델 저장
    model_path = os.path.join(
        '/Users/hyun/Study/CourseWork/Coursework/AI-X/final_assignment',
        'random_forest_컬럼제거.pkl'
    )

    joblib.dump(model, model_path)

    print(f"\n모델 저장 완료:")
    print(model_path)

    # 추론
    run_inference(model)