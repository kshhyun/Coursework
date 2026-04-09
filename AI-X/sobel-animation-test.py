import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation

# 1. 가상의 이미지 데이터 생성 (9x9 십자가 모양)
image = np.array([
    [200, 200, 200,  200, 200, 200, 200, 200, 200], # 세로 기둥 (두께 2)
    [200, 200, 200,  50,  50, 50, 200, 200, 200],
    [200, 200, 200,  50,  0, 50, 200, 200, 200],
    [200,  50,  50, 50,  0,  50,  50,  50,  200], # 가로 막대 (두께 2)
    [200,  50,  0, 0,  0,  0,  0,  50,  200],
    [200,  50,  50,  50,  0,  50,  50,  50,  200],
    [200, 200, 200, 50,  0,  50, 200, 200, 200],
    [200, 200, 200, 50,  50,  50, 200, 200, 200],
    [200, 200, 200, 200, 200, 200, 200, 200, 200]
])

def show_image_with_values(img, title, boundary_color=False):
    plt.figure(figsize=(8, 8))
    plt.imshow(img, cmap='gray', vmin=0, vmax=255)
    plt.title(title)
    
    rows, cols = img.shape
    
    for i in range(rows):
        for j in range(cols):
            # 1. 가장자리 여부 판단 (첫 행/열 이거나 마지막 행/열인 경우)
            is_boundary = (i == 0 or i == rows - 1 or j == 0 or j == cols - 1)
            
            # 2. 텍스트 색상 결정
            if boundary_color and is_boundary:
                text_color = "red"
            else:
                # 기존 로직: 배경 밝기에 따라 흰색/검은색 반전
                text_color = "white" if img[i, j] < 128 else "black"
            
            # 3. 텍스트 출력
            plt.text(j, i, str(int(img[i, j])), 
                     ha="center", va="center", 
                     color=text_color, fontweight='bold' if is_boundary else 'normal')
            
    plt.show()

show_image_with_values(image, "Original Image (9x9)")

rows, cols = image.shape
pad_h, pad_w = 1, 1
padded_image = np.zeros((rows + 2*pad_h, cols + 2*pad_w), dtype=image.dtype)

# Replicate Padding 적용 (9x9 -> 11x11)
for i in range(rows + 2*pad_h):
    for j in range(cols + 2*pad_w):
        # 행 인덱스 계산
        r = i - pad_h
        if r < 0: 
            r = 0  # 첫 번째 행 값으로 고정
        elif r >= rows: 
            r = rows - 1  # 마지막 행 값으로 고정
        
        # 열 인덱스 계산
        c = j - pad_w
        if c < 0: 
            c = 0  # 첫 번째 열 값으로 고정
        elif c >= cols: 
            c = cols - 1  # 마지막 열 값으로 고정

        padded_image[i, j] = image[r, c]

show_image_with_values(padded_image, "Padded Image Image (11 x 11)", True)

# 가로 커널
kernel_h = np.array([
    [-1, -2, -1],
    [ 0,  0,  0],
    [ 1,  2,  1]
])

# 세로 커널
kernel_v = np.array([
    [-1, 0, 1],
    [-2, 0, 2],
    [-1, 0, 1]
])

# 3. Threshold 300 -> 200 수정
threshold = 200 

# 결과 배열 초기화 (Raw 결과와 Threshold 결과 두 가지 준비)
res_rows, res_cols = rows, cols
raw_result = np.zeros((res_rows, res_cols))
threshold_result = np.zeros((res_rows, res_cols))

# 시각화 설정 (1행 3열 구성)
fig, (ax1, ax2, ax3) = plt.subplots(1, 3, figsize=(18, 6))

def update(frame):
    ax1.clear()
    ax2.clear()
    ax3.clear()
    
    r = frame // res_cols
    c = frame % res_cols
    
    # 1. 패딩된 입력 이미지 출력
    ax1.imshow(padded_image, cmap='gray', vmin=0, vmax=255)
    for (i, j), val in np.ndenumerate(padded_image):
        is_padding = (i == 0 or i == rows+1 or j == 0 or j == cols+1)
        txt_color = 'green' if is_padding else ('red' if val < 128 else 'blue')
        ax1.text(j, i, str(int(val)), ha='center', va='center', color=txt_color, fontsize=7)
    
    rect = plt.Rectangle((c - 0.5, r - 0.5), 3, 3, linewidth=2, edgecolor='red', facecolor='none')
    ax1.add_patch(rect)
    ax1.set_title(f"1. Padded Input (11x11)\nStep: {frame+1}")

    # 컨볼루션 연산
    region = padded_image[r:r+3, c:c+3]
    
    grad_h = np.sum(region * kernel_h) # 가로 차이 계산
    grad_v = np.sum(region * kernel_v) # 세로 차이 계산
    
    # 가로, 세로 차이 합산
    total_grad = abs(grad_h) + abs(grad_v)
    
    # 데이터 업데이트
    raw_result[r, c] = total_grad
    threshold_result[r, c] = 255 if total_grad > threshold else 0

    # 2. Raw Sobel 결과 (절대값 적용)
    # vmin/vmax를 설정하여 변화량을 시각적으로 잘 보이게 함
    ax2.imshow(raw_result, cmap='viridis', vmin=0, vmax=1000) 
    for (i, j), val in np.ndenumerate(raw_result):
        if i < r or (i == r and j <= c):
            ax2.text(j, i, f"{int(val)}", ha='center', va='center', color='white', fontsize=7)
    ax2.set_title(f"2. Raw Sobel (H+V Combined)\nValue: {int(total_grad)}")

    # 3. Threshold 적용 결과 (이진화)
    ax3.imshow(threshold_result, cmap='gray', vmin=0, vmax=255)
    for (i, j), val in np.ndenumerate(threshold_result):
        if i < r or (i == r and j <= c):
            ax3.text(j, i, f"{int(val)}", ha='center', va='center', color='green', fontsize=7)
    ax3.set_title(f"3. Threshold Output\nThreshold: {threshold}")

    for ax in [ax1, ax2, ax3]:
        ax.set_xticks([]); ax.set_yticks([])

# 애니메이션 실행
ani = FuncAnimation(fig, update, frames=res_rows * res_cols, interval=150, repeat=False)
plt.tight_layout()
plt.show()