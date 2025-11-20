import 'package:flutter/material.dart';

class NeuBox extends StatelessWidget {
  final child;
  const NeuBox({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Center(child: child),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15),//圆角
        boxShadow: [
          // darker shadow on the bottom right
          BoxShadow(
            color: Colors.grey.shade500,
            blurRadius: 7,//模糊半径
            offset: Offset(3, 3),
          ),

          // lighter shadow on the top left
          const BoxShadow(
            color: Colors.white,
            blurRadius: 7,//模糊半径
            offset: Offset(-3, -3),//偏移量
          ),
        ],
      ),
    );
  }
}