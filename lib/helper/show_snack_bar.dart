import 'package:chatappx/const/App_color.dart';
import 'package:flutter/material.dart';

void ShowSnackBar({required BuildContext context,required String text, Color ?color}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color ?? AppColor.third_color,
      content: Text(
        text,
        style: TextStyle(
          color: AppColor.sco_color,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
