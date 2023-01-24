# 問題

あるポータルサイトに $r$ 個のページが掲載されています。各ページ $i\ (i=1, \dots, r,\ r\ge2)$ の一日当たりのアクセス数 $X_i$はパラメータ $\lambda_i$ のポアソン分布 ${\rm Po}\left( \lambda_i \right)$ に互いに独立に従うとします。$X \sim {\rm Po }\left(\lambda\right)$ の確率関数は
$$
P\left(X=x\right) = \frac{\lambda^{x}}{x!} {\rm e}^{-\lambda}
$$ 
です。以下の各問に答えてください。

[1-1] パラメータ $\lambda$ のポアソン分布の平均及び分散の値として正しいものを以下の選択肢から選び、それぞれ`submit.yml`のキー`1-1-mean`, `1-1-variance`に記入してください。

1. $\lambda$
2. $2\lambda$
3. $\lambda^2$
4. $\sqrt{\lambda}$

いま、ある一日の各ページのアクセス数 $\boldsymbol{X} = \left(X_1, \cdots, X_r \right)^{\top}$ を元に平均アクセス数の同時推定を考えます。
$\delta\left(\boldsymbol{X}\right): \mathbb{N}^{r} \rightarrow \mathbb{R}^{r}_{>0}$
をその推定量、
$\delta_{i}\left(\boldsymbol{X}\right)$
を
$\delta\left(\boldsymbol{X}\right)$
の $i$ 番目の次元、つまりページ $i$ に対するアクセス数の推定量とします。
推定量 $\delta$ の良さを以下のリスク関数 $R\left(\boldsymbol{\lambda}, \delta \right)$ で評価することにします：
$$
R(\boldsymbol{\lambda}, \delta) =
\mathbb{E}_{\boldsymbol{X}}\left[ L\left(\boldsymbol{\lambda}, \delta\left(\boldsymbol{X}\right)\right) \right], \\
\text{where}\ L\left(\boldsymbol{\lambda}, \delta\left(\boldsymbol{X}\right)\right) = \sum_{i=1}^{r} \frac{\left( \lambda_i - \delta_i\left(\boldsymbol{X}\right) \right)^{2}}{\lambda_i}.
$$
ただし $\mathbb{E}_{\boldsymbol{X}} \left[ f(X) \right]$ は確率変数 $X$ に関する $f(x)$ の期待値を表します。

[1-2] 最尤推定量
$\delta_{\rm{ML}}\left(\boldsymbol{X}\right) = \boldsymbol{X} = \left(X_1, \cdots, X_r \right)^{\top}$
に対するリスク関数
$R\left(\boldsymbol{\lambda}, \delta_{\rm{ML}}\right)$
の値として正しいものを以下の選択肢から選び、`submit.yml`のキー`1-2`に記入してください。ただし、$\left\| \boldsymbol{\lambda} \right\|^2 = \sum_{i=1}^{r} \lambda_i^2$ と定義します。  

1. $\left\| \boldsymbol{\lambda} \right\|$
2. $\left\| \boldsymbol{\lambda} \right\|^2$
3. $\sqrt{\left\| \boldsymbol{\lambda} \right\|}$
4. 1
5. $1/2$
6. $r$
7. $r^2$
8. $r/\left\| \boldsymbol{\lambda} \right\|$

次に最尤推定量の代わりに以下の推定量 $\delta_H$ の挙動を調べます： 
$$
\delta_H \left(\boldsymbol{X}\right) = \left(1 - H(Z) \right)\boldsymbol{X}
$$
ただし
$Z=\sum_{i=1}^{r}X_i$
とし、
$H: \mathbb{R}_{>0} \rightarrow \mathbb{R}_{>0}$ は以下の2つの条件を満たす関数とします：

- 任意の $x \in \mathbb{R}_{>0}$ に対して 
  $0 \le H(x) < 2 \ \dfrac{r-1}{x+r-1}$ 
