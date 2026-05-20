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

warnings.filterwarnings('ignore')

# --- 설정 및 상수 ---
plt.rcParams['font.family'] = 'Apple Gothic' # Windows 환경
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

from scipy.stats import mode

def calculate_cluster_accuracy(y_true, cluster_labels):
    """
    클러스터 ID와 실제 라벨을 매핑하여 정확도를 계산합니다.
    """
    # 각 클러스터 ID에 대응하는 실제 라벨을 저장할 배열
    mapping = np.zeros_like(cluster_labels)
    
    for i in range(len(np.unique(cluster_labels))):
        # 특정 클러스터 i에 속하는 데이터들의 실제 라벨들 추출
        mask = (cluster_labels == i)
        if not np.any(mask):
            continue
            
        # 해당 클러스터에서 가장 많이 등장하는 실제 라벨 찾기 (다수결 매핑)
        actual_label_mode = mode(y_true[mask], keepdims=True).mode[0]
        mapping[mask] = actual_label_mode
        
        # 매핑 정보 출력
        print(f"Cluster {i} -> 매핑된 실제 종: {CLASS_NAMES.get(actual_label_mode, 'Unknown')} (ID: {actual_label_mode})")

    # 매핑된 결과와 실제 라벨 비교
    accuracy = accuracy_score(y_true, mapping)
    return accuracy

def print_cluster_distribution(y_true, cluster_labels):
    """
    각 Cluster ID 내에 실제 클래스(종)가 각각 몇 개씩 포함되어 있는지 
    분포와 비율을 출력합니다.
    """
    # 실제 라벨 숫자를 가독성 좋은 종 이름 문자열로 변환
    y_true_names = [CLASS_NAMES.get(label, f"Unknown({label})") for label in y_true]
    
    # 1. 교차 표(Contingency Table) 생성 (행: Cluster ID, 열: 실제 종 이름)
    df_counts = pd.crosstab(
        index=cluster_labels, 
        columns=y_true_names, 
        rownames=['Cluster ID'], 
        colnames=['Actual Class']
    )
    
    # 2. 비율 표(Percentage Table) 생성 (각 클러스터 내부에서의 백분율)
    df_pct = pd.crosstab(
        index=cluster_labels, 
        columns=y_true_names, 
        normalize='index'
    ) * 100

    print_section("클러스터별 실제 클래스 분포 (개수)")
    print(df_counts)
    
    print_section("클러스터별 실제 클래스 구성 비율 (%)")
    print(df_pct.round(1).astype(str) + '%')
    
    # 3. 추가 인사이트: 각 클러스터의 '순도(Purity)' 계산 및 요약
    print("\n--- 클러스터별 주요 구성 요약 ---")
    for cluster_id in df_counts.index:
        row = df_counts.loc[cluster_id]
        total_samples = row.sum()
        most_common_class = row.idxmax()
        most_common_count = row.max()
        purity = (most_common_count / total_samples) * 100
        
        print(f"Cluster {cluster_id}: 총 {total_samples}개 데이터 추출 -> "
              f"주요 종: '{most_common_class}' ({most_common_count}개, 순도: {purity:.1f}%)")

import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from sklearn.cluster import KMeans
from sklearn.decomposition import PCA
from sklearn.preprocessing import StandardScaler

# PCA 결과를 히트맵으로 시각화하는 함수
def plot_pca_heatmap(pca):
    # 주성분 계수(Components) 추출
    # pca.components_ 는 [n_components, n_features] 형태의 행렬입니다.
    loadings = pd.DataFrame(
        pca.components_.T, 
        columns=['PC1', 'PC2', 'PC3'], 
        index=FEATURE_COLS
    )

    print("--- 주성분별 특성 기여도 (Loadings) ---")
    print(loadings)

    # 4. 히트맵 시각화
    plt.figure(figsize=(8, 6))
    sns.heatmap(loadings, annot=True, cmap='RdBu', center=0)
    plt.title('PCA Component Heatmap')
    plt.show()

