import 'package:chatappx/const/App_color.dart';
import 'package:flutter/material.dart';

class CustomChatBubbleWidget extends StatelessWidget {
  const CustomChatBubbleWidget({super.key, required this.messege});
final String messege;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        decoration: BoxDecoration(
          color: AppColor.prim_color,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
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
