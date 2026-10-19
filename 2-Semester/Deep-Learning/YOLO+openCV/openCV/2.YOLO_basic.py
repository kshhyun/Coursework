from ultralytics import YOLO

model = YOLO ('Images4YOLO/runs/detect/train/weights/best.pt')

frameCount = 0
result = model.predict(source='Images4YOLO/mp4/fish2.mp4', show=True, verbose=False, stream=True, conf=0.7, imgsz=640)

for res in result :

    if (res.boxes) :
        print(f"FrameCount = {frameCount}, {res.boxes.data.cpu().numpy()}")
            
    frameCount += 1













