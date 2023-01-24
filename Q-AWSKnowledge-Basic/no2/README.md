# 問 2-1

## 小問 A
開発中のシステムにおいて、ある Amazon S3（以下 S3）バケットの利用要件が次のように定められています。

- 要件 1. 対象となる S3 バケットは `ce-exam`
- 要件 2. S3 バケット `ce-exam` の `tmp` 配下のオブジェクトを一覧・取得できます
- 要件 3. S3 バケット `ce-exam` の `tmp` 配下にオブジェクトを追加できます

この要件を満たす AWS IAM Policy のコードの候補が [main.tf](main.tf) に書かれています（コメントに選択肢の番号）。最も適切な選択肢を選択してください。

# 問 2-2

## 小問 A
新しいオブジェクトの作成など、S3 バケットで特定のイベント発生を通知できます。この通知をトリガーにして AWS Lambda 等を起動する、イベント駆動なアーキテクチャを構築可能です。

もし同じイベントに対して複数の利用法が想定される場合、S3 イベントの通知先に利用する AWS のサービスで最も適切なものを選択してください。

### 選択肢 A
1. Amazon Kinesis
2. Amazon Simple Queue Service
3. Amazon Simple Notification Service
4. AWS Step Functions
5. AWS Auto Scaling

## 小問 B
S3 の運用に関する次の選択肢のうち、最も適切なものを選択してください。

### 選択肢 B
1. S3 のバケットポリシーで、他の AWS アカウントから自アカウントの S3 バケットに対するオブジェクト追加を許可しました。新規作成した S3 バケットのデフォルト設定では、オブジェクトをバケットにアップロードした AWS アカウントがオブジェクトの所有者になります
2. AWS CLI/AWS SDK を利用している限り、ListObjectsV2 API でページネーションを意識する必要はありません
3. S3 バケットやオブジェクトへのアクセスを調べるには、S3 サーバーアクセスログや AWS CloudTrail を利用できます
4. AWS Management Console から S3 を利用する場合、S3 バケットの一覧表示権限は必ず必要となります