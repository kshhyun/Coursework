import torch
import torchvision
import torchvision.transforms as transforms
import matplotlib.pyplot as plt
import numpy as np

# 1. Transform 정의 (Tensor 변환 + 정규화)
transform = transforms.Compose([
    transforms.ToTensor(),  # [0,1] 범위로 변환
    transforms.Normalize((0.5, 0.5, 0.5), (0.5, 0.5, 0.5))  # 정규화
])


N = 7
# 2. CIFAR-10 데이터셋 로드 (Train set)
trainset = torchvision.datasets.CIFAR10(root='./CIFAR10', train=True,
                                        download=True, transform=transform)

trainloader = torch.utils.data.DataLoader(trainset, batch_size=N*N,
                                          shuffle=True, num_workers=0)

print ("CIFAR dataset loaded")
# 3. 클래스 이름
classes = ('plane', 'car', 'bird', 'cat',
           'deer', 'dog', 'frog', 'horse', 'ship', 'truck')

# 4. n x n 매트릭스 형태로 시각화 함수
def show_images_grid(images, labels, n=5):
    plt.figure(figsize=(n, n))  # 전체 크기 조정
    for i in range(n * n):
        img = images[i] / 2 + 0.5  # 정규화 해제
        npimg = img.numpy()
        npimg = img.numpy()
        npimg = np.transpose(npimg, (1, 2, 0))  # CHW → HWC

        plt.subplot(n, n, i + 1)
        plt.imshow(npimg)
        plt.title(classes[labels[i]])
        plt.axis('off')
    plt.tight_layout()
    plt.show()

# 5. 데이터 가져오기 및 출력
dataiter = iter(trainloader)
images, labels = next(dataiter)

# 6. 5x5 그리드로 이미지 출력

show_images_grid(images, labels, n=N)
