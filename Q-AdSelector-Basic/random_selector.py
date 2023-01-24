import os
import random
import sys

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
MAX_USER = 1000
RAND = random.Random(1234)


def parse_user(line):
    return int(line[2:])


def parse_click(line):
    return int(line[2:])


def select_ad(m):
    return RAND.randint(1, m)   # ランダムに選ぶ


def send_msg(msg):
    print(msg)
    sys.stdout.flush()


def read_user_segment():
    with open(os.path.join(BASE_DIR, "data", "segments.csv"), "rt") as f:
        lines = [line.rstrip().split(",") for line in f.readlines()]
        user_segment = [(
            int(line[0]),  # ユーザID
            int(line[1])   # セグメントID
        ) for line in lines]
    return dict(user_segment)


def read_summary():
    with open(os.path.join(BASE_DIR, "data", "summary.csv"), "rt") as f:
        lines = [line.rstrip().split(",") for line in f.readlines()]
        summary = [(
            int(line[0]),  # ユーザID
            int(line[1]),  # アドID
            int(line[2]),  # 表出数
            int(line[3])   # クリック数
        ) for line in lines]
    return summary


def main():
    n, m = map(int, input().split())
    user_segment = read_user_segment()
    summary = read_summary()

    while True:
        line = input()
        if line == "bye":
            break
        user = parse_user(line)
        assert (1 <= user <= MAX_USER)
        ad = select_ad(m)
        send_msg("a:{}".format(ad))
        click = parse_click(input())
        assert (0 <= click <= 1)


if __name__ == '__main__':
    main()
