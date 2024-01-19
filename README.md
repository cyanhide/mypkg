# mypkg
![test](https://github.com/cyanhide/mypkg/actions/workflows/test.yml/badge.svg)

## 概要
このパッケージは、talkerが0.5秒刻みで0から順にカウントした整数をlistenerが受け取り表示させるものである。

## 準備
以下のコマンドをターミナル上で実行する。
```
git clone https://github.com/cyanhide/mypkg.git
```

## 使用方法
### 端末1つでおこなう方法
準備が済んだら以下のコマンドを実行する。
```
ros2 launch mypkg talk_lasten.launch.py
```
そうすると実行結果が表示される。

### 端末を2つでおこなう方法
#### talker
まず以下のコマンドを実行する。
```
ros2 run mypkg talker
```
※注意　実行後なにも表示されないので、そのままにしておく。

#### listener
talkerを実行後、別端末を用意し、以下のコマンドを実行する。
```
ros2 run mypkg listener
```
そして実行結果が表示される。

## 必要なソフトウェア
* Python 3.8.10
* ROS2 foxy

## テスト環境
* Ubuntu 20.04.4 LTS
* Ubuntu 22.04

## 権利関係
* このソフトウェアパッケージは、3条項BSDライセンスの下、再配布および使用が許可されます。
* このパッケージのコードは, 下記のスライド（CC-BY-SA 4.0 by Ryuichi Ueda）の一部のものを加筆し, 本人の許可を得て自身の著作としたものです.
    * [ryuichiueda/my_slides/robosys_2022](https://github.com/ryuichiueda/my_slides/tree/master/robosys_2022)
        * ©　2022 Ryuichi Ueda

© 2023 Hibiki Iida
