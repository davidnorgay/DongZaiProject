import 'package:flutter/material.dart';
import './neu_box.dart';

class SongPage extends StatefulWidget {
  const SongPage({Key? key}) : super(key: key);

  @override
  State<SongPage> createState() => _SongPageState();
}

// 定义播放模式枚举（放在_SongPageState类外部或内部均可）
enum PlayMode {
  sequence, // 顺序播放
  shuffle,  // 随机播放
  repeatOne // 单曲循环
}
class _SongPageState extends State<SongPage> {
  bool isPlaying = false; // 当前播放状态
  PlayMode currentMode = PlayMode.sequence; // 当前播放模式

  void _switchPlayMode() {//切换播放模式
    setState(() {
      switch (currentMode) {
        case PlayMode.sequence:
          // 从顺序播放切换到随机播放
          currentMode = PlayMode.shuffle;
          print("切换到随机播放");
          break;
        case PlayMode.shuffle:
          // 从随机播放切换到单曲循环
          currentMode = PlayMode.repeatOne;
          print("切换到单曲循环");
          break;
        case PlayMode.repeatOne:
          // 从单曲循环切换到顺序播放
          currentMode = PlayMode.sequence;
          print("切换到顺序播放");
          break;
        }
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    // 获取设备屏幕和安全区域信息
    final mediaQuery = MediaQuery.of(context);
    final safeAreaPadding = mediaQuery.padding;
    
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: mediaQuery.size.height - 
                           safeAreaPadding.top - 
                           safeAreaPadding.bottom,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  // 回退按钮（左右各留10像素）
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap:(){
                          Navigator.pop(context);
                        },
                        child: const Padding(
                          // 左侧10 + 右侧10，对称边距
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: SizedBox(
                            height: 60,
                            width: 60,
                            child: NeuBox(child: Icon(Icons.arrow_back)),//回退按钮
                          ),
                        ),
                      ),
                      Text(
                        '本地歌曲',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          color: Colors.grey.shade700,
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 25),

                  // 专辑封面（左右各留10像素）
                  Padding(
                    // 左侧10 + 右侧10，对称边距
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: NeuBox(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset('lib/images/cover_art.png'),// 专辑封面
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '歌手名',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    const Text(
                                      '歌曲名称',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // 开始时间、随机播放、结束时间
                  // 修改后的代码（支持模式切换）
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('0:00'),// 播放模式切换按钮
                    GestureDetector(
                      onTap: _switchPlayMode, // 点击时触发模式切换
                      child: Icon(// 根据当前模式显示对应图标
                        currentMode == PlayMode.sequence
                            ? Icons.repeat // 顺序播放图标
                            : currentMode == PlayMode.shuffle
                                ? Icons.shuffle // 随机播放图标
                                : Icons.repeat_one, // 单曲循环图标
                        size: 26,
                      ),
                    ),
                    const Text('4:22')
                  ],
                ),

                  const SizedBox(height: 30),

                  // 进度条（左右各留10像素）
                  const Padding(
                    // 左侧10 + 右侧10，对称边距
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: NeuBox(
                      child: SizedBox(
                        height: 10,
                        width: double.infinity,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // 播放控制按钮（左右各留10像素）
                SizedBox(
                  height: 80,
                  child: Row(
                    children: [
                      // 上一曲按钮（可点击）
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // 上一曲点击事件
                            print("上一曲按钮被点击");
                          },
                          child: const NeuBox(
                            child: Icon(
                              Icons.skip_previous,
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                      // 播放/暂停按钮（可点击，切换图标）
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: GestureDetector(
                            onTap: () {
                              // 点击时切换播放状态
                              setState(() {
                                isPlaying = !isPlaying; // 取反当前状态
                              });
                            },
                            child: NeuBox(
                              // 根据状态显示不同图标
                              child: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                size: 32,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // 下一曲按钮
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // 下一曲点击事件
                            print("下一曲按钮被点击");
                          },
                          child: const NeuBox(
                            child: Icon(
                              Icons.skip_next,
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}