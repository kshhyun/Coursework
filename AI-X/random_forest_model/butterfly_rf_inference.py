#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import joblib
import warnings

# 경고 메시지 무시
warnings.filterwarnings('ignore')

# --- 설정 및 상수 ---
# 학습 시 사용했던 클래스 명칭과 동일하게 설정
CLASS_NAMES = {1: '제비나비', 2: '왕오색나비', 3: '흰나비', 4: '박각시나방', 5: '누에나방'}

def run_inference(model):
    """
    저장된 모델을 사용하여 사용자로부터 데이터를 입력받아 추론을 수행합니다.
    """
    print("\n" + "="*60)
    print("  곤충 분류 AI 추론 모드")
    print("="*60)
    print("  입력 순서: [날개밝기, 날개무늬, 몸통두께, 더듬이모양, 날개비율, 크기]")
    print("  (각 항목에 1~5 사이의 정수를 입력하고 공백으로 구분하세요)")
    print("  예: 3 2 5 1 4 2")
    print("  종료하려면 Enter를 누르세요.")

    while True:
        raw = input("\n  데이터 입력 > ").strip()
        
        # 엔터만 입력 시 종료
        if not raw: 
            print("  프로그램을 종료합니다.")
            break
            
        try:
            # 입력 문자열을 정수 리스트로 변환
            vals = list(map(int, raw.split()))
            
            # 특성 개수 확인 (6개)
            if len(vals) != 6:
                print(f"  [오류] 6개의 숫자가 필요합니다. (현재 {len(vals)}개 입력됨)")
                continue
            
            # 모델 추론
            # sklearn 모델은 2차원 배열 형태 [[...]] 를 기대합니다.
            pred = model.predict([vals])[0]
            proba = model.predict_proba([vals])[0]
            
            # 결과 출력
            result_name = CLASS_NAMES.get(pred, "알 수 없는 종")
            confidence = max(proba) * 100
            
            print(f"  [결과] 이 곤충은 【{result_name}】로 예측됩니다.")
            print(f"  [신뢰도] {confidence:.1f}%")
            
        except ValueError:
            print("  [오류] 숫자만 입력 가능합니다.")
        except Exception as e:
            print(f"  [오류] 예상치 못한 문제가 발생했습니다: {e}")

if __name__ == "__main__":
    model_path = './random_forest_model.pkl'
    
    try:
        # 1. 저장된 모델 로드
        model = joblib.load(model_path)
        print(f"모델 '{model_path}'을(를) 성공적으로 불러왔습니다.")
        
        # 2. 추론 실행
        run_inference(model)
        
    except FileNotFoundError:
        print(f"[오류] '{model_path}' 파일을 찾을 수 없습니다. 먼저 학습 코드를 실행하여 모델을 생성하세요.")
    except Exception as e:
        print(f"[오류] 모델을 로드하는 중 문제가 발생했습니다: {e}")