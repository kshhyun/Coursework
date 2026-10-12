from ultralytics import YOLO
model = YOLO ('d:/fish/runs/detect/train/weights/best.pt')
result = model.predict(source='d:/fish/test/images/', show=False, verbose=False)

# source에서 입력받은 이미지 갯수 만큼 결과가 ultralytics에서 정의한 object로 출력됨
print (len(result))

# 첫번재 이미지에 대한 결과
one = result[0]

print(dir(one))
print(dir(one.boxes))
print(dir(one.boxes.__dict__))
input("Press Enter to continue...")

# object 내의 속성을 출력 --> 실졔 predict의 결과를 사용하기 속성 이름 알아보기
print (one.__dict__.keys())
# dict_keys(['orig_img', 'orig_shape', 'boxes', 'masks', 'probs', 'keypoints', 'obb', 'speed', 'names', 'path', 'save_dir', '_keys'])

# boxes 속성이 가지고 있는 속성 이름 알라보기
print (one.boxes.__dict__.keys())
# dict_keys(['data', 'orig_shape', 'is_track'])
print (one.boxes.__dict__.items())

print(one.boxes.data)
input("Press Enter to continue...")

print (one.names)
# {0: 'blue-tang', 1: 'butterflyfish', 2: 'clownfish', 3: 'moorish-idol', 4: 'neon-tetra', 5: 'ribboned-sweetlips', 6: 'yellow-tang'}

# data 속성값 출력 : 실제 인식 결과
print ("one.boxes.data : ")
print (one.boxes.data)
# tensor([[1.9634e+02, 2.5268e+02, 3.9654e+02, 4.0087e+02, 9.6125e-01, 0.0000e+00],
#         [1.4404e-02, 4.8879e+02, 1.8391e+02, 6.3993e+02, 9.5861e-01, 6.0000e+00]])
print (one.boxes.data.cpu().numpy())
# [[     196.48      252.85      397.24      400.53       0.984           0] <-- 0 번 class : blue_tang
#  [          0      489.67      185.67         640     0.98331           6]]<-- 6 번 class : yellow_tang
# [x, y, x, y, confidence, cls]

print (one.to_json())
print (one.to_html())
