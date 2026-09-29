import torch
import torch.nn.functional as F
import torchvision.transforms as transforms
import cv2
import numpy as np
from PIL import Image
import mss
import time
from model import CNN

# CIFAR-10 클래스 이름
class_names = ['airplane', 'automobile', 'bird', 'cat', 'deer',
               'dog', 'frog', 'horse', 'ship', 'truck']

target_class_id = int(input("Target Class to search : "))
print (f'{class_names[target_class_id]} will be searched.')
confidence_threshold = 0.80

# 모델 로드
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
model = CNN().to(device)
model.load_state_dict(torch.load("cifar10_cnn.pth", map_location=device))
model.eval()

transform = transforms.Compose([
    transforms.Resize((32, 32)),
    transforms.ToTensor(),
])

def predict_grid(img_patch):
    img_pil = Image.fromarray(cv2.cvtColor(img_patch, cv2.COLOR_BGR2RGB))
    input_tensor = transform(img_pil).unsqueeze(0).to(device)
    with torch.no_grad():
        output = model(input_tensor)
        probs = F.softmax(output, dim=1)
        #print (probs)
        confidence, predicted = torch.max(probs, 1)
    return predicted.item(), confidence.item()

def main():
    grid_size_all = {48, 40, 32}
    print(grid_size_all)
    
    with mss.mss() as sct:
        
      monitor = sct.monitors[1]  # 두 번째 모니터
      
      img = np.array(sct.grab(monitor))
      frame = cv2.cvtColor(img, cv2.COLOR_BGRA2BGR)
      h, w, _ = frame.shape

      for grid_size in grid_size_all :

            print("Grid Size ", grid_size)

            stride = grid_size // 4

            output_frame = frame.copy()

            for y in range(0, h - grid_size + 1, stride):
                for x in range(0, w - grid_size + 1, stride):
                    patch = frame[y:y+grid_size, x:x+grid_size]

                    # 녹색 힌트 박스 표시 (0.05초)
                    temp_frame = output_frame.copy()
                    cv2.rectangle(temp_frame, (x, y), (x + grid_size, y + grid_size), (0, 0, 255), 2)
                    cv2.imshow("Target Class Detection", temp_frame)
                    cv2.waitKey(2)
                    #time.sleep(0.01)  # 짧은 시간만 녹색 박스 표시

                    # 예측
                    pred_class, conf = predict_grid(patch)

                    # 조건 만족 시 빨간 박스로 다시 그리기
                    if pred_class == target_class_id and conf >= confidence_threshold:
                        print("Found : ", x,y)
                        class_name = class_names[pred_class]
                        cv2.rectangle(output_frame, (x, y), (x + grid_size, y + grid_size), (255, 0, 0), 3)
                        cv2.putText(output_frame, f"{class_name} ({conf*100:.1f}%)",
                                    (x + 5, y + 20), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 255), 1)

            # 최종 결과 출력
            window_name = "Target Class Detection"
            cv2.namedWindow(window_name, cv2.WINDOW_NORMAL)
            cv2.moveWindow(window_name, monitor["left"], monitor["top"])
            cv2.imshow(window_name, output_frame)

            print("Finished. Press <space>")
            
            if cv2.waitKey(0) & 0xFF == 27:  # ESC
                cv2.destroyAllWindows()
                break
            cv2.destroyAllWindows()



if __name__ == "__main__":
    main()
