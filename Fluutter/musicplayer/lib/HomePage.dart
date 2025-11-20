import 'song_page.dart';//导入歌曲详情页的状态组件
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title:'本 地 歌 曲',
      theme:ThemeData(
        primarySwatch:Colors.grey,
      ),
      home:MyHome(),
    );
  }
}
class MyHome extends StatefulWidget{//状态组件
  @override
  _MyHomeState createState()=>_MyHomeState();//创建状态组件
}

class _MyHomeState extends State<MyHome>{
  Map? currentSong;//用Map存储当前播放的歌曲，null表示没有播放
  bool isPlaying=false;//是否正在播放

  @override
  Widget build(BuildContext context){
    return Scaffold(//脚手架
        appBar:AppBar(//顶部导航栏
          title:Text("本地音乐"),
          centerTitle: true,
          actions:<Widget>[//右侧搜索按钮
            IconButton(
              icon:Icon(Icons.search),
              onPressed: (){})
          ],

        ), 
        drawer:Drawer(//左侧抽屉
          child:ListView(children:<Widget>[
            GestureDetector(
              onTap:(){
                print("点击了1");
              },
              child:ListTile(title:Text("本地音乐"),leading:Icon(Icons.music_note)),
            ),
            Divider(),//分割线
            GestureDetector(
              onTap:(){
                print("点击了2");
              },
              child: ListTile(title:Text("智能推歌"),leading:Icon(Icons.music_video)),
            ),
            Divider(),//分割线
            GestureDetector(
              onTap:(){
                print("点击了3");
              },
              child: ListTile(title:Text("设置"),leading:Icon(Icons.settings)),
              ), 
            ],
          ),
        ),
        body:Center(
          child: Text("本地音乐列表"),
        ),

        bottomNavigationBar:_buildPlayer(),//底部歌曲栏
      );
  }//build
  Widget _buildPlayer(){//底部歌曲栏
    bool hasSong=currentSong!=null;//现在是否有歌曲播放
    return Container(
      height:80,
      color:Colors.grey[200],
      padding:EdgeInsets.symmetric(horizontal:16),
      child:Row(
        children:[
          GestureDetector(
            onTap:()=>_navigateToSongPage(),//点击歌曲图片进入歌曲详情页
            child:Container(
              width: 50,
              height: 50,
              decoration:BoxDecoration(//歌曲图片
                borderRadius:BorderRadius.circular(8),//圆角
                color:Colors.grey[300],//背景颜色
              ),
              child:hasSong
                ?
                Image.network(
                  currentSong!['cover'],//歌曲图片
                  fit:BoxFit.cover,
                )
                :
                Image.asset(
                  'lib/images/default_cover.png',//默认图片
                  fit:BoxFit.cover,
                ),
            ),
          ),
          Expanded(
            child:GestureDetector(
              onTap:()=>_navigateToSongPage(),//点击歌曲信息进入歌曲详情页
              child:Text(
                hasSong?currentSong!['name']:"暂无歌曲",
                style:TextStyle(
                  fontSize:16,
                  fontWeight:FontWeight.w500,
                  overflow: TextOverflow.ellipsis,//超出部分用省略号显示
                ),
              ),
            ),
          ),
          SizedBox(width: 12),//间距
          IconButton(
            icon:Icon(
              isPlaying?Icons.pause:Icons.play_arrow,
              size:28,
            ),
            onPressed:(){//点击播放按钮,切换播放状态
              setState((){
                isPlaying=!isPlaying;
              });
            },
          ),
          IconButton(
            icon:Icon(
              Icons.list,
              size:28,
            ),
            onPressed: (){
              print("点击了列表按钮");
            },
          ),
        ],
      ),
    );
  }

  void _navigateToSongPage(){//进入歌曲详情页
    Navigator.push(//跳转到歌曲详情页
      context,
      MaterialPageRoute(//页面路由
        builder:(context)=>SongPage(),//跳转到SongPage页面
      ),
    );
  }

}