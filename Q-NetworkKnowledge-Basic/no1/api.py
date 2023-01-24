import json
from collections import defaultdict
from datetime import datetime
from typing import Any, Dict, List

from werkzeug import Request, Response, run_simple
from werkzeug.routing import Map, Rule
from werkzeug.wrappers.json import JSONMixin


def parse_timestamp(s: str) -> datetime:
    return datetime.fromisoformat(s.replace("Z", "+00:00"))


def format_timestamp(t: datetime) -> str:
    return t.isoformat().replace("+00:00", "Z")


class PedometerDatabase:
    def __init__(self) -> None:
        # self._data = {hour: value}
        self._data: Dict[datetime, int] = defaultdict(int)

    def insert(self, activity: dict) -> None:
        hour = parse_timestamp(activity["timestamp"]).replace(minute=0)
        self._data[hour] += activity["value"]

    def scan(self, start: datetime, end: datetime) -> List[dict]:
        return [
            {"timestamp": format_timestamp(hour), "value": value}
            for hour, value in self._data.items()
            if start <= hour <= end
        ]


class PedometerAPI:
    class JsonRequest(JSONMixin, Request):
        """Custom request class that can handle json nicely.

        Mixed-in with `werkzeug.wrappers.json.JSONMixin`.
        Ref: https://werkzeug.palletsprojects.com/en/1.0.x/request_data/#how-to-extend-parsing
        """

    def __init__(self) -> None:
        self.routes = Map(
            [
                Rule("/activities", methods=["GET"], endpoint=self.get_activities),
                Rule("/activities", methods=["POST"], endpoint=self.post_activities),
            ]
        )
        self.db = PedometerDatabase()

    @JsonRequest.application
    def __call__(self, request: JsonRequest) -> Response:
        """Handle all incoming requests and dispatch them to appropriate handler."""
        router = self.routes.bind_to_environ(request.environ)
        body = router.dispatch(lambda endpoint, _pathargs: endpoint(request))
        return Response(json.dumps(body, indent=4), content_type="application/json")

    def get_activities(self, request: JsonRequest) -> Any:
        """Handler for `GET /activities`."""
        start = parse_timestamp(request.args["start"])
        end = parse_timestamp(request.args["end"])

        return {"interval": "PT1H", "activities": self.db.scan(start, end)}

    def post_activities(self, request: JsonRequest) -> Any:
        """Handler for `POST /activities`."""
        activity = request.json["activities"][0]

        self.db.insert(activity)
        return {"operatoinStatus": "completed"}


if __name__ == "__main__":
    run_simple("localhost", 8080, PedometerAPI())
