# 問 1
AWS におけるセキュリティ対策に関する以下の問題に回答してください。

## 小問 A
以下の説明文（1）〜（3）は、脆弱性やサイバー攻撃の説明となっています。
これらの検知や対策に使える AWS サービスの組み合わせとして、最も適切だと考えられる選択肢を選んでください。

### 説明文
（1）
クライアントはサーバーに大量の SYN パケットを送り、3ウェイハンドシェイクを完了しないままにしておく。
これによりサーバー側が新しい接続を受けるためのリソースを枯渇させます。

（2）
データベースを利用する Web アプリケーションの不備を利用し、悪意のあるクエリを意図的に実行させデータに不正アクセスします。

（3）
攻撃者は何らかの手段で外部に公開されたサーバーから、通常アクセスできない内部ネットワークに存在するサーバーに対してリクエストを送信・攻撃します。

### 選択肢 A

1.

||利用する AWS サービス|
|:-:|:-|
| (1) |`AWS WAF`|
| (2) |`Amazon RDS Proxy`|
| (3) |`AWS GuardDuty`|

2.

||利用する AWS サービス|
|:-:|:-|
| (1) |`AWS Shield Standard`|
| (2) |`AWS WAF`|
| (3) |`AWS GuardDuty`|

3.

||利用する AWS サービス|
|:-:|:-|
| (1) |`Amazon CloudFront`|
| (2) |`AWS Shield Standard`|
| (3) |`AWS WAF`|

4.

||利用する AWS サービス|
|:-:|:-|
| (1) |`AWS WAF`|
| (2) |`Amazon CloudFront`|
| (3) |`AWS Shield Standard`|

## 小問 B
以下の（B-a）〜（B-c）は、脆弱性やサイバー攻撃に関連する何かしらのコマンド操作となります。
（B-a）〜（B-c）のそれぞれのコマンドについて、小問 A の説明文（1）〜（3）のうち最も関係があると考えられるものを選択してください。
なお、（1）〜（3）の選択肢が複数回使われることも、一度も使われないこともあります。

（B-a）
```
curl https://ce-exam.example?url=http://169.254.169.254/latest/meta-data/iam/security-credentials/
```

（B-b）
```
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/
```

（B-c）
```
curl -X POST -H "Content-Type: application/json" -d "{\"email\": \"' or 1=1--\", \"password\": \"pass\"}" https://ce-exam.example
```
