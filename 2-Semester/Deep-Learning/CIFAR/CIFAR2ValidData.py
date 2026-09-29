import os
import torchvision
import torchvision.transforms as transforms
from PIL import Image

# 저장할 폴더 경로
output_dir = 'F:/CIFARcustom/valid'

# CIFAR-10 클래스 이름 (순서대로)
classes = ['airplane', 'automobile', 'bird', 'cat', 'deer',
           'dog', 'frog', 'horse', 'ship', 'truck']

# 변환: PIL 이미지로 유지 (Tensor로 변환 X)
transform = transforms.Compose([
    transforms.ToPILImage()
])

# CIFAR-10 train 데이터셋 로드
validset = torchvision.datasets.CIFAR10(root='./CIFAR10', train=False,
                                        download=True, transform=transforms.ToTensor())

# 클래스별 폴더 생성
for class_name in classes:
    class_dir = os.path.join(output_dir, class_name)
    os.makedirs(class_dir, exist_ok=True)

# 이미지 저장
print("Saving CIFAR-10 images...")
for idx, (img_tensor, label) in enumerate(validset):

    if idx >= int(len(validset)/10) : break # 10% 데이터만 사용
    
    class_name = classes[label]
    class_dir = os.path.join(output_dir, class_name)
    
    # 텐서를 PIL 이미지로 변환
    img = transforms.ToPILImage()(img_tensor)
    
    # 파일명 지정
    filename = f"{idx:05d}.png"
    img.save(os.path.join(class_dir, filename))

    # (옵션) 진행 표시
    if idx % 100 == 0:
        print(f"Saved {idx+100} images...")


print("Creating image files completed..")
