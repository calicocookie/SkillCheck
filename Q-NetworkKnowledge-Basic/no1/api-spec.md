# API 仕様

## `Activities` リソース

| フィールド | 型 | 内容 |
|:-----------|:---|:-----|
| interval | string | データの集計間隔。ISO-8601 形式。例: `PT10M`（10分）, `PT1H`（1時間）|
| activities | array | アクティビティ内容を表す長さ1以上の配列。timestamp の昇順でソートされている |
| ├ value | integer | 特定の時間帯でのアクティビティ量。0以上の整数で、単位は「歩」 |
| └ timestamp | string | データ点のタイムスタンプで、`value` の値がこの時刻から `interval` 後までの間の活動であることを示す。<br />ISO-8601 形式で精度は秒。タイムゾーンは UTC（末尾に `Z` をつけて表記する） |

### 例

下記の例は、2020年1月25日の1:40〜1:50 (UTC) の間に143歩あるいたことを示します。

```json
{
  "interval": "PT10M",
  "activities": [
    {
      "timestamp": "2020-01-25T01:40:00Z",
      "value": 143
    }
  ]
}
```

## アクティビティ書き込み（デバイスが使うもの）

- メソッド
    - `POST`
- エンドポイント
    - `/activities`
- リクエスト
    - ヘッダー: `content-type: application/json`
    - ボディ: JSON 形式の `Activities` リソース（前述）
    - クエリパラメーター: なし
- レスポンス
    - ヘッダー: `content-type: application/json`
    - ボディ: `{"operatoinStatus": "completed"}`

`activities` データは下記を満たします。

- 時間間隔は10分
    - `activities[*].timestamp` の値は毎10分ちょうどになる（分の1の位や秒は必ず0になる）
    - `interval` の値は `PT10M` で固定である
- 同一 timestamp で異なる値が送られてきたり、1回のリクエストに同一 timestamp のデータが含まれることはない

## アクティビティ読み取り（Web 画面が使うもの）

- メソッド
    - `GET`
- エンドポイント
    - `/activities`
- リクエスト
    - ボディ: なし
    - クエリパラメーター:
        - `start`: 返却対象のデータの開始日時（端点を含む）
        - `end`: 返却対象のデータの終了日時（端点を含む）
- レスポンス
    - ヘッダー: `content-type: application/json`
    - ボディ: JSON 形式の `Activities` リソース（前述）

クエリパラメーターの `start`, `end` は下記を満たします。

- ISO-8601 形式で精度は秒。タイムゾーンは UTC（末尾に `Z` をつけて表記する）
- 値はいずれも毎時ちょうどになる（分や秒は必ず0になる）
- `start <= end` である

`activities` データは下記を満たすようにしてください。

- 時間間隔は1時間
    - `activities[*].timestamp` の値は毎時ちょうどになる（分や秒は必ず0になる）
    - `interval` の値は `PT1H` で固定である
- アクティビティ書き込みがない時間範囲のアクティビティ量は0として扱う
