import 'package:chatappx/const/App_color.dart';
import 'package:flutter/material.dart';

void ShowSnackBar({required BuildContext context,required String text, Color ?color}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color ?? AppColor.third_color,
      behavior: SnackBarBehavior.floating, // جعلها عائمة بدلاً من الالتصاق بالأسفل
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // حواف دائرية ناعمة
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // مسافة من الحواف
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      duration: Duration(seconds: 2),
      content: Text(
        text,
        style: TextStyle(
          color: AppColor.sco_color,
          fontSize: 15,
          fontFamily: 'Prime',
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
