#!/usr/bin/env python3
# -*- coding: utf-8 -*-

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
from sklearn.preprocessing import StandardScaler
from sklearn.cluster import KMeans

warnings.filterwarnings('ignore')

# --- 설정 및 상수 ---
#plt.rcParams['font.family'] = 'Apple Gothic' # Windows 환경
plt.rcParams['axes.unicode_minus'] = False

plt.rcParams['font.family'] = 'Apple Gothic' # MacOS 환경
CSV_DIR = os.path.expanduser('~/Study/CourseWork/Coursework/AI-X/random_forest_model/clustering_data/clustering_data')
CSV_PATTERN = '*.csv'

# CLASS_NAMES = {1: '제비나비', 2: '왕오색나비', 3: '흰나비', 4: '박각시나방', 5: '누에나방'}
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

    # df = df[df[LABEL_COL].isin(CLASS_NAMES.keys())]
    
    return df

import seaborn as sns

import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.cluster import KMeans

def run_kmeans(X_train_scaled, feature_names=None, k=5):
    """
    K-means 클러스터링을 수행하고, 각 클러스터의 데이터 개수 및 특성별 분포를 시각화합니다.
    
    :param X_train_scaled: 스케일링된 훈련 데이터 (NumPy array 또는 DataFrame)
    :param feature_names: 시각화할 때 사용할 특성 이름 리스트 (선택사항)
    :param k: 클러스터 개수
    """
    # 1. K-means 모델 학습 및 예측
    kmeans_sel = KMeans(n_clusters=k, random_state=42, n_init=10)
    labels_sel = kmeans_sel.fit_predict(X_train_scaled)

    print("--- K-means 클러스터링 결과 ---")
    print(labels_sel)
    print("\n" + "="*50 + "\n")

    # 2. 분석을 위해 데이터를 Pandas DataFrame으로 변환
    if isinstance(X_train_scaled, pd.DataFrame):
        df_analysis = X_train_scaled.copy()
        if feature_names is None:
            feature_names = df_analysis.columns.tolist()
    else:
        if feature_names is None:
            feature_names = [f"Feature_{i}" for i in range(X_train_scaled.shape[1])]
        df_analysis = pd.DataFrame(X_train_scaled, columns=feature_names)
    
    # 클러스터 ID 추가
    df_analysis['Cluster'] = labels_sel

    # 3. 각 Cluster ID별 데이터 개수 (Size) 출력
    cluster_counts = df_analysis['Cluster'].value_counts().sort_index()
    print("각 클러스터별 데이터 개수:")
    for cluster_id, count in cluster_counts.items():
        print(f"  - Cluster {cluster_id}: {count}개 (비중: {count/len(df_analysis)*100:.1f}%)")
    print("\n" + "="*50 + "\n")

    # 4. 각 Cluster ID별 Feature 값 분포 출력 (박스 플롯 / 캔들차트 형태)
    print("각 클러스터별 특성(Feature) 분포 시각화를 시작합니다...")
    
    # 시각화할 특성 개수에 따라 서브플롯 생성
    num_features = len(feature_names)
    fig, axes = plt.subplots(nrows=2, ncols=int(num_features/2), figsize=(3 * num_features, 12))
    
    # 특성이 1개인 경우 axes가 배열이 아니므로 예외 처리
    if num_features == 1:
        axes = [axes]
    else:
        axes = axes.flatten()
        
    for i, feature in enumerate(feature_names):
        axes[i].set_ylim(-3, 3)  # 특성 값이 1~5 범위이고, standardscaler를 거쳐서 y축 범위를 고정하여 비교 용이하게 설정
        # Seaborn의 boxplot을 이용해 캔들차트 형태의 분포 시각화
        sns.boxplot(x='Cluster', y=feature, data=df_analysis, ax=axes[i], palette='Set2')
        axes[i].set_title(f'Distribution of {feature} (k = {k})', fontsize=12, fontweight='bold')
        axes[i].set_xlabel('Cluster ID')
        axes[i].set_ylabel('Value')
        axes[i].grid(True, linestyle='--', alpha=0.6)

    plt.tight_layout()
    plt.show()

    return labels_sel

def find_optimal_k_elbow(X_train_scaled, max_k=10):
    """K-means의 최적 k 값을 찾기 위한 엘보우(Elbow) 분석 (2차 차분 알고리즘 적용 버전)

    :param X_train_scaled: 스케일링된 훈련 데이터 (NumPy array 또는 DataFrame)
    :param max_k: 테스트할 최대 클러스터 개수 (기본값: 10)
    """
    inertias = []
    k_values = range(2, max_k + 1)

    print("■ 각 K값별 Inertia(군집 내 거리 제곱합) 계산 중...")
    for k in k_values:
        kmeans = KMeans(n_clusters=k, random_state=42, n_init=10)
        kmeans.fit(X_train_scaled)
        inertias.append(kmeans.inertia_)
        print(f"  - K = {k}: Inertia = {kmeans.inertia_:.2f}")

    # --- 일관성을 위한 알고리즘 통일: 2차 차분(기울기 급변점) 활용 ---
    inertias_np = np.array(inertias)
    diffs = np.diff(inertias_np)      # 1차 차분 (기울기)
    diffs_2nd = np.diff(diffs)        # 2차 차분 (기울기의 변화량)

    recommended_k = np.argmax(diffs_2nd) + 3 if len(diffs_2nd) > 0 else 3

    print("\n" + "=" * 50)
    print(f"★ 추천하는 최적의 K값 (Elbow Point): {recommended_k}")
    print("=" * 50 + "\n")

    # --- 시각화 (Line Plot) ---
    plt.figure(figsize=(8, 5))
    plt.plot(
        k_values, inertias, "go-", markersize=8, linewidth=2, label="Inertia"
    )

    # 추천 점 강조 표시 (차분 인덱스에 맞게 매칭)
    plt.plot(
        recommended_k,
        inertias[recommended_k - 2], # K값 위치의 Inertia
        "ro",
        markersize=12,
        markeredgewidth=3,
        markerfacecolor="none",
        label=f"Recommended K ({recommended_k})",
    )

    plt.title("Elbow Method For Optimal K", fontsize=14, fontweight="bold")
    plt.xlabel("Number of Clusters (k)", fontsize=12)
    plt.ylabel("Inertia (Within-Cluster Sum of Squares)", fontsize=12)
    plt.xticks(k_values)
    plt.grid(True, linestyle="--", alpha=0.6)
    plt.legend(fontsize=11)
    plt.show()

    return recommended_k

