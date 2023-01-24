import sys
import os
import random
import argparse
import shutil


BASE_DIR = os.path.dirname(os.path.abspath(__file__))
USER_NUM = 1000
BATCH_NUM = 10


def send_msg(msg):
    print(msg)
    sys.stdout.flush()


def recv_ad():
    line = input()
    assert (line[:2] == "a:")
    ad = int(line[2:])
    return ad


def log(msg):
    print(msg, file=sys.stderr)
    sys.stderr.flush()


def run_server(seed, n, m, prob, user_segment):
    log("start server.")
    rand = random.Random(seed)
    score = 0

    send_msg("{} {}".format(n, m))
    for _ in range(BATCH_NUM):
        users = [u+1 for u in range(USER_NUM)]
        rand.shuffle(users)
        for user in users:
            send_msg("u:{}".format(user))

            ad = recv_ad()
            assert (1 <= ad <= m)
            segment = user_segment[user]

            click = 1 if prob[segment-1][ad-1] >= rand.random() else 0
            send_msg("c:{}".format(click))
            score += click
    send_msg("bye")
    log("your score={}.".format(score))


def prepare(sample_case):
    log("prepare sample case data: #{}.".format(sample_case))
    sample_case_dir = os.path.join(BASE_DIR, "sample_case", sample_case)
    shutil.copy(os.path.join(sample_case_dir, "server.conf"), 
        os.path.join(BASE_DIR, "server.conf"))
    shutil.copy(os.path.join(sample_case_dir, "segments.csv"), 
        os.path.join(BASE_DIR, "data", "segments.csv"))
    shutil.copy(os.path.join(sample_case_dir, "summary.csv"), 
        os.path.join(BASE_DIR, "data", "summary.csv"))


def main(sample_case):
    prepare(sample_case)

    with open(os.path.join(BASE_DIR, "server.conf")) as f:
        seed = int(f.readline())
        n, m = map(int, f.readline().split())
        p = []
        for i in range(n):
            p.append([float(x) for x in f.readline().split()])

    with open(os.path.join(BASE_DIR, "data", "segments.csv")) as f:
        lines = [line.rstrip().split(",") for line in f.readlines()]
        user_segment = dict((int(line[0]), int(line[1])) for line in lines)

    run_server(seed, n, m, p, user_segment)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--sample_case', default='1')
    args = parser.parse_args()
    main(args.sample_case)
