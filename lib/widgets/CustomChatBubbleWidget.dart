import 'package:chatappx/const/App_color.dart';
import 'package:flutter/material.dart';

class CustomChatBubbleWidget extends StatelessWidget {
   CustomChatBubbleWidget({super.key, required this.messege, this.bubbleColor});
final String messege;
final Color? bubbleColor;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: bubbleColor == null ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        decoration: BoxDecoration(
          color: bubbleColor == null ? AppColor.prim_color : bubbleColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: bubbleColor == null ? Radius.circular(20) : Radius.zero,
            bottomLeft: bubbleColor == null ? Radius.zero : Radius.circular(20),
          ),
        ),
        child: Text(
          messege,
          style: TextStyle(color: AppColor.sco_color),
        ),
      ),
    );
  }
}
