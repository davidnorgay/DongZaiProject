import 'package:flutter/material.dart';
import './neu_box.dart';

class SongPage extends StatefulWidget {
  const SongPage({Key? key}) : super(key: key);

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
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

                  // 专辑封面（左右各留10像素）
                  Padding(
                    // 左侧10 + 右侧10，对称边距
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
                                const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 32,
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('0:00'),
                      Icon(Icons.shuffle),
                      Text('4:22')
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
                      children: const [
                        // 上一曲（左右各留10像素）
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            child: NeuBox(
                              child: Icon(
                                Icons.skip_previous,
                                size: 32,
                              ),
                            ),
                          ),
                        ),
                        // 播放/暂停（左右各留10像素）
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: NeuBox(
                                child: Icon(
                                  Icons.play_arrow,
                                  size: 32,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // 下一曲（左右各留10像素）
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            child: NeuBox(
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