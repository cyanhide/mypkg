# mypkg
![test](https://github.com/cyanhide/mypkg/actions/workflows/test.yml/badge.svg)

## 概要
本パッケージは、talkerノードが0.5秒刻みで0から順に整数をカウントし、
listenerノードがそれを受信して表示するものである。
カウント値が3の倍数、または数字に3を含む場合には、
いわゆる「世界のナベアツ方式」に基づき出力を変化させる。

## 準備
以下のコマンドをターミナル上で実行する。
```
git clone https://github.com/cyanhide/mypkg.git
```
## ノードとトピック
### talker
0.5秒刻みで0から順に整数をカウントし、その値をトピックとして配信する。

* トピック: /count [std_msgs/msg/Int32]
* 出力: count（整数値）

### listener
talkerノードが配信するトピックを受信し、内容を表示する。
受信したカウント値が3の倍数、または数字に3を含む場合には、
「世界のナベアツ方式」に基づき表示内容を変化させる。

* トピック: /count [std_msgs/msg/Int32]
* 入力: count（整数値）

## 使用方法
### 端末を2つでおこなう方法
#### ①talker
準備が済んだら以下のコマンドを実行する。
```
ros2 run mypkg talker
```
※実行後なにも表示されないので、そのままにしておく。

#### ②listener
①を実行後、別端末を用意し、そこで以下のコマンドを実行する。
```
ros2 run mypkg listener
```
そうすると実行結果が表示される。

### 端末1つでおこなう方法
準備が済んだら以下のコマンドを実行する。
```
ros2 launch mypkg talk_listen.launch.py
```
そうすると実行結果が表示される。
　
## 必要なソフトウェア
* Python 3.8.10
* ROS2 foxy

## テスト環境
* Ubuntu 20.04.4 LTS
* GitHub Actions
## 権利関係
* このソフトウェアパッケージは、3条項BSDライセンスの下、再配布および使用が許可されます。

© 2025 Hidenori Koseki

## 参考文献
- このパッケージのディレクトリ構成やテスト方式、コードは，下記のスライド（CC-BY-SA 4.0 by Ryuichi Ueda）のものを，本人の許可を得て参考にしています。
    - [ryuichiueda/slides_marp/robosys2025](https://github.com/ryuichiueda/slides_marp/tree/master/robosys2025) （© 2025 Ryuichi Ueda）
