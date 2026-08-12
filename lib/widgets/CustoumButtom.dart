
import 'package:chatappx/const/App_color.dart';
import 'package:flutter/material.dart';

class CustoumButtom extends StatelessWidget {
  const CustoumButtom({
    super.key, required this.hint, required this.onTap,
  });
final String hint;
final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColor.sco_color
        ),
        child: Center(child: Text(hint,style: TextStyle(color: AppColor.prim_color,fontSize: 25),)),
      ),
    );
  }
}
