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
* Ubuntu 24.04 LTS
## テスト環境
* Ubuntu 24.04 LTS

## 権利関係
* このソフトウェアパッケージは、3条項BSDライセンスの下、再配布および使用が許可されます。

© 2025 Hidenori Koseki

## 参考文献
- このパッケージのディレクトリ構成やテスト方式、コードは，下記のスライド（CC-BY-SA 4.0 by Ryuichi Ueda）のものを，本人の許可を得て参考にしています。
    - [ryuichiueda/slides_marp/robosys2025](https://github.com/ryuichiueda/slides_marp/tree/master/robosys2025) （© 2025 Ryuichi Ueda）
