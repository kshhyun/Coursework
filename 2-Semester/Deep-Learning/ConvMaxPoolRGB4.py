# -*- coding: utf-8 -*-

import torch
import torch.nn as nn
import torch.nn.functional as F
import matplotlib.pyplot as plt
from PIL import Image
from torchvision import transforms

class SimpleCNN(nn.Module):
    def __init__(self):
        super(SimpleCNN, self).__init__()
        self.conv1 = nn.Conv2d(3, 8, kernel_size=3, padding=1)  # RGB 입력을 처리하기 위해 채널 수를 3으로 변경
        self.conv2 = nn.Conv2d(8, 16, kernel_size=3, padding=1)
        self.conv3 = nn.Conv2d(16, 32, kernel_size=3, padding=1)
        self.pool = nn.MaxPool2d(2, 2)
        
        self.fc1 = nn.Linear(32 * 8 * 8, 128)  # 첫 번째 fully connected layer
        self.fc2 = nn.Linear(128, 64)  # 두 번째 fully connected layer
        self.fc3 = nn.Linear(64, 32)  # 세 번째 fully connected layer
        self.fc4 = nn.Linear(32, 10)  # 최종 출력 layer

        # 중간 출력을 저장하기 위해 활성화 리스트
        self.activations = []

    def register_hooks(self):
        # 각 합성곱 레이어 후 출력 저장을 위한 hook 등록
        self.conv1.register_forward_hook(self.save_activation("conv1"))
        self.conv2.register_forward_hook(self.save_activation("conv2"))
        self.conv3.register_forward_hook(self.save_activation("conv3"))

    def save_activation(self, name):
        def hook(module, input, output):
            self.activations.append((name, output))
        return hook

    def forward(self, x):
        x = self.pool(F.relu(self.conv1(x)))  # 첫 번째 합성곱
        x = self.pool(F.relu(self.conv2(x)))  # 두 번째 합성곱
        x = self.pool(F.relu(self.conv3(x)))  # 세 번째 합성곱

        # 텐서를 벡터로 평탄화
        x = x.view(-1, 32 * 8 * 8)
        x = F.relu(self.fc1(x))
        x = F.relu(self.fc2(x))
        x = F.relu(self.fc3(x))
        x = self.fc4(x)
        return x

# 모델 인스턴스 생성
model = SimpleCNN()

# hook 등록
model.register_hooks()

# 이미지 로드 및 전처리 함수
def load_image(image_path):
    # 이미지를 RGB로 로드
    img = Image.open(image_path).convert('RGB')  # RGB로 변환

    # 변환 정의 (크기 조정, 텐서로 변환, 정규화)
    transform = transforms.Compose([
        transforms.Resize((64, 64)),  # 크기를 28x28로 조정 (MNIST와 유사)
        transforms.ToTensor(),        # 텐서로 변환 (값 범위 [0, 1])
        transforms.Normalize(mean=[0.5, 0.5, 0.5], std=[0.5, 0.5, 0.5])  # 정규화
    ])

    # 변환 적용
    img_tensor = transform(img)
    
    # 배치 차원 추가 (1, 3, 64, 64)
    img_tensor = img_tensor.unsqueeze(0)
    
    return img_tensor

# 이미지 경로 지정
image_path = "./image.jpg"  # 자신의 이미지 경로로 변경

# 이미지 로드 및 전처리
input_image = load_image(image_path)

# 네트워크를 통해 이미지 전달
output = model(input_image)

# 특성 맵 시각화 함수 (RGB 채널 분리)
def plot_feature_maps():

    for name, activation in model.activations:

        num_filters = activation.shape[1]  # 채널(필터) 수
        fig, axes = plt.subplots(8, int(num_filters/8), figsize=(20,15))  # 3개의 레이어, 8개의 필터
        axes = axes.flatten()  # (3 * 8) 크기의 1D 배열로 변환
        #print (" Number filters ", num_filters)
        filter_count = 0
        for i in range(num_filters):
            #print (i, filter_count)
            ax = axes[filter_count]
            # 활성화 맵을 numpy 배열로 변환 후 출력
            ax.imshow(activation[0, i].cpu().detach().numpy(), cmap='viridis')
            ax.axis('off')
            ax.set_title(f"{name} - Filter {i + 1}")
            filter_count += 1
    
        plt.tight_layout()
        plt.show()

# 오리지널 이미지 시각화
def plot_original_image(image_path):
    img = Image.open(image_path).convert('RGB')  # RGB로 변환
    plt.imshow(img)
    plt.title("Original Image")
    plt.axis('off')
    plt.show()


import matplotlib.pyplot as plt

