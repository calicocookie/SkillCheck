# Q-ABTest-Basic 案件内容(ストーリー)

ホットペッパービューティーのウェブシステムにおいてユーザーに美容系店舗(美容室など)をレコメンドする施策を行うことにしました。

レコメンド施策は効果検証のためABテストを実施し、統計的に効果があったとみなされた場合のみ本番反映されます。
レコメンド施策を企画するデータサイエンティストとして、モデリングだけでは無く「どのようなABテスト設計(調査計画立案)をすればよいか？」まで含めて考えてください。


解答は、このファイルと同じディレクトリにある `submit.yml` に記入し、GitHubにプッシュして提出してください。
なお、初期で用意している `submit.yml` ファイルに記載された解答は全てダミーの解答です。



## フィードバック

`submit.yml` に YAML ファイルとしての不備がある場合、次のフィードバック文のいずれかが返されます。

* `解答ファイルが提出されていません。`
  * `submit.yml` が提出されていないことを表します
* `提出された解答を読み込めませんでした。フォーマットを確認してください。`
  * `submit.yml` が YAML として形式が不正であることを表します

`submit.yml` に YAML ファイルとしての不備がない場合、各問に対して次のフィードバック文のいずれかが返されます。

* `解答が提出されていません。`
  * 問いに対する解答が欠けていることを表します
* `解答のフォーマットが正しくありません。`
  * 問いに対する解答が存在するが、形式が不正であることを表します
* `採点が正常に完了しました。`
  * 問いに対する解答の形式が正しく、採点が正常に行われたことを表します
* `サンプルのままの提出です`
  * 用意されたサンプルコードや解答例がそのまま提出されたことを表します

その他、採点システム上の問題が生じた場合は下記のフィードバック文が返されます。お問い合わせ先にご連絡ください。

* `採点システムにエラーが発生しました`
  * システムのエラーです。お手数ですが本スキルチェックの案内メールに記載のお問い合わせ先にご連絡ください。




# 問1 基礎調査

あなたは基礎調査として、ある美容室からヒアリングした「曜日によって来客数が異なるのではないか」という仮説を検証することにしました。
次の表は曜日ごとの来客者数を表しています。
この表を元に「来客者数は曜日に依存しない」を帰無仮説として有意水準5％で適合度検定を行いました。
その結果、統計量は自由度(1)のカイ二乗分布に近似的に従い、観測値は小数点以下第二位を四捨五入すると(2)のため、帰無仮説を(3)という結論に達しました。

(1)~(3)にあてはまる解答を選択肢から1つ選んでください。



|  曜日  |  月  |  火  |  水  |  木  |  金  |  土  |  日  |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
|  来客者数  |  25  |  12  |  15  |  22  |  14  |  26  |  26  |

### 選択肢：1-choiceに解答
1. (1) 1、(2) 14.2、(3)棄却する
1. (1) 6、(2) 14.2、(3)棄却しない
1. (1) 7、(2) 14.2、(3)棄却する
1. (1) 1、(2) 11.3、(3)棄却する
1. (1) 6、(2) 11.3、(3)棄却しない
1. (1) 7、(2) 11.3、(3)棄却する


# 問2 ABテスト設計
あなたは与えられたデータと問1のような基礎調査を元に、新たなレコメンドモデル (以下新モデルと呼ぶ) を作成しました。
レコメンドはPVイベント (あるユーザーがあるページにアクセスすること) ごとに行うとし、
旧モデルによってレコメンドを出すPVイベント群を対照群、新モデルによってレコメンドを出すPVイベント群を介入群と呼ぶことにします。

## 2-1 フィッシャーの三原則
適切な実験計画をたてるため、フィッシャーの三原則（反復、無作為化、局所管理）に基づいてRCTになるようABテストを行う事にしました。
以下の選択肢から適切なもの全て選んでください。

### 選択肢：2-1-choiceに解答
1. 実験を反復させるため、ABテスト実施期間の前半で対照群のデータを取得し、後半で介入群で実験した
1. 時間帯や曜日効果による系統誤差を考慮した局所管理のため、1日だけではなく2週間に渡ってABテストを実施した（1日も2週間も同じサンプルサイズになるよう適切に調整できているものとする）
1. 反復によってユーザーによる偶然誤差をなくすため、過去予約回数の多いユーザーを対照群、過去予約回数の少ないユーザーを介入群に配置した
1. 局所管理のため、過去履歴から過去予約回数が同程度のユーザーのみを選出してABテストを行った
1. 登録順に1からインクリメントされ発行されるユーザーIDがあるとする。無作為化のため、奇数のユーザーIDを持つユーザーを対照群、偶数のユーザーIDを持つユーザーを介入群に配置した
1. 無作為化のため、10日間行うABテストの奇数日を対照群、偶数日を介入群としてABテストを行った


## 2-2 サンプルサイズの計算
検定力分析を用いて適切な総サンプルサイズ（全テスト群での合計サンプルサイズ）を算出しようとしています。
サービス責任者と効果量を相談した結果、下記の設定で今回のABテストを実施することにしました。
選択肢の中から、総サンプルサイズとして最も適切だと思われるものを一つ選んでください（※)。

