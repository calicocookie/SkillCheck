# 本ファイル内のコードはあくまでダミーであり、理解する必要はありません。

from contextlib import contextmanager
from time import sleep
from typing import Dict, Iterable, Iterator, Optional

db: Dict[str, Optional[int]] = {}


@contextmanager
def acquire_lock(keys: Iterable[str]) -> Iterator[None]:
    yield


def calculate(data: Dict[str, Optional[int]]) -> Dict[str, Optional[int]]:
    sleep(10)
    return data
