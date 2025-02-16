# phisap - PHIgros Semi-Auto Player
适用于音游Phigros的半自动打歌器，**仅支持安卓/鸿蒙设备**。\
**本项目属于个人兴趣项目，与厦门鸽游网络公司无关。**
**本项目由 kvarenzn 原创，本人已获得作者授权。**

## 免责声明
**您因使用或修改本程序所造成的一切后果由您自己承担。**\
包括但不限于：失去游玩的乐趣、被其他人辱骂或被官方删除在线存档或帐号等。因此，请酌情使用。

## 有关防沉迷的说明
**根据新颁布的《关于进一步严格管理 切实防止未成年人沉迷网络游戏的通知》，为了积极响应号召，本项目已经加入未成年人防沉迷系统并进行未成年用户使用本程序的限制的调整。**
下面是关于这一改动的问与答：

问：程序是怎么判断成年与未成年的？\
答：事实上，程序与程序作者并没有任何权利也不希望获知您的个人信息，所以，**我们将平等对待所有的用户，认为您就是未成年人**。

问：不是说网络游戏吗？跟这个项目有什么关系？\
答：根据相关文件的说法，所有的能在网络上下载到的游戏都是网络游戏。那么同样地，本项目是可以在网络上下载到的跟游戏相关的程序，当然也是网络游戏。还有，您现在都敢提出这种问题，那么您以后会提出什么问题我真的不敢想了。

问：具体的时间限制是什么时候？如何实行？\
答：根据上面提到的《通知》，除每周五、六、日的当地时间20:00-21:00之间可以运行本程序之外。其余时间运行本程序将显示出一条警告信息并直接退出。另外，程序作者水平有限，无法检测当前日期是否为法定节假日，所以如果节假日不是周五、六或日，同样将会有限制。

## 灵感来源
> tips: sudo 板子自己打歌


## 如何使用
### 准备
0. **本程序不支持3.9.0以下的Python，请确保您计算机中安装的Python符合此要求。**
1. 请安装`requirements.txt`中的全部依赖（使用`pip install -r requirements.txt`）。
2. 请确保`adb`命令在`PATH`变量中。如果没有请下载安装并配置`PATH`变量。
3. 请准备Phigros的安装包，目前支持v1.6.9至v1.6.11。如果您的安卓/鸿蒙设备中已经安装有Phigros,则可以依照下面的方法提取【进入根目录需要ROOT，请注意您的设备是否已经获得ROOT权限】：
   1. 将设备连接到安装有`adb`的计算机，且确保设备已开启USB调试模式，且已授权计算机进行调试。
   2. 在计算机上执行命令`adb shell pm path com.PigeonGames.Phigros`，该命令会打印出安装包的路径。
   3. 记上一步得到的路径为`<pkgpath>`(`package:`之后的内容)，执行命令`adb pull <pkgpath> <storage path>`。则安装包将保存到`<storage path>`下（`<storage path>`由您自己指定）。
   4. 如果您已经通过联系作者获得了安装包，则您可以直接略过这一步。
4. 初始化谱面库：请执行`python extract.py`，输入上一步安装包的路径或将安装包拖入程序窗口后回车。将谱面数据从安装包中提取出来。
5. 准备服务端。以下操作二选一。
   1. 如果您的游戏设备为`aarch64`架构，那么可以尝试从[releases](https://github.com/kvarenzn/phisap/releases/) 下载预编译的服务端，并放置在`server/`下。
   2. 如果不是，请按照如下步骤自行编译
      1. **请确保Android NDK已经安装并正确配置**，下一步需要依赖这一步的配置。至于如何配置请参考百度或谷歌。
      2. 编译服务端：请选择下面两项中的一项执行
         1. 如果您的计算机中有`make`命令，请`cd server/`，之后再`make build install`。
         2. 否则，请
            1. 使用`Android Studio`打开`server/`并编译，或者`cd server/`之后`./gradlew -p . assembleRelease`。
            2. 找到编译出的apk文件，一般在`server/build/outputs/apk/release/server-release-unsigned.apk`，请手动将它移动到`server/`并重命名为`phisap-server`。

### 运行
```bash
python main.py
```

## 注意事项
+ 本程序除extract步骤之外，程序本体不依赖root权限工作。
+ 本程序的工作原理为向游戏设备发送触控事件来模拟人类游玩时的点击、长按或滑动。所以，对于部分设备或部分情况，仍有可能因误触发三指截屏或通知中心而导致miss。
+ 本程序依赖使用者手动设置时延来同步游戏内计时器。这也是本程序称为“半自动”的原因。
+ 由于客观原因：
  + 某一时刻为某一曲目的某难度配置的时延并不能保证在下一次游玩相同曲目的相同难度时仍然有效。可能需要在前一时延上进行微调。目前尚未找到不使用root权限而与游戏内计时器同步的方法。
  + 在某些情况下（如游戏设备后台运行太多程序时），游戏内计时器的时间变化率可能与现实时间并不同步，这有时会导致曲目开始时先于判定时刻击打note，临近曲目结束时反而落后于判定时刻的情况，也有可能反过来。
  + 游戏有时会发生漏判现象。这会导致相同的触摸事件序列在应用于同一谱面时，所得分数并不相同。可能需要多尝试几次才能达到φ的成绩。


## 已知的BUG与临时修复方法
### 游戏设备屏幕的流式传输相关代码会在部分手机上崩溃
如[issue#3](https://github.com/kvarenzn/phisap/issues/3) 和[issue#5](https://github.com/kvarenzn/phisap/issues/5)

如果遇到这种情况，请尝试使用如下命令切换到`no-streaming`分支，或许可以临时修复：
```bash
$ cd phisap  # 进入本项目的根目录
$ git checkout no-streaming  # 切换分支
```
后续的步骤与主分支相同。**如果要使用预编译的服务端，请下载`v0.0.1-beta`版本中附加的`phisap-server`**。

### 程序在部分旧版本的adb下会阻塞且没有任何额外输出
如[issue#8](https://github.com/kvarenzn/phisap/issues/8)

这是因为部分旧版本的adb不支持或部分支持`adb reverse`命令。在当前版本下，这个命令是用于服务端(于游戏设备)和客户端(于运行本程序的计算机)之间建立初步通信的重要命令。服务端和客户端之间无法建立通信，导致双方阻塞。本程序在之后的更新中可能会支持`adb forward`命令作为备选通信方案。

要临时解决此问题，请使用最新版本的adb**替换**(不是共存安装)您当前使用的版本。

如果不确定您当前使用的adb版本，请使用`adb version`命令查询。


## 致谢
+ `control.py`和`server/`中的大部分代码参考自[Genymobile/scrcpy](https://github.com/Genymobile/scrcpy) ，并使用`python`和`kotlin`语言重写。
+ `catalog.py`和`extract.py`中的代码参考自[Perfare/AssetStudio](https://github.com/Perfare/AssetStudio) ，并使用`python`语言重写。
+ 谱面解析算法参考自[0thElement/PhiCharter](https://github.com/0thElement/PhiCharter) 。

感谢上述优秀的项目和创造或维护它们的个人或企业。

## 开源许可
除部分有参考来源的代码按其作者要求的方式开源外，**其余代码按照`WTFPL`许可开源。**