def print_filter_values():
    # conv1의 필터 값 출력
    conv1_weights = model.conv1.weight.data
    print("Conv1 Filters (Weight values):")
    for i in range(conv1_weights.shape[0]):  # 필터의 수만큼 반복
        print(f"Filter {i + 1}:")
        print(conv1_weights[i].detach().cpu().numpy())  # 각 필터의 가중치 출력
        print("\n")

    # conv1 필터 시각화
    fig, axes = plt.subplots(conv1_weights.shape[0], 1,  figsize=(20, 5))  # 필터 수만큼 서브플롯
    if conv1_weights.shape[0] == 1:  # 1개의 필터일 경우 axes가 2D 배열이 아니므로 처리
        axes = [axes]
    
    for i in range(conv1_weights.shape[0]):  # 필터 수만큼 반복
        ax = axes[i]
        # 필터의 가중치 시각화 (첫 번째 채널을 사용)
        ax.imshow(conv1_weights[i].detach().cpu().numpy()[0], cmap='viridis')  # 필터의 가중치 시각화
        ax.axis('off')
        ax.set_title(f"Conv1 - Filter {i + 1}")
    
    plt.tight_layout()
    
    # 모든 필터가 그려진 후 한 번에 화면에 표시
    plt.show()

    # conv2의 필터 값 출력
    conv2_weights = model.conv2.weight.data
    print("Conv2 Filters (Weight values):")
    for i in range(conv2_weights.shape[0]):
        print(f"Filter {i + 1}:")
        print(conv2_weights[i].detach().cpu().numpy())
        print("\n")

    # conv2 필터 시각화
    #fig, axes = plt.subplots(1, conv2_weights.shape[0], figsize=(20, 5))  # 필터 수만큼 서브플롯
    #fig, axes = plt.subplots(2,8, figsize=(20, 5))  # 필터 수만큼 서브플롯
    
    num_filters = conv2_weights.shape[0]  # 필터 개수
    num_rows = 8  # 한 줄에 표시할 필터 수 (가로 표시를 세로 표시로 바꾸어 row.column 의미 반전되어 있음.
    num_columns = (num_filters + num_rows - 1) // num_rows  # 필터 개수에 맞게 행 수 계산

    fig, axes = plt.subplots(num_rows, num_columns, figsize=(20, 5 * num_rows))  # 여러 행과 열로 서브플롯 생성
    axes = axes.flatten()  # 2D 배열을 1D 배열로 변환하여 쉽게 인덱싱
    
    if conv2_weights.shape[0] == 1:  # 1개의 필터일 경우 axes가 2D 배열이 아니므로 처리
        axes = [axes]
    
    for i in range(conv2_weights.shape[0]):
        ax = axes[i]
        ax.imshow(conv2_weights[i].detach().cpu().numpy()[0], cmap='viridis')  # 필터의 가중치 시각화
        ax.axis('off')
        ax.set_title(f"Conv2 - Filter {i + 1}")
    
    plt.tight_layout()
    plt.show()  # 모든 필터가 그려진 후 한 번에 화면에 표시

    # conv3의 필터 값 출력
    conv3_weights = model.conv3.weight.data
    print("Conv3 Filters (Weight values):")
    for i in range(conv3_weights.shape[0]):
        print(f"Filter {i + 1}:")
        print(conv3_weights[i].detach().cpu().numpy())
        print("\n")

    # conv3 필터 시각화
    #fig, axes = plt.subplots(1, conv3_weights.shape[0], figsize=(20, 5))  # 필터 수만큼 서브플롯
    #fig, axes = plt.subplots(4,8, figsize=(20, 5))  # 필터 수만큼 서브플롯

    num_filters = conv3_weights.shape[0]  # 필터 개수
    num_rows = 8  # 한 줄에 표시할 필터 수
    num_columns = (num_filters + num_rows - 1) // num_rows  # 필터 개수에 맞게 행 수 계산

    fig, axes = plt.subplots(num_rows, num_columns, figsize=(20, 5 * num_rows))  # 여러 행과 열로 서브플롯 생성
    axes = axes.flatten()  # 2D 배열을 1D 배열로 변환하여 쉽게 인덱싱

    if conv3_weights.shape[0] == 1:  # 1개의 필터일 경우 axes가 2D 배열이 아니므로 처리
        axes = [axes]
    
    for i in range(conv3_weights.shape[0]):
        ax = axes[i]
        ax.imshow(conv3_weights[i].detach().cpu().numpy()[0], cmap='viridis')  # 필터의 가중치 시각화
        ax.axis('off')
        ax.set_title(f"Conv3 - Filter {i + 1}")
    
    plt.tight_layout()
    plt.show()  # 모든 필터가 그려진 후 한 번에 화면에 표시



# 오리지널 이미지 출력
plot_original_image(image_path)

# 특성 맵 시각화
plot_feature_maps()

# 필터 값 출력
print_filter_values()
