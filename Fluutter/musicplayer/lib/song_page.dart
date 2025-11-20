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
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          // 使用SingleChildScrollView实现滚动
          child: SingleChildScrollView(
            // 弹性滚动效果
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              // 确保内容区域至少占满屏幕可见高度
              constraints: BoxConstraints(
                minHeight: mediaQuery.size.height - 
                           safeAreaPadding.top - 
                           safeAreaPadding.bottom,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  // 回退按钮和菜单按钮
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: NeuBox(child: Icon(Icons.arrow_back)),
                      ),
                      Text('本 地 歌 曲'),
                      
                    ],
                  ),

                  const SizedBox(height: 25),

                  // 专辑封面、艺术家名、歌曲名
                  NeuBox(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset('lib/images/cover_art.png'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
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

                  const SizedBox(height: 30),

                  // 开始时间、随机播放、重复播放、结束时间
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text('0:00'),
                      Icon(Icons.shuffle),
                      Icon(Icons.repeat),
                      Text('4:22')
                    ],
                  ),

                  const SizedBox(height: 30),

                  // 进度条区域（如果需要可自行添加）
                  const NeuBox(
                    child: SizedBox(
                      height: 10,
                      width: double.infinity,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // 上一曲、播放/暂停、下一曲
                  SizedBox(
                    height: 80,
                    child: Row(
                      children: const [
                        Expanded(
                          child: NeuBox(
                              child: Icon(
                            Icons.skip_previous,
                            size: 32,
                          )),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: NeuBox(
                                child: Icon(
                              Icons.play_arrow,
                              size: 32,
                            )),
                          ),
                        ),
                        Expanded(
                          child: NeuBox(
                              child: Icon(
                            Icons.skip_next,
                            size: 32,
                          )),
                        ),
                      ],
                    ),
                  ),

                  // 底部额外间距，确保最后元素可完全显示
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