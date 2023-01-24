import os
import glob

from typing import List, Generator


# アクセスログは ../data/train 以下に、
# category.csv は ../data/category.csv に、
# テストデータは ../data/test 以下に存在
INPUT_DIR = "../data"


def read_files(paths: List[str]) -> Generator[str, None, None]:
    """
    ファイルパスのリストを受け取り、各ファイルの行を順番に返すジェネレータ。
    各ファイルの1行目はスキップする。また、各行の末尾の改行は削除する。

    Args:
      paths: ファイルパスのリスト

    Yields:
      ファイルの中の行が順に返される
    """
    for file_path in paths:
        with open(file_path) as f:
            f.readline()
            for line in f:
                yield line.rstrip('\n')


def main():
    test_files = glob.glob(os.path.join(INPUT_DIR, 'test/*'))
    print('id,click')

    ID_COL_INDEX = 0

    for line in read_files(test_files):
        line = line.split(',')
        user_id = line[ID_COL_INDEX]
        print(user_id + ',1')


if __name__ == '__main__':
    main()