from sklearn.metrics import silhouette_score

def find_robust_k(X_train_scaled, max_k=15):
    """max_k의 영향력을 줄이기 위해 엘보우(Inertia)와 실루엣 점수를 동시에 분석합니다."""
    k_values = range(2, max_k + 1)  # 실루엣은 k=2부터 계산 가능합니다.
    inertias = []
    silhouette_scores = []

    print(f"■ K=2부터 K={max_k}까지 다각도 분석 중...")
    for k in k_values:
        kmeans = KMeans(n_clusters=k, random_state=42, n_init=10)
        labels = kmeans.fit_predict(X_train_scaled)

        inertias.append(kmeans.inertia_)
        sil_score = silhouette_score(X_train_scaled, labels)
        silhouette_scores.append(sil_score)
        print(
            f"  - K = {k}: Inertia = {kmeans.inertia_:.2f} | Silhouette = {sil_score:.3f}"
        )

    # --- max_k 영향을 줄이는 개선된 엘보우 추정 (1차 차분 활용) ---
    inertias_np = np.array(inertias)
    diffs = np.diff(inertias_np)  # 1차 차분 (기울기)
    diffs_2nd = np.diff(diffs)  # 2차 차분 (기울기의 변화량)

    recommended_elbow_k = np.argmax(diffs_2nd) + 3 if len(diffs_2nd) > 0 else 3
    recommended_sil_k = k_values[np.argmax(silhouette_scores)]

    print("\n" + "=" * 50)
    print(
        f"[엘보우 알고리즘 추천 K] (기울기 급변점): {recommended_elbow_k}"
    )
    print(f"[실루엣 점수 기준 추천 K] (결합력 최고점): {recommended_sil_k}")
    print("=" * 50)
    print(
        f"두 추천 값이 다른 경우 {recommended_elbow_k}과 {recommended_sil_k} 사이의 값을 검토하여 결정합니다."
    )
    print("=" * 50 + "\n")

    # --- 시각화 (Dual Axis Plot) ---
    fig, ax1 = plt.subplots(figsize=(10, 6))

    # 왼쪽 축: Inertia (Elbow)
    color = "tab:blue"
    ax1.set_xlabel("Number of Clusters (k)", fontsize=12)
    ax1.set_ylabel("Inertia", color=color, fontsize=12)
    ax1.plot(
        k_values,
        inertias,
        marker="o",
        color=color,
        linewidth=2,
        label="Inertia (Elbow)",
    )
    ax1.tick_params(axis="y", labelcolor=color)
    ax1.axvline(
        x=recommended_elbow_k,
        color="blue",
        linestyle="--",
        alpha=0.7,
        label=f"Elbow Point ({recommended_elbow_k})",
    )

    # 오른쪽 축: Silhouette Score
    ax2 = ax1.twinx()
    color = "tab:orange"
    ax2.set_ylabel("Silhouette Score", color=color, fontsize=12)
    ax2.plot(
        k_values,
        silhouette_scores,
        marker="s",
        color=color,
        linewidth=2,
        linestyle="-.",
        label="Silhouette",
    )
    ax2.tick_params(axis="y", labelcolor=color)
    ax2.axvline(
        x=recommended_sil_k,
        color="orange",
        linestyle=":",
        alpha=0.7,
        label=f"Best Silhouette ({recommended_sil_k})",
    )

    plt.title(
        "Robust K Determination: Elbow vs Silhouette",
        fontsize=14,
        fontweight="bold",
    )
    fig.tight_layout()
    plt.grid(True, linestyle="--", alpha=0.3)
    plt.show()

    return recommended_elbow_k, recommended_sil_k

# --- 메인 실행 흐름 ---
if __name__ == "__main__":
    # 데이터 준비
    data = prepare_data()
    X = data[FEATURE_COLS].values
    # y = data[LABEL_COL].values
    # X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42, stratify=y)
    # 데이터 준비 및 스케일링
    scaler = StandardScaler()
    X_scaled = scaler.fit_transform(X)

    while True :
        k_val = int(input("k 값을 입력하세요 (2-5, 종료하려면 0): "))
        if k_val == 0:
            break
        run_kmeans(X_scaled, FEATURE_COLS, k=k_val)

    # 최대 10개의 k 후보군을 두고 엘보우 포인트 분석 수행
    best_k = find_optimal_k_elbow(X_scaled, max_k=10)

    # 엘보우 포인트와 실루엣 점수를 동시에 분석하여 robust한 k 추천
    best_k_elbow, best_k_silhouette = find_robust_k(X_scaled, max_k=10)

    for k_val in range(best_k_elbow, best_k_silhouette + 1):
        run_kmeans(X_scaled, FEATURE_COLS, k=k_val)