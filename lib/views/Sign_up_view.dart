import 'package:chatappx/const/App_color.dart';
import 'package:chatappx/helper/show_snack_bar.dart';
import 'package:chatappx/views/Chat_view.dart';
import 'package:chatappx/views/Sign_in_view.dart';
import 'package:chatappx/widgets/CustomTextFormWidget.dart';
import 'package:chatappx/widgets/CustoumButtom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // حل مشكلة تسريب الذاكرة (Memory Leak)
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _registerUser() async {
    // 1. التحقق من صحة المدخلات أولاً قبل تفعيل الـ Loading
    if (formKey.currentState!.validate())  {
       // إخفاء لوحة المفاتيح عند البدء
    FocusScope.of(context).unfocus();

    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(), // إزالة المسافات الزائدة
        password: passwordController.text,
      );
      // 2. التحقق من أن الـ Widget ما زال موجودًا قبل عرض Snackbar أو التنقل
      if (!mounted) return; // حماية الاستدعاء بعد الـ Async

      ShowSnackBar(
        context: context,
        text: 'Registered successfully!',
      );
      Future.delayed(const Duration(seconds: 4), () {
        if (!mounted) return; // حماية الاستدعاء بعد الـ Async
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ChatView()),
        );
      });
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      String errorMessage = 'An error occurred. Please try again.';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is invalid.';
      }

      ShowSnackBar(
        context: context,
        text: errorMessage,
        color: AppColor.four_color,
      );
    } catch (e) {
      if (!mounted) return;

      ShowSnackBar(
        context: context,
        text: 'An unexpected error occurred.',
        color: AppColor.four_color,
      );
    } finally {
      // إيقاف الـ Loading دائماً سواء نجحت العملية أو فشلت
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
    }

   

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor:  AppColor.prim_color,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Gap(120),
                  Center(child:  Image.asset('assets/images/scholar.png')),
                  Text(
                    'Scholar Chat',
                    style: TextStyle(
                      color: AppColor.sco_color,
                      fontFamily: 'Pacifico',
                      fontSize: 35,
                    ),
                  ),
                  Text(
                    'Welcome🤝',
                    style: TextStyle(
                      color: AppColor.five_color,
                      fontFamily: 'Prime',
                      fontSize: 30,
                    ),
                  ),
                  const Gap(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Sign Up',
                       style: TextStyle(color: AppColor.five_color, fontSize: 30,fontFamily: 'Prime'),
                      ),
                    ],
                  ),
                  const Gap(10),
                  CustomTextForm(
                    hint: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email';
                      }
                      // فحص صيغة الإيميل
                      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (!emailRegex.hasMatch(value.trim())) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const Gap(10),
                  CustomTextForm(
                    hint: 'Password',
                    isPassword: true,
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const Gap(10),
                  CustoumButtom(
                    hint: 'Sign UP',
                    onTap: _registerUser, // فصل الدالة لجعل الكود أنظف وأسهل للصيانة
                  ),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                          color: AppColor.sco_color,
                          fontSize: 18,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInView())); // استخدمنا اسم المسار بدلاً من إنشاء MaterialPageRoute جديد
                        },
                        child: Text(
                          ' Sign In',
                          style: TextStyle(
                            color: AppColor.five_color,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}