from typing import Dict, Optional

from lib import acquire_lock, calculate, db

MAX_ATTEMPTS = 3


def update_data(*keys: str) -> None:
    for _ in range(MAX_ATTEMPTS):
        # Fetch data
        lock = acquire_lock(keys)
        with lock:
            old_values = {key: db.get(key) for key in keys}

        # Calulate
        new_values = calculate(old_values)

        # Update data
        lock = acquire_lock(keys)
        with lock:
            current_values = {key: db.get(key) for key in keys}
            if current_values == old_values:
                db.update(new_values)
                return
    else:
        raise RuntimeError("retry exhausted to update data")


def read_data(*keys: str) -> Dict[str, Optional[int]]:
    lock = acquire_lock(keys)
    with lock:
        values = {key: db.get(key) for key in keys}
    return values
