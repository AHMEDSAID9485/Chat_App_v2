import 'package:chatappx/const/App_color.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.prim_color,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/scholar.png',height: 55,),
            Text('Chat',style: TextStyle(color: AppColor.sco_color,fontSize: 25),)
     
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        child: Column(
          children: [
            Container(
              height: 70,
              width: 200,
              
              decoration: BoxDecoration(
                color: AppColor.prim_color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                
              ),
            )
          ],
        ),
      ),
    );
  }
}