- $xH(x)$は単調非減少関数

[2] $Z$ が与えられた下での $X_i$ の条件つき期待値及び分散の値として正しいものを以下の選択肢から選び、それぞれ`submit.yml`のキー`2-mean`, `2-variance`に記入してください。ただし $\Lambda=\sum_{i=1}^{r}\lambda_i$ とします。

1. $Z$
2. $Z\lambda_i$
3. $Z\lambda_i/\Lambda$
4. $Z\left(\lambda_i/\Lambda\right)\left(1-\lambda_i/\Lambda\right)$
5. $\lambda_i/\Lambda$
6. $\left(\lambda_i/\Lambda\right)\left(1-\lambda_i/\Lambda\right)$

[3-1] 以下の(a), (b), (c) に当てはまる数式として正しいものを以下の選択肢から選び、それぞれ`submit.yml`のキー`3-1-a`, `3-1-b`, `3-1-c`に記入してください。
$$
R\left(\boldsymbol{\lambda}, \delta_H \right) =
\textrm{(a)} + 
\mathbb{E}_{Z} \left[ 
  \textrm{(b)} \cdot H(Z) + \textrm{(c)} \cdot H^2(Z)
\right]
$$

1. $r$
2. $r^2$
3. $Z$
4. $Z/\Lambda$
5. $\Lambda-Z-r+1$
6. $\left(\Lambda-Z-r+1\right)/\Lambda$
7. $2Z\left( \Lambda - Z - r + 1 \right)/\Lambda$
8. $\Lambda\left(Z+r-1 \right)$
9. $Z\left(Z+r-1 \right)/\Lambda$

[3-2] これまでの結果を用いて$R\left(\boldsymbol{\lambda}, \delta_H \right) \le R\left(\boldsymbol{\lambda}, \delta_{\rm{ML}} \right)$
を示します。以下の証明内の空欄 (d) ~ (g) に入る適切な数式を選択肢から選び、キー `3-2-d`, `3-2-e`, `3-2-f`, `3-2-g`に記入して下さい。
各選択肢は複数回使われる可能性もあります。また、
$f(x)$ を単調非減少関数、$g(x)$ を単調非増加関数とするとき
$$
\mathbb{E}_X \left[ f(X) g(X) \right]
\le \mathbb{E}_X \left[ f(X) \right]
\mathbb{E}_X \left[ g(X) \right]
$$
が成り立ちます。

(証明) [3-1] の結果と $H$ の条件から
$$
R(\boldsymbol{\lambda}, \delta_H )
\le \textrm{(a)} +2\mathbb{E}_{Z}\left[ \dfrac{\textrm{(d)} \textrm{(e)}}{\textrm{(f)}} \left\{\textrm{(f)} - \textrm{(d)}\right\} \right]
$$
が成り立ちます。第二項の期待値の項について、与えられた不等式を用いることで
$$
\mathbb{E}_{Z}\left[ \dfrac{\textrm{(d)} \textrm{(e)}}{\textrm{(f)}} \left\{\textrm{(f)} - \textrm{(d)}\right\} \right] \le \mathbb{E}_{Z}\left[ \dfrac{\textrm{(d)} \textrm{(e)}}{\textrm{(f)}}\right] \mathbb{E}_{Z}\left[\textrm{(f)} - \textrm{(d)}\right]
$$
が得られます。ここで $Z$ が従う分布を考えることで、$\mathbb{E}_{Z}\left[\textrm{(f)} - \textrm{(d)}\right]$ は (g) になることがわかります。  

以上より、$R\left(\boldsymbol{\lambda}, \delta_H \right) \le R\left(\boldsymbol{\lambda}, \delta_{\rm{ML}}\right)$ であることが示されました。

1. $\Lambda$
2. $\left\| \boldsymbol{\lambda} \right\|$
3. $Z$
4. $H$
5. $r$
6. $0$
7. 1

