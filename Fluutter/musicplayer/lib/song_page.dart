import 'package:flutter/material.dart';
import './neu_box.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SongPage extends StatefulWidget {//歌曲详情页的状态组件
  const SongPage({Key? key}) : super(key: key);

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {//歌曲详情页的状态组件
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(//边距
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          
          child: Column(//列布局
            children: [
              const SizedBox(height: 10),//间距

              // back button and menu button
              Row(//行布局
                mainAxisAlignment: MainAxisAlignment.spaceBetween,//两端对齐
                children: const [
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: NeuBox(child: Icon(Icons.arrow_back)),//左上角的返回按钮
                  ),
                  Text('本地音乐'),
                  // SizedBox(
                  //   height: 60,
                  //   width: 60,
                  //   child: NeuBox(child: Icon(Icons.menu)),
                  // ),
                ],
              ),

              const SizedBox(height: 25),

              // cover art, artist name, song name
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
                                '歌手名称',
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

              // start time, shuffle button, repeat button, end time
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

              // linear bar
              NeuBox(
                child: LinearPercentIndicator(
                  lineHeight: 10,
                  percent: 0.8,
                  progressColor: Colors.green,
                  backgroundColor: Colors.transparent,
                ),
              ),

              const SizedBox(height: 30),

              // previous song, pause play, skip next song
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
              )
            ],
          ),
        ),
      ),
    );
  }
}