- テストする群の数：2（一方を対照群、もう一方を介入群として「CVRに差があるか」の検定を行う想定）
- CVR：10％
- 目標CVR：11％
- 有意水準：0.05
- 検出力：0.8
- 両側検定


### 選択肢：2-2-choiceに解答
1. 5,000
1. 10,000
1. 30,000
1. 50,000
1. 80,000
1. 100,000


※手法や算出するパッケージ、バージョンなどにより細かい値は異なる可能性があります。
選択肢の中からご自身の考える正答に最も近しいと思われるものを選択してください。




# 問3 スコアリング
## 3-1 リバースエンジニアリング
美容室レコメンドを行うにあたり、旧モデルの欠点を改良した新モデルをABテストで利用することになりました。
残念な事に、旧モデルは非常に古いものだったため、仕様書が現存していません。
そこで担当者にヒアリングしたところ
「細かい仕様はわからないが、各美容室のデータを用いて（つまりデータ全行から正規化の処理や偏差値などを算出することなく）四則演算のみで構成されるモデルであること」が確認できました。

旧モデルを解明するため、このヒアリング結果をもとにリバースエンジニアリングする必要があります。
旧モデルから次のようなインプットデータとモデルによる出力結果の表を取得しました。この表の空欄の部分(X)を埋めてください。

| imp | pv | cv | 口コミ評価 | 平均施術価格 | モデルによる出力結果（小数点第3位で四捨五入） |
| ---- | ---- | ---- | ---- | ---- | ---- |
| 900	| 80 | 5	| 5	| 8000	| 0.16 |
| 6400	| 1080	| 112	| 1	| 6300	| 0.60 |
| 7200	| 280	| 34	| 3	| 2000	| (X) |
| 9800	| 1150	| 123	| 1	| 4800	| 0.61 |
| 12500	| 430	| 78	| 2	| 3500	| 0.43 |

※口コミ評価は1~5まであり、1が最も良く5が最も低い値です。


### 選択肢：3-1-choiceに解答

1. 0.12
1. 0.29
1. 0.32
1. 0.34
1. 0.41


## 3-2 平均・分散の計算
モデリングする際に次の確率変数の平均・分散を求めることになりました。
式(1), (2)の選択肢から各々適切なものを選んでください。


式(1)：

f(x) = {1/2 (-1 <= X <= 1), 0 (X < -1, 1 < X)}



### 選択肢：3-2-1-choiceに解答

1. 平均:0, 分散:1/3
1. 平均:0, 分散:2/3
1. 平均:1/4, 分散:2
1. 平均:1/4, 分散:1/3
1. 平均:1/2, 分散:2/3
1. 平均:1/2, 分散:2


式(2)：

f(x) = {x/2 (0 <= X <= 2), 0(X < 0, 2 < X)}


### 選択肢：3-2-2-choiceに解答

1. 平均:1/3, 分散:1/9
1. 平均:1/3, 分散:2/3
1. 平均:2/3, 分散:1/3
1. 平均:2/3, 分散:2/3
1. 平均:4/3, 分散:2/3
1. 平均:4/3, 分散:2/9



# 問4 ABテストの振り返り
## 4-1 カイ二乗検定
ABテストの結果、以下の表のようになりました。
表に対してカイ二乗検定を行い、新モデルを本番反映すべきかどうかの判定について選択肢の中で適切なものを1つ選んでください。
なお、本番反映するかどうかの設定は2-2に準拠します。

| モデル | PV | CV |
| ---- | ---- | ---- |
| 旧モデル	| 14929	| 1498 |
| 新モデル	| 14911	| 1628 |

### 選択肢：4-1-choiceに解答

1. 有意水準10％で有意なので本番反映する
1. 有意水準10％で有意ではないため、本番反映しない
1. 有意水準5％で有意なので本番反映する
1. 有意水準5％で有意ではないため、本番反映しない
1. 有意水準1％で有意なので本番反映する
1. 有意水準1％で有意ではないため、本番反映しない


## 4-2 アンバランスデザインによる影響
ABテストを実施した結果、対照群と介入群ではサンプルサイズが異なりました。
サービス責任者からその点について「何か統計的な問題があるのではないか」という問い合わせが来ました。
サービス責任者への回答に関する次の選択肢の中から、適切なものを全て選んでください。


### 選択肢：4-2-choiceに解答

1. どのような状況であろうと、各群のサンプルサイズの偏りは検定力に影響を与えない
1. 各群のサンプルサイズが厳密に一致していない限り、理論的にカイ二乗検定は適用してはならない
1. 総サンプルサイズが一定という条件のもと、各群のサンプルサイズが異なれば異なるほど検定力が下がる
1. 各群のサンプルサイズに偏りがあると「第1種の過誤」の発生確率が増える
1. 総サンプルサイズが異なれば検定力に影響を与える
1. サンプルサイズが異なるため、今回のABテストは失敗であり、ABテストをやり直した方が良い