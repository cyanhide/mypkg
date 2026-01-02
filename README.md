# mypkg
![test](https://github.com/cyanhide/mypkg/actions/workflows/test.yml/badge.svg)

## 概要
このパッケージは、CPUとメモリの使用率を定期的に取得して ROS 2 トピックで配信し、別ノードで受信・表示することができます。

## 準備
以下のコマンドをターミナル上で実行する。
```
git clone https://github.com/cyanhide/mypkg.git
```
ROS 2 のワークスペースに配置後，ビルドを行う。
```
cd ~/ros2_ws
colcon build
source install/setup.bash
```

## 使用方法
### 端末1つでおこなう方法
準備が済んだら以下のコマンドを実行することで，
CPU・メモリ監視ノードを同時に起動できる。
```
ros2 launch mypkg system_monitor.launch.py

```
実行すると，以下のように CPU とメモリの使用率が定期的に表示される。
```
CPU: 0.2%, MEM: 6.5%

```

### 端末を2つでおこなう方法
#### system_publisher
まず以下のコマンドを実行すると
CPU・メモリ使用率を取得してトピックに送信するノードが起動する。
```
ros2 run mypkg system_publisher

```
※注意　実行後なにも表示されないので、そのままにしておく。

#### system_listener
system_publisherを実行後、別端末を用意し、以下のコマンドを実行すると
送信された CPU・メモリ使用率を受信して表示するノードが起動する。
```
ros2 run mypkg system_listener

```


## 必要なソフトウェア
* Python 3.8.10
* ROS2 foxy
* Ubuntu 24.04 LTS
## テスト環境
* Ubuntu 24.04 LTS
* GitHUb Actions

## 権利関係
* このソフトウェアパッケージは、3条項BSDライセンスの下、再配布および使用が許可されます。

© 2025 Hidenori Koseki

## 参考文献
- このパッケージのディレクトリ構成やテスト方式、コードは，下記のスライド（CC-BY-SA 4.0 by Ryuichi Ueda）のものを，本人の許可を得て参考にしています。
    - [ryuichiueda/slides_marp/robosys2025](https://github.com/ryuichiueda/slides_marp/tree/master/robosys2025) （© 2025 Ryuichi Ueda）
