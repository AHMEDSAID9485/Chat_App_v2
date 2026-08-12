import 'package:chatappx/const/App_color.dart';
import 'package:chatappx/helper/show_snack_bar.dart';
import 'package:chatappx/views/Chat_view.dart';
import 'package:chatappx/views/Sign_up_view.dart';
import 'package:chatappx/widgets/CustomTextFormWidget.dart';
import 'package:chatappx/widgets/CustoumButtom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignInView extends StatefulWidget {
  SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
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
  Future<void> _signInUser() async {
    if (formKey.currentState!.validate()) {
      
    FocusScope.of(context).unfocus();
  setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      if (!mounted) return;

      ShowSnackBar(
        context: context,
        text: 'Logged in successfully!',
        color: AppColor.third_color,
      );
       Future.delayed(const Duration(seconds: 4), () {
        if (!mounted) return; // حماية الاستدعاء بعد الـ Async
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ChatView()),
        );
      });
    }  on FirebaseAuthException catch (e) {
      if (!mounted) return;

      String errorMessage = 'An error occurred. Please try again.';
      if (e.code == 'wrong-password') {
        errorMessage = 'The password provided is incorrect.';
      } else if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } 

      ShowSnackBar(
        context: context,
        text: errorMessage,
        color: AppColor.four_color,
      );
    } catch (e) {
      ShowSnackBar(context: context, text: 'An error occurred. Please try again.', color: AppColor.four_color);
    }finally {
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
        backgroundColor: AppColor.prim_color,
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Gap(120),
                  Center(child: Image.asset('assets/images/scholar.png')),
                  Text(
                    'Scholar Chat',
                    style: TextStyle(
                      color: AppColor.sco_color,
                      fontFamily: 'Pacifico',
                      fontSize: 35,
                    ),
                  ),
                  Text(
                    'Welcome back👋',
                    style: TextStyle(
                      color: AppColor.five_color,
                      fontFamily: 'Prime',
                      fontSize: 30,
                    ),
                  ),
                  Gap(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Sign In',
                        style: TextStyle(color: AppColor.five_color, fontSize: 30,fontFamily: 'Prime'),
                      ),
                    ],
                  ),
                 const Gap(10),
                  CustomTextForm(
                    hint: 'Email',
                    autofillHints: [AutofillHints.email],
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                 const Gap(10),
                  CustomTextForm(
                    hint: 'Password',
                    controller: passwordController,
                    isPassword: true,
                  ),
                 const Gap(10),
                  CustoumButtom(
                    hint: 'Sign In',
                    onTap: _signInUser
                  ),
                 const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(color: AppColor.sco_color, fontSize: 18),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => SignUpView()),
                          );
                        },
                        child: Text(
                          ' Sign Up',
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
