# yolo object detection predict() : 파일 입력을 이용한 예측

from ultralytics import YOLO

# YOLO pretrained model을 이용한 예측
model = YOLO('yolov8n.pt')
result = model.predict(source='Images4YOLO/test/images', conf=0.5, show=True)               
#result = model.predict(source='d:/fish/test/images', conf=0.5, show=True)

# 열대어 이미지로 학습된 모델을 이용한 예측
# model = YOLO('D:\\Fish\\runs\\detect\\train\\weights\\best.pt')
# result = model.predict(source='d:/fish/test/images', conf=0.5, show=False, verbose=False)  

# result 객체의 구조 이해,
input("Press Enter to show result[0]...")
print (result[0])
input("Press Enter to show result[0].boxes...")
print (result[0].boxes)

# for i, r in enumerate(result):
#     print (i, r)
#     input("Press Enter to continue...")
#     print (r.boxes)
#     input("Press Enter to continue...")

# tensor() 출력을 python list 와 numpy array로 반환하는 방법 확인
import numpy as np

for i, r in enumerate(result):
    print (i, " : ", r.boxes.cls)
    
    try :
        print (r.boxes.cls.item())
    except Exception as e:
        print (e)
        
    print (r.boxes.cls.tolist())
    print (r.boxes.cls.numpy())
    input("Press Enter to continue...")
