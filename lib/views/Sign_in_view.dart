import 'package:chatappx/const/App_color.dart';
import 'package:chatappx/views/Sign_up_view.dart';
import 'package:chatappx/widgets/CustomTextFormWidget.dart';
import 'package:chatappx/widgets/CustoumButtom.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SignInView extends StatelessWidget {
   SignInView({super.key});
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.prim_color,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Gap(120),
              Center(child: Image.asset('assets/images/scholar.png')),
              Text('Scholar Chat',style: TextStyle(
                color: AppColor.sco_color,
                fontFamily: 'Pacifico',
                fontSize: 35
              ),),
              SizedBox(height: 30,),
               Row(
                mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   Text('Sign In',style: TextStyle(
                    color: AppColor.sco_color,
                    fontSize: 20
                  ),),
                 ],
               ),
            Gap(10),
            CustomTextForm(hint: 'Email', controller: emailController,keyboardType: TextInputType.emailAddress,),
            Gap(10),
            CustomTextForm(hint: 'Password', controller: passwordController, isPassword: true,),
            Gap(10),
            CustoumButtom(hint: 'Sign In',onTap: () {
              
            },),
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text('Don\'t have an account?',style: TextStyle(
                    color: AppColor.sco_color,
                    fontSize: 18
                  ),),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUpView()));
                      },
                      child: Text('Sign Up',style: TextStyle(
                      color: AppColor.third_color,
                      fontSize: 18
                      ),),
                    ),
              ],
            ),


            ],
          ),
        ),
      ),
    );
  }
}