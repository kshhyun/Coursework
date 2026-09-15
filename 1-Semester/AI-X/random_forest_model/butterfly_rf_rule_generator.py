#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import pickle
import warnings
import numpy as np
from sklearn.ensemble import RandomForestClassifier

warnings.filterwarnings('ignore')

# --- 설정 및 상수 ---
CLASS_NAMES = {1: '제비나비', 2: '왕오색나비', 3: '흰나비', 4: '박각시나방', 5: '누에나방'}
FEATURE_COLS = ['wing_color_brightness', 'wing_pattern_complexity', 'body_thickness', 
                'antenna_shape', 'wing_aspect_ratio', 'size_estimate']

def print_section(title):
    print(f"\n{'='*70}\n  {title}\n{'='*70}")

# =====================================================================
# [공통 모듈] 트리 경로(Rule Path) 추출기
# =====================================================================
def extract_rule_paths(estimator, feature_names, class_names_dict, max_level=4):
    """
    결정 트리의 모든 경로를 탐색하여 독립된 규칙(Rule) 리스트로 반환합니다.
    (Option 2, 3, 4에서 공통으로 사용되는 지식 베이스 추출용)
    """
    tree_ = estimator.tree_
    
    # 클래스 매핑
    target_names = []
    for cls in estimator.classes_:
        try:
            target_names.append(class_names_dict.get(int(cls), f"미등록({int(cls)})"))
        except:
            target_names.append(f"알수없음({cls})")

    feature_name = [feature_names[i] if i != -2 else "undefined!" for i in tree_.feature]
    rules = []

    def recurse(node, depth, current_conditions):
        if max_level is not None and depth >= max_level:
            values = tree_.value[node][0]
            pred_class = target_names[np.argmax(values)]
            rules.append((current_conditions, pred_class, True))
            return

        if tree_.feature[node] != -2:
            name = feature_name[node]
            threshold = tree_.threshold[node]
            recurse(tree_.children_left[node], depth + 1, current_conditions + [f"{name} <= {threshold:.2f}"])
            recurse(tree_.children_right[node], depth + 1, current_conditions + [f"{name} > {threshold:.2f}"])
        else:
            values = tree_.value[node][0]
            pred_class = target_names[np.argmax(values)]
            rules.append((current_conditions, pred_class, False))

    recurse(0, 0, [])
    return rules

# =====================================================================
# [Option 1] 절차적 프로그램 (Procedural IF-THEN-ELSE)
# =====================================================================
def generate_procedural_code(estimator, feature_names, class_names_dict, max_level=4):
    tree_ = estimator.tree_
    target_names = [class_names_dict.get(int(cls), f"Unk({int(cls)})") for cls in estimator.classes_]
    feature_name = [feature_names[i] if i != -2 else "undefined" for i in tree_.feature]

    print_section(f"[Option 1] 절차적 프로그램 (Procedural Code) - 최대 깊이: {max_level}")
    print(f"def predict_butterfly_species({', '.join(feature_names)}):")

    def recurse(node, depth):
        indent = "    " * (depth + 1)
        if max_level is not None and depth >= max_level:
            pred_class = target_names[np.argmax(tree_.value[node][0])]
            print(f"{indent}return '{pred_class}'  # 최대 깊이 도달")
            return

        if tree_.feature[node] != -2:
            name = feature_name[node]
            threshold = tree_.threshold[node]
            print(f"{indent}if {name} <= {threshold:.2f}:")
            recurse(tree_.children_left[node], depth + 1)
            print(f"{indent}else:  # {name} > {threshold:.2f}")
            recurse(tree_.children_right[node], depth + 1)
        else:
            pred_class = target_names[np.argmax(tree_.value[node][0])]
            print(f"{indent}return '{pred_class}'  # 리프 노드 결론")

    recurse(0, 0)
    print()

# =====================================================================
# [Option 2] 범용 규칙 (Generic Rule)
# =====================================================================
def generate_generic_rules(rules, max_level):
    print_section(f"[Option 2] 범용 규칙 (Generic Rule Base) - 최대 깊이: {max_level}")
    for idx, (conditions, pred_class, is_truncated) in enumerate(rules, 1):
        cond_str = "\n        AND ".join(conditions) if conditions else "조건 없음 (항상 참)"
        suffix = " (탐색 제한)" if is_truncated else ""
        print(f"Rule {idx}:")
        print(f"    IF      {cond_str}")
        print(f"    THEN    결론 = '{pred_class}'{suffix}\n")

# =====================================================================
# [Option 3] CLIPS / Experta 포맷 출력
# =====================================================================
def generate_clips_rules(rules):
    print_section("[Option 3] 전문가 시스템 (CLIPS/Experta Rule Format)")
    for idx, (conditions, pred_class, _) in enumerate(rules, 1):
        print(f"(defrule butterfly-rule-{idx}")
        
        extracted_features = set([cond.split(" ")[0] for cond in conditions])
        if extracted_features:
            print("  (Butterfly", end="")
            for feat in extracted_features:
                print(f" ({feat} ?{feat})", end="")
            print(")")
            
        for cond in conditions:
            parts = cond.split(" ")
            if len(parts) == 3:
                print(f"  (test ({parts[1]} ?{parts[0]} {parts[2]}))")
                
        print("  =>")
        print(f"  (assert (Species \"{pred_class}\")))\n")

# =====================================================================
# [Option 4] CLIPS 전향 추론 (Forward Chaining) 방식 출력
# =====================================================================
def generate_clips_forward_chaining(rules):
    print_section("[Option 4] CLIPS 전향 추론 (Forward Chaining / Step-by-Step)")
    
    node_id_map = {}
    generated_rules = set()
    rule_print_counter = 1
    
    def get_node_id(path_tuple):
        if not path_tuple: return "root"
        if path_tuple not in node_id_map:
            node_id_map[path_tuple] = f"node-{len(node_id_map) + 1}"
        return node_id_map[path_tuple]

    for conditions, pred_class, is_truncated in rules:
        for i in range(len(conditions)):
            current_path = tuple(conditions[:i])
            next_path = tuple(conditions[:i+1])
            
            from_state = get_node_id(current_path)
            cond = conditions[i]
            is_leaf = (i == len(conditions) - 1)
            to_state = pred_class if is_leaf else get_node_id(next_path)
            
            rule_signature = (from_state, cond)
            if rule_signature in generated_rules:
                continue
            generated_rules.add(rule_signature)
            
            parts = cond.split(" ")
            if len(parts) != 3: continue
            name, op, val = parts[0], parts[1], parts[2]
                
            print(f"(defrule step-{i+1}-rule-{rule_print_counter}")
            print(f"  (state {from_state})")
            print(f"  (Butterfly ({name} ?{name}))")
            print(f"  (test ({op} ?{name} {val}))")
            print("  =>")
            
            if is_leaf:
                print(f"  (assert (Species \"{pred_class}\"))")
                print(f"  (printout t \"-> [최종] 조건({cond}) 만족 => 종 판정: {pred_class}\" crlf))\n")
            else:
                print(f"  (assert (state {to_state}))")
                print(f"  (printout t \"-> [{i+1}단계 통과] 조건({cond}) 만족 => 상태: {to_state} 진입\" crlf))\n")
            
            rule_print_counter += 1

# =====================================================================
# 메인 실행 흐름 (사용자 입력 기반)
# =====================================================================
import joblib
def main():
    #MODEL_PATH = "random_forest_model.pkl"
    # 1. 물결표(~)를 사용할 때만 expanduser 사용
    #MODEL_PATH = os.path.expanduser("~/Study/CourseWork/Coursework/AI-X/random_forest_model/random_forest_model.pkl")

# 2. 또는 그냥 절대 경로 그대로 사용
    MODEL_PATH = "/Users/hyun/Study/CourseWork/Coursework/AI-X/random_forest_model/random_forest_model.pkl"
    # 1. 학습된 모델 로드
    try:
        #with open(MODEL_PATH, 'rb') as f:
            #model = pickle.load(f)
        model = joblib.load(MODEL_PATH)
        total_trees = len(model.estimators_)
        print(f"[+] 성공적으로 모델을 로드했습니다. (총 트리 개수: {total_trees}개)")
    except Exception as e:
        print(f"[!] 모델 로드 실패: {e}")
        return

    # 2. 분석할 트리 지정 (사용자 입력)
    while True:
        try:
            tree_input = input(f"\n▶ 분석할 결정 트리의 인덱스를 입력하세요 (0 ~ {total_trees-1}): ")
            tree_index = int(tree_input)
            if 0 <= tree_index < total_trees:
                break
            else:
                print("[!] 유효하지 않은 인덱스입니다. 범위를 확인해주세요.")
        except ValueError:
            print("[!] 숫자를 입력해주세요.")

    target_tree = model.estimators_[tree_index]

    # 3. 출력 옵션 선택
    menu_text = """
▶ 출력할 형식을 선택하세요 (다중 선택 가능, 예: 1,3,4):
  1. 절차적 프로그램 생성 (Python IF-THEN)
  2. 범용 규칙 생성 (Generic Rule)
  3. CLIPS/Experta 포맷 출력
  4. CLIPS (Forward Chaining) 방식 출력
  0. 종료
"""
    while True:
        print(menu_text)
        choices = input("선택: ").split(',')
        choices = [c.strip() for c in choices]

        if '0' in choices:
            print("프로그램을 종료합니다.")
            break

        # 공통 Rule Path 추출 (2, 3, 4 옵션용)
        extracted_rules = None
        if any(c in ['2', '3', '4'] for c in choices):
            extracted_rules = extract_rule_paths(target_tree, FEATURE_COLS, CLASS_NAMES, max_level=4)

        # 사용자가 선택한 옵션 실행
        for choice in choices:
            if choice == '1':
                generate_procedural_code(target_tree, FEATURE_COLS, CLASS_NAMES, max_level=4)
            elif choice == '2':
                generate_generic_rules(extracted_rules, max_level=4)
            elif choice == '3':
                generate_clips_rules(extracted_rules)
            elif choice == '4':
                generate_clips_forward_chaining(extracted_rules)
            elif choice not in ['0', '1', '2', '3', '4']:
                print(f"[!] 알 수 없는 옵션입니다: {choice}")
                break

if __name__ == "__main__":
    main()
