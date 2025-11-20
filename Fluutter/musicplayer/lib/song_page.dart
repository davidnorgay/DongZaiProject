import 'package:flutter/material.dart';
import './neu_box.dart';

class SongPage extends StatefulWidget {
  const SongPage({Key? key}) : super(key: key);

  @override
  State<SongPage> createState() => _SongPageState();
}

// 定义播放模式枚举
enum PlayMode {
  sequence, // 顺序播放
  shuffle,  // 随机播放
  repeatOne // 单曲循环
}

class _SongPageState extends State<SongPage> {
  bool isPlaying = false; // 当前播放状态
  PlayMode currentMode = PlayMode.sequence; // 当前播放模式

  void _switchPlayMode() { // 切换播放模式
    setState(() {
      switch (currentMode) {
        case PlayMode.sequence:
          currentMode = PlayMode.shuffle;
          print("切换到随机播放");
          break;
        case PlayMode.shuffle:
          currentMode = PlayMode.repeatOne;
          print("切换到单曲循环");
          break;
        case PlayMode.repeatOne:
          currentMode = PlayMode.sequence;
          print("切换到顺序播放");
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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

                  // 回退按钮
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap:(){
                          Navigator.pop(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: SizedBox(
                            height: 60,
                            width: 60,
                            child: NeuBox(child: Icon(Icons.arrow_back)),
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

                  // 专辑封面
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: NeuBox(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset('lib/images/cover_art.png'),
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

                  // 播放模式切换行
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('0:00'),
                      GestureDetector(
                        onTap: _switchPlayMode,
                        child: Icon(
                          currentMode == PlayMode.sequence
                              ? Icons.repeat
                              : currentMode == PlayMode.shuffle
                                  ? Icons.shuffle
                                  : Icons.repeat_one,
                          size: 26,
                        ),
                      ),
                      const Text('4:22')
                    ],
                  ),

                  const SizedBox(height: 30),

                  // 进度条
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: NeuBox(
                      child: SizedBox(
                        height: 10,
                        width: double.infinity,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // 播放控制按钮（上一首、播放/暂停、下一首）
                  SizedBox(
                    height: 80,
                    child: Row(
                      children: [
                        // 上一曲按钮（添加左右10.0边距）
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              print("上一曲按钮被点击");
                            },
                            child: const Padding( // 新增：左右各10.0边距
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: NeuBox(
                                child: Icon(
                                  Icons.skip_previous,
                                  size: 32,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // 播放/暂停按钮（已有边距，保持不变）
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isPlaying = !isPlaying;
                                });
                              },
                              child: NeuBox(
                                child: Icon(
                                  isPlaying ? Icons.pause : Icons.play_arrow,
                                  size: 32,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // 下一曲按钮（添加左右10.0边距）
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              print("下一曲按钮被点击");
                            },
                            child: const Padding( // 新增：左右各10.0边距
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: NeuBox(
                                child: Icon(
                                  Icons.skip_next,
                                  size: 32,
                                ),
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