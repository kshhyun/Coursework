import numpy as np
import matplotlib.pyplot as plt
import platform

# 1. 한글 폰트 설정
if platform.system() == 'Windows':
    plt.rc('font', family='Malgun Gothic')
elif platform.system() == 'Darwin':
    plt.rc('font', family='AppleGothic')
plt.rcParams['axes.unicode_minus'] = False

# 2. 2x2 변환 행렬 및 이동 벡터 생성 함수
def get_rotate_matrix(angle_deg):
    theta = np.radians(angle_deg)
    c, s = np.cos(theta), np.sin(theta)
    return np.array([[c, -s], [s, c]]) # 2x2 회전

def get_scale_matrix(sx, sy):
    return np.array([[sx, 0], [0, sy]]) # 2x2 스케일

def get_shear_matrix(shx, shy):
    return np.array([[1, shx], [shy, 1]]) # 2x2 밀림

# 3. 메인 프로그램
def main():
    square = np.array([
        [0, 1, 1, 0], # x
        [0, 0, 1, 1]  # y
    ])
    
    original = square.copy() # 원본 보관용

    print("명령어: T(이동-덧셈), S(스케일-곱셈), R(회전-곱셈), H(밀림-곱셈), 엔터(종료)")
    
    while True:
        op = input("\n변환 종류 입력: ").upper()
        if not op: break

        if op == 'T':
            tx, ty = map(float, input("  x, y 이동 거리 (공백 구분): ").split())
            # 행렬 덧셈 (Broadcasting 이용)
            t_vector = np.array([[tx], [ty]])
            square = square + t_vector
            print(f">> 이동 적용: 현재 좌표에 x+{tx}, y+{ty} 더함")

        elif op == 'S':
            sx, sy = map(float, input("  x, y 확대 배율 (공백 구분): ").split())
            # 2x2 행렬 곱셈
            square = get_scale_matrix(sx, sy) @ square

        elif op == 'R':
            angle = float(input("  회전 각도 (도): "))
            # 2x2 행렬 곱셈
            square = get_rotate_matrix(angle) @ square

        elif op == 'H':
            shx, shy = map(float, input("  x, y 밀림 계수 (공백 구분): ").split())
            # 2x2 행렬 곱셈
            square = get_shear_matrix(shx, shy) @ square

    # --- 시각화 ---
    plt.figure(figsize=(8, 8))
    
    # 닫힌 삼각형을 만들기 위해 첫 점을 끝에 추가
    orig_p = np.append(original, original[:, [0]], axis=1)
    trans_p = np.append(square, square[:, [0]], axis=1)
    
    plt.plot(orig_p[0, :], orig_p[1, :], '--', color='blue', label='원본', alpha=0.4)
    plt.plot(trans_p[0, :], trans_p[1, :], 'r-o', label='변환 후', linewidth=2)
    
    plt.axhline(0, color='black', linewidth=1)
    plt.axvline(0, color='black', linewidth=1)
    plt.grid(True, linestyle='--')
    plt.legend()
    plt.title("2D Direct Transformation (Addition & Multiplication)")
    plt.axis('equal')
    plt.show()

if __name__ == "__main__":
    main()