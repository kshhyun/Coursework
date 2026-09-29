import torch
import torch.nn as nn
import torch.nn.functional as F
import torch.optim as optim
import torchvision
import torchvision.transforms as transforms
from torch.utils.data import DataLoader
import matplotlib.pyplot as plt

import cv2
import numpy as np
from PIL import Image

from model import CNN

# CIFAR-10 클래스 이름
class_names = ['airplane', 'automobile', 'bird', 'cat', 'deer',
               'dog', 'frog', 'horse', 'ship', 'truck']


# 모델 로드
model = CNN()
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
model.load_state_dict(torch.load("cifar10_cnn.pth", map_location=device))
model.eval()

# 입력 이미지 전처리 
def preprocess_image(image_path):
    img = Image.open(image_path).convert("RGB")  # 항상 RGB
    img = img.resize((32, 32))
    
    # 시각화를 위한 원본 복사
    img_np = np.array(img)  # [H, W, C] (정규화 전)

    # 정규화 및 텐서 변환
    img = np.array(img) / 255.0
    img = torch.tensor(img, dtype=torch.float32)
    img = img.permute(2, 0, 1)  # [C, H, W]
    img = img.unsqueeze(0)      # [1, C, H, W]

    # 이미지 시각화
    plt.imshow(img_np)
    plt.title("Preprocessed Input Image")
    plt.axis('off')
    plt.show()

    return img



def predict(image_path):
    img = preprocess_image(image_path)
    img = img.to(device)

    with torch.no_grad():
        output = model(img)  # [1, 10]
        probs = F.softmax(output, dim=1)  # 확률로 변환
        confidence, predicted = torch.max(probs, 1)

    predicted_class = class_names[predicted.item()]
    confidence_value = confidence.item()

    #print(f"인식된 객체 클래스 : {predicted_class}")
    #print(f"Confidence : {confidence_value:.4f}")  # 소수점 4자리 출력

    return predicted_class, confidence_value

# 손글씨 숫자 이미지 경로 지정
while True :
    image_path = input ("Image file : ")    # 솔글씨 이미지 파일명 입력
    predicted, conf = predict(image_path)
    conf = conf * 100
    print("인식된 객체 클래스 : ", predicted, f"확률 : {conf:.2f} %")
