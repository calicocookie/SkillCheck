# 問 2-1

以下の問題文を読み、（A）〜（E）に適切なものを選択肢 1 からそれぞれ選んでください。ひとつの選択肢が複数回使われることも、一度も使われないこともあります。

あなたが所属する組織では、AWS アカウントの利用者は ID プロバイダー（IdP）を使用したフェデレーション（SAML 2.0ベース）で AWS Management Console を使用しています。これは利用者毎に AWS IAM User（以下 IAM User）を作成・管理しなくても、既存の ID 管理で AWS Management Console を利用できる利便性が高い方法です。

一方で、AWS CLI や AWS SDK を使うためには少し工夫が必要となることも知られています。
そのための方法として、あなたは 3 つの設計を検討しました。以下それぞれの詳細を見ていくこととします。

**設計 1. IAM User を作成**

最初の設計は IAM User を利用者ごとに作成してしまうことです。
この場合は当然冒頭で述べたようなメリットを失い、認証情報を別途管理する必要があります。
また AWS API を操作するためにアクセスキーを発行するため、AWS API 呼び出しを送信元 IP アドレスに応じて拒否する設定や多要素認証（MFA）、定期的なキーのローテーションといった運用を組み合わせることが望ましいでしょう。

ここでは AWS API の呼び出しに IP アドレス制限をする方法を詳細に検討します。まず IP アドレス制限をする AWS IAM Policy（以下 IAM Policy）は次の通りです。
（この IAM Policy と、権限許可の IAM Policy を組み合わせます）
``` json
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Deny",
    "Action": "*",
    "Resource": "*",
    "Condition": {
      "NotIpAddress": {
        "aws:SourceIp": [
          "<限定したい IP アドレス>",
        ]
      }
    }
  }
}
```

ただしこの IAM Policy をそのまま利用すると、一部 AWS サービスが IAM User の認証情報を使って別のサービスにリクエストするケースでアクセス拒否のエラーが発生します。

そこで、これに対する対策を 2 つ見ていきます。

**1. 上記 IAM Policy を修正して対応**

この修正は次の IAM Policy として書くことができます。
``` json
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Deny",
    "Action": "*",
    "Resource": "*",
    "Condition": {
      "NotIpAddress": {
        "aws:SourceIp": [
          "<限定したい IP アドレス>",
        ]
      },
      "Bool": {"（A）": "false"}
    }
  }
}
```

複数 Condition の条件は（B）で判定されるので、この IAM Policy で期待通りの動作をさせることができます。

**2. IAM User から作業用の AWS IAM Role（以下 IAM Role）に sts:AssumeRole し、 IAM Role の権限で AWS API を呼び出す**

つまり

* IAM Role に必要な権限を持つ IAM Policy をアタッチ。指定された IAM User 及び IP アドレスからのみ sts:AssumeRole で IAM Role の引き受けを許可
* IAM User に上記 IAM Role に対する sts:AssumeRole 権限を付与

とします。より具体的には

``` json
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Action": "sts:AssumeRole",
    "Resource": "arn:aws:iam::<AWS アカウントの ID>:role/<IAM Role 名>"
  }
}
```
この IAM Policy を（C）にアタッチし

``` json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::<AWS アカウントの ID>:user/<IAM User 名>"
      },
      "Action": "sts:AssumeRole"
    },
    {
      "Effect": "Deny",
      "Principal": {
        "AWS": "arn:aws:iam::<AWS アカウントの ID>:user/<IAM User 名>"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "NotIpAddress": {
          "aws:SourceIp": [
            "<限定したい IP アドレス>",
          ]
        }
      }
    }
  ]
}
```

これを（D）に設定し、引き受けを許可します。

こちらの対策をとる場合、（E）のログで IAM User と IAM Role を引き受けての操作が直接は紐づかなくなる点に注意する必要があります。

## 選択肢 1
1. AWS CloudTrail
2. Amazon CloudWatch Logs
3. AWS Config
4. AWS Security Hub
5. AND
6. OR
7. XOR
8. AWS IAM User
9. AWS IAM Role
10. aws:ViaAWSService
11. aws:SourceIp
12. aws:CalledVia

# 問 2-2
問題文の続きを読み、（A）〜（F）に適切なものを選択肢 2 からそれぞれ選んでください。ひとつの選択肢が複数回使われることも、一度も使われないこともあります。

**設計 2. 作業用の Amazon EC2 インスタンス（以下 EC2 インスタンス）を利用**

