import 'package:flutter/material.dart';
import './neu_box.dart';
import './song_page.dart';
import './HomePage.dart';

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

