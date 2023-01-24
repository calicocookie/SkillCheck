import os
import json

if __name__ == "__main__":
    dirname = os.getcwd()

    with open(dirname + "/data/config.json", "r") as f:
        json_load = json.load(f)

    N1, N2 = 0, 0
    print("%d,%d" % (N1, N2))
