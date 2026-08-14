import 'package:chatappx/const/App_color.dart';
import 'package:flutter/material.dart';

class CustomTextForm extends StatefulWidget {
  const CustomTextForm({
    super.key,
    required this.hint,
    this.isPassword = false, this.controller, this.keyboardType, this.validator, this.autofillHints, // ضفنا المتغير ده عشان نحدد لو ده حقل باسورد ولا لأ
  });
final TextEditingController? controller; // ضفنا الكنترولر عشان نقدر نستخدمه في تسجيل الدخول والتسجيل
  final String hint;
  final bool isPassword;
final TextInputType? keyboardType;
final String? Function(String?)? validator; // ضفنا الفاليديتر عشان نقدر نستخدمه في تسجيل الدخول والتسجيل
  final Iterable<String>? autofillHints;
  @override
  State<CustomTextForm> createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {
  bool isObscure = true; // متغير للتحكم في إخفاء وإظهار النص

  @override
  void initState() {
    super.initState();
    // لو الحقل ده باسورد، النص هيكون مخفي في البداية، غير كده هيكون ظاهر
    isObscure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColor.prim_color,
      autofillHints: widget.autofillHints,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      validator: widget.validator,
      style: TextStyle(
        color: AppColor.sco_color
      ),
      obscureText: isObscure, // الخاصية المسؤولة عن إخفاء النص
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: TextStyle(color: AppColor.sco_color, fontSize: 20),
        
        // إضافة أيقونة العين هنا لو الحقل ده عبارة عن باسورد
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  isObscure ? Icons.visibility_off : Icons.visibility,
                  color: AppColor.sco_color,
                ),
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure; // عكس الحالة عند الضغط
                  });
                },
              )
            : null, // لو مش باسورد، مش هنحط أيقونة

        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 3,
            color: AppColor.sco_color,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: AppColor.sco_color,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: AppColor.sco_color,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}