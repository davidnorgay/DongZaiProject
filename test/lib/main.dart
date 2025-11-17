import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title:'登录界面',
      home:Scaffold(
        appBar:AppBar(title: const Text('我的应用')),
        body:const Center(child: LoginPanel(),)
      ),
    );
  }
}

class LoginPanel extends StatelessWidget{
  const LoginPanel({super.key});

  @override
  Widget build(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('登录',
        style:TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          )
        ),
        const SizedBox(height: 30),
        ElevatedButton(
         onPressed: (){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('登录按钮被点击了')),
          );
         },
         child: const Text('登录'),
        ),
      ],
    );
  }
}