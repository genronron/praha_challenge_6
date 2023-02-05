# 課題2
## 課題2-1
## ER図
![ER図](ans02/ans02-01_sushi_order_ER.png)
### ER図への補足
####  カーディナリティ(dbでは表現できないので)
order : orderDetail  
0 or 1 : 0以上

order : orderer  
0以上 : 0 or 1

orderDetail : product  
0以上 : 1

orderDetail : sushiRiceSize  
0以上 : 1

## データイメージ
![データイメージ](ans02/ans02-01_snapshot002.png)

***

## 課題2-2
## ER図
![ER図](ans02/ans02-02_sushi_order_ER.png)
### ER図への補足
####  カーディナリティ(dbでは表現できないので)
order : orderDetail  
0 or 1 : 0以上

order : orderer  
0以上 : 0 or 1

orderDetail : product  
0以上 : 1

orderDetail : sushiRiceSize  
0以上 : 1

product : productType  
0以上 : 1

## データイメージ
![データイメージ](ans02/ans02-02_snapshot002.png)