# 랜덤 포레스트 등에서 확인된 상위 3개 특성 인덱스 (예시: 0, 2, 4)
top_3_indices = [0, 1, 2]
feature_names_3 = [FEATURE_COLS[i] for i in top_3_indices]

def plot_kmeans_matplotlib(X_train_scaled, k=5):
    # --- 방식 A: 주요 특성 3개 선택 ---
    X_selected = X_train_scaled[:, top_3_indices]
    kmeans_sel = KMeans(n_clusters=k, random_state=42, n_init=10)
    labels_sel = kmeans_sel.fit_predict(X_selected)

    # print("--- K-means 클러스터링 결과 (Feature Selection) ---")
    # print(labels_sel)

    print_section(f"주요 특성을 이용한 클러스터링 성능 분석")
        
    # 정확도 계산 및 매핑 출력
    # acc = calculate_cluster_accuracy(y_train, labels_sel)
    # print(f"{'='*60}")
    # print(f"최종 클러스터링 일치도: {acc:.2%}")

    print_cluster_distribution(y_train, labels_sel)

    # --- 방식 B: PCA 기반 3차원 생성 ---
    pca = PCA(n_components=3)
    X_pca = pca.fit_transform(X_train_scaled)

    # PCA 기반 2차원 생성 및 히트맵 시각화 (주성분별 특성 기여도 확인)
    plot_pca_heatmap(pca)

    kmeans_pca = KMeans(n_clusters=k, random_state=42, n_init=10)
    labels_pca = kmeans_pca.fit_predict(X_pca)

    print_section(f"PCA를 이용한 클러스터링 성능 분석")
        
    # 정확도 계산 및 매핑 출력
    # acc = calculate_cluster_accuracy(y_train, labels_pca)
    # print(f"{'='*60}")
    # print(f"최종 클러스터링 일치도: {acc:.2%}")

    print_cluster_distribution(y_train, labels_pca)

    # 시각화 설정
    fig = plt.figure(figsize=(14, 6))
    
    # 1번 보조그래프: Feature Selection
    ax1 = fig.add_subplot(121, projection='3d')
    scatter1 = ax1.scatter(X_selected[:, 0], X_selected[:, 1], X_selected[:, 2], 
                           c=labels_sel, cmap='viridis', s=20, alpha=0.6)
    ax1.set_title(f'Feature Selection (Top 3)\nK-means (k={k})')
    ax1.set_xlabel(feature_names_3[0])
    ax1.set_ylabel(feature_names_3[1])
    ax1.set_zlabel(feature_names_3[2])

    # 2번 보조그래프: PCA Extraction
    ax2 = fig.add_subplot(122, projection='3d')
    scatter2 = ax2.scatter(X_pca[:, 0], X_pca[:, 1], X_pca[:, 2], 
                           c=labels_pca, cmap='plasma', s=20, alpha=0.6)
    ax2.set_title(f'PCA Extraction (3 Components)\nK-means (k={k})')
    ax2.set_xlabel('PC1')
    ax2.set_ylabel('PC2')
    ax2.set_zlabel('PC3')

    plt.tight_layout()
    plt.show()

# --- 메인 실행 흐름 ---
if __name__ == "__main__":
    # 데이터 준비
    data = prepare_data()
    X = data[FEATURE_COLS].values
    y = data[LABEL_COL].values
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42, stratify=y)
    # 데이터 준비 및 스케일링
    scaler = StandardScaler()
    X_scaled = scaler.fit_transform(X_train)

    # 사용 예시: k를 2에서 5까지 변경하며 호출 가능
    while True :
        k_val = int(input("k 값을 입력하세요 (2-5, 종료하려면 0): "))
        if k_val == 0:
            break
        plot_kmeans_matplotlib(X_scaled, k=k_val)