必要な権限を持つ IAM Role をアタッチした EC2 インスタンスを準備し、そのインスタンス上で作業する方式となります。
この場合、別途 SSH キーの管理検討や AWS Systems Manager の Session Manager の利用が必要となります。

Session Manager の場合、フェデレーションで利用する IAM Role が必要な権限を持つことは前提となりますが

1. フェデレーション認証経由で、AWS Management Console にログイン。Amazon EC2 の画面へ移動
2. 作業用の EC2 インスタンスを選択し、Session Manager で接続
   * 作業用 EC2 インスタンスで（A）が起動していることが必要です
3. AWS CLI/AWS SDK を利用

というフローでやりたいことが実現できます。

この設計では適切に設定しておけば、作業用インスタンスへ接続するセッションの開始を（B）のログに記録し、また EC2 インスタンス内での操作ログを（C）に連携することで、監査などで必要であろうログを保存できます。

**設計 3. IdP からの SAML レスポンスを元とした一時的なセキュリティ認証情報の利用**

この設計をみる前に、まず SAML 2.0 ベースのフェデレーションで AWS Management Console を利用するまでの流れを確認します。なお、IdP と AWS 間で必要な連携設定は済んでいるものとします。

1. 利用者が IdP のポータルサイトへアクセスし、認証をします
2. IdP ポータルサイトは、利用者の属性情報を含んだ SAML アサーションのレスポンスを返す
3. ブラウザは AWS のサインイン SAML エンドポイント（`https://signin.aws.amazon.com/saml`）へリダイレクトし、先の SAML アサーションを POST します
4. SAML エンドポイントは、一時的なセキュリティ認証情報をリクエストし、AWS Management Console のサインイン URL を作成
5. AWS はサインイン URL をブラウザにリダイレクトとして送信
6. ブラウザは AWS Management Console にリダイレクト

この手順によって、利用者は事前に引き受けを許可された（D）の認証情報で以って AWS Management Console を利用できる訳です。

設計 3 では、手順 2 の SAML アサーションを何かしらの方法（例. ブラウザの開発者コンソールを利用）で取得し、（E）を AWS CLI から呼び出すことで、やはり一時的なセキュリティ認証情報を利用者のローカル環境で使用できます。
実際に一時的なセキュリティ認証情報を引き受けているかどうかは、（F）を実行することでも確かめることができます。

## 選択肢 2
1. SAML アサーション
2. SAML 属性
3. AWS CloudTrail
4. Amazon CloudWatch Logs
5. AWS Config
6. AWS Security Hub
7. aws sts get-caller-identity
8. aws sts assume-role-with-saml
9. aws sts assume-role
10. aws sts assume-role-with-web-identity
11. CloudWatch Agent
12. AWS Systems Manager Agent
13. Docker

# 提出方法

解答を [`submit.yml`](submit.yml) に記入した上で GitHub にプッシュしてください。

## フィードバック

`submit.yml` に YAML ファイルとしての不備がある場合、次のフィードバック文のいずれかが返されます。

- `解答ファイルが提出されていません。`
    - `submit.yml` が提出されていないことを表します
- `提出された解答を読み込めませんでした。フォーマットを確認してください。`
    - `submit.yml` が YAML として形式が不正であることを表します

`submit.yml` に YAML ファイルとしての不備がない場合、各問に対して次のフィードバック文のいずれかが返されます。

- `解答が提出されていません。`
    - 問いに対する解答が欠けていることを表します
- `解答のフォーマットが正しくありません。`
    - 問いに対する解答が存在するが、形式が不正であることを表します
- `採点が正常に完了しました。`
    - 問いに対する解答の形式が正しく、採点が正常に行われたことを表します
- `サンプルのままの提出です`
    - 用意されたサンプルコードや解答例がそのまま提出されたことを表します
    - なおこのフィードバックは Q-AWSCloudGovernance-Entry 全体で共通であり、no1, no2 のいずれかに変更を加えていればこのフィードバックは返されません。

その他、採点システム上の問題が生じた場合は下記のフィードバック文が返されます。お問い合わせ先にご連絡ください。

- `採点システムにエラーが発生しました`
  - システムのエラーです。お手数ですが本スキルチェックの案内メールに記載のお問い合わせ先にご連絡ください。

## 【注意】

- YAML のフォーマットやファイル名等を変更してはいけません（変更した場合、正しく採点できなくなります）
- ファイルに初期値として記載されている解答はすべてダミーであり、採点結果がゼロ点となります。
