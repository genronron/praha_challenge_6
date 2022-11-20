# 課題1
## ユースケース
客は、下記リンク先のような注文webサイトで注文をして、  
受け取り店舗から電話をもらい、指定の時間に店舗に取りに行くようなケースを想定。

[注文表](https://github.com/praha-inc/praha-challenge-templates/blob/master/db/design/sushi.png)

## ER図
![ER図](ans01/ans01_sushi_order_ER.png)

### ER図への補足
####  カーディナリティ(dbでは表現できないので)
order : orderDetail  
0 or 1 : 0以上

order : orderer  
0以上 : 0 or 1

orderDetail : product  
0以上 : 1

## データイメージ
![データイメージ](ans01/ans01_snapshot007.png)

