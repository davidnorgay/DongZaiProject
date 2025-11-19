import 'package:flutter/material.dart';
import './neu_box.dart';

void main()=>runApp(HomePage());

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title:'本地歌曲',
      theme:ThemeData(
        primarySwatch:Colors.grey,
      ),
      home:MyHome(),
    );
  }
}

class MyHome extends StatelessWidget{//主页面
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
      );
  }
}
