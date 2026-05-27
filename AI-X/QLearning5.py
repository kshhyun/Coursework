import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import random

# 1. 미로 환경 정의
maze_size = (19, 19)
num_states = maze_size[0] * maze_size[1]
num_actions = 4 

Q_table = np.zeros((num_states, num_actions))
actions = {0: (-1, 0), 1: (1, 0), 2: (0, -1), 3: (0, 1)}

# 벽 데이터 (기존 데이터 유지)
walls = [
    (2, 3), (2, 5), (2, 6), (2, 7), (2, 8),(2, 9),(2, 10),(2, 11), (2,12), (2,13), (2,14),
    (5, 0), (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (5, 7), (5, 9), (5, 11), (5, 12), (5, 13), (5, 14), (5, 15), (5, 16),(6,17),
    (7,4), (7, 5), (7, 6), (7, 7), (7, 8),(7,10), (7,11), (7,12), (7,13),
    (10, 2), (10, 3), (10, 4), (10, 5), (10, 6), (10, 7), (10, 8), (10, 9), (10,10), (10, 11), (10, 12), (10, 13), (10, 15), (10, 16), (10, 17), (10, 18),
    (13, 10), (13, 11), (13, 12), (13, 13), (13, 14),
    (15, 0), (15, 1), (15, 2), (15, 3), (15, 4), (15, 5), (15, 7), (15, 8),(15,9), (15, 10), (15, 11), (15, 12), (15, 13), (15, 14), (15, 15), (15, 16), (15, 17),
    (17, 1), (17, 2), (17, 3), (17, 4), (17, 5), (17, 6), (17, 7), (17, 8), (17,9), (17, 10), (17, 11), (17, 12), (17, 14), (17,15), (17,16), (17, 17), (17, 18),
    (0,5), (0, 7), (0, 10), (1,16), (2,16), (3,16), (4,16), (5,16), (6,16), (7,16), (3,9), (4,6), (4,9), (6,1), (7,1), (8,1), (10,1), (11,1), (12,1), (13,1),
    (2, 2), (3, 2), (6, 9), (7, 9), (8, 9), (11, 5), (13, 5), (14, 5), (11, 15), (12, 15), (13, 15), (16,7)
]

# 시각화 설정
plt.ion() 
fig, ax = plt.subplots(figsize=(8, 8))

def plot_maze(Q_table, episode, epsilon, agent_pos=None, title_suffix="Learning"):
    ax.clear()
    q_max_values = Q_table.max(axis=1).reshape(maze_size)
    annot_labels = np.where(q_max_values == 0, "", np.round(q_max_values, 1).astype(str))

    sns.heatmap(q_max_values, annot=annot_labels, fmt="", cmap="coolwarm", 
                ax=ax, cbar=False, vmin=-1, vmax=10, linewidths=0,
                annot_kws={"size": 5, "color":"black"})
    
    # 벽 그리기
    for (r, c) in walls:
        ax.add_patch(plt.Rectangle((c, r), 1, 1, fill=True, color='black'))
    
    # 시작점(S) 및 목적지(G) 표시
    ax.text(0.5, 0.5, 'S', ha='center', va='center', color='blue', fontweight='bold', fontsize=12)
    goal_row, goal_col = maze_size[0]-1, maze_size[1]-1
    ax.text(goal_col + 0.5, goal_row + 0.5, 'G', ha='center', va='center', color='white', fontweight='bold', fontsize=12)
    
    # 현재 에이전트 위치 표시 (경로 탐색 시)
    if agent_pos is not None:
        r, c = divmod(agent_pos, maze_size[1])
        ax.add_patch(plt.Circle((c + 0.5, r + 0.5), 0.3, color='green', label='Agent'))

    ax.set_title(f"{title_suffix} - Episode {episode} (Epsilon: {epsilon:.2f})", fontsize=12)
    ax.tick_params(axis='both', which='major', labelsize=4)
    plt.draw()
    plt.pause(0.05)

# --- 학습 시작 전 초기 상태 표시 및 키 입력 대기 ---
plot_maze(Q_table, 0, 1.0, title_suffix="Press Any Key to Start")
print("그래프 창을 클릭한 후, 아무 키나 누르면 학습이 시작됩니다...")
plt.waitforbuttonpress() 

# 3. 학습 파라미터
alpha = 0.1
gamma = 0.99
epsilon = 1.0
epsilon_min = 0.05
epsilon_decay = 0.997
num_episodes = 1000  # 빠른 테스트를 위해 조정 가능
max_steps = 2000

# 4. 학습 루프
for episode in range(num_episodes):
    state = 0
    done = False
    step_count = 0

    while not done and step_count < max_steps:
        step_count += 1
        
        if np.random.rand() < epsilon:
            action = np.random.randint(0, num_actions)
        else:
            state_qs = Q_table[state]
            action = np.random.choice(np.where(state_qs == state_qs.max())[0])

        row, col = divmod(state, maze_size[1])
        next_row = min(max(row + actions[action][0], 0), maze_size[0] - 1)
        next_col = min(max(col + actions[action][1], 0), maze_size[1] - 1)
        
        if (next_row, next_col) in walls:   # 벽이면 감점
            new_state = state
            reward = -0.5
        elif (next_row * maze_size[1] + next_col) == (num_states - 1):  # 목표 지점 도착
            new_state = next_row * maze_size[1] + next_col
            reward = 10.0
            done = True
        else:   # 일반 이동 비용(수고비)
            new_state = next_row * maze_size[1] + next_col
            reward = -0.01

        best_next_q = np.max(Q_table[new_state])
        Q_table[state, action] += alpha * (reward + gamma * best_next_q - Q_table[state, action])
        state = new_state

    epsilon = max(epsilon_min, epsilon * epsilon_decay)

    if episode % 5 == 0:
        plot_maze(Q_table, episode, epsilon)
        print(f"Episode {episode}: Steps = {step_count}")

print("학습 완료! 랜덤 위치에서 경로 탐색을 시작합니다.")

# --- 5. 학습된 Weight를 이용한 경로 표시 ---
def show_optimal_path(Q_table):

    while True:
        # 1. 벽이 아닌 랜덤한 시작 지점 선택
        while True:
            r,c = map(int, input("시작 지점 입력 (row,col)").split(','))
            start_node = r * maze_size[1] + c
            # start_node = random.randint(0, num_states - 2)
            # r, c = divmod(start_node, maze_size[1])
            if (r, c) not in walls:
                break

        # walls.append((14, 14)) # 새로운 장애물 등록
        
        print(f"\n새로운 탐색 시작점: ({r}, {c})")
        state = start_node
        path_steps = 0
        path_history = [] # 이동 이력을 저장

        # 경로 탐색 루프
        while state != (num_states - 1) and path_steps < 400:
            path_history.append(state)
            
            # [수정] 1. 기본 미로와 Q-value 배경을 먼저 그림 (ax.clear 포함됨)
            plot_maze(Q_table, num_episodes, 0, agent_pos=state, title_suffix="Testing Path")
            
            # [수정] 2. plot_maze가 지워버린 배경 위에 '지금까지의 경로'를 다시 그림
            for p in path_history:
                pr, pc = divmod(p, maze_size[1])
                # 이동 경로는 작은 노란색 점으로 표시하여 시인성 확보
                ax.add_patch(plt.Circle((pc + 0.5, pr + 0.5), 0.15, color='yellow', alpha=0.6, zorder=3))
            
            # [수정] 시작 지점 표시 유지
            sr, sc = divmod(start_node, maze_size[1])
            ax.text(sc + 0.5, sr + 0.5, 'Start', ha='center', va='bottom', 
                    color='blue', fontsize=9, fontweight='bold', zorder=5)
            
            plt.draw()
            plt.pause(0.01) # 경로가 그려지는 것을 보기 위해 속도 조절

            # --- 차선책 탐색 로직 적용 ---
            state_qs = Q_table[state].copy()
            # Q값이 높은 순서대로 인덱스 정렬
            priority_actions = np.argsort(state_qs)[::-1]
            
            moved = False
            for action in priority_actions:
                row, col = divmod(state, maze_size[1])
                next_row = min(max(row + actions[action][0], 0), maze_size[0] - 1)
                next_col = min(max(col + actions[action][1], 0), maze_size[1] - 1)
                
                # 만약 Q값이 있는 방향이고, 새로 생긴 벽이 아니라면 이동
                if (next_row, next_col) not in walls:
                    state = next_row * maze_size[1] + next_col
                    moved = True
                    break
            
            if not moved or np.all(state_qs == 0):
                print("더 이상 갈 수 있는 학습된 경로가 없습니다.")
                break
                
            path_steps += 1

        # 도착 결과 표시
        if state == (num_states - 1):
            # 마지막 도착 상태 다시 그리기
            plot_maze(Q_table, num_episodes, 0, agent_pos=state, title_suffix="Goal Reached!")
            for p in path_history:
                pr, pc = divmod(p, maze_size[1])
                ax.add_patch(plt.Circle((pc + 0.5, pr + 0.5), 0.15, color='yellow', alpha=0.6))
            plt.draw()
            print(f"목표 도달 성공! ({path_steps} 스텝)")
        
        # [중요] 버튼 입력이 안 먹힐 때를 대비한 처리
        print("\n[알림] 콘솔창에서 Enter를 누르면 새로운 위치에서 시작합니다.")
        print("[알림] 종료하려면 그래프 창을 닫으세요.")
        
        # 키보드 입력 대기 (콘솔창 입력 방식이 가장 확실합니다)
        input("Enter를 눌러 계속...") 
        
        # 창이 닫혔는지 확인 (창이 닫혔는데 계속 실행되는 것 방지)
        if not plt.fignum_exists(fig.number):
            break

# --- 최종 실행부 ---
plt.ioff()
show_optimal_path(Q_table)
plt.show()