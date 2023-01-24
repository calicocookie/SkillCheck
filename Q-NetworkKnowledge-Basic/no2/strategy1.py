from typing import Dict, Optional

from lib import acquire_lock, calculate, db


def update_data(*keys: str) -> None:
    lock = acquire_lock(keys)
    with lock:
        # Fetch data
        old_values = {key: db.get(key) for key in keys}

        # Calulate
        new_values = calculate(old_values)

        # Update data
        db.update(new_values)


def read_data(*keys: str) -> Dict[str, Optional[int]]:
    lock = acquire_lock(keys)
    with lock:
        values = {key: db.get(key) for key in keys}
    return values
