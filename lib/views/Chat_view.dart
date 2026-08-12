import 'package:chatappx/const/App_color.dart';
import 'package:chatappx/widgets/CustomChatBubbleWidget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
            Image.asset('assets/images/scholar.png', height: 55),
            Text(
              'Chat',
              style: TextStyle(color: AppColor.sco_color, fontSize: 25),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                separatorBuilder: (context, index) => Gap(10),
                itemBuilder: (context, index) => CustomChatBubbleWidget(),
                itemCount: 10,
                shrinkWrap: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                cursorColor: AppColor.prim_color,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      width: 2,
                      color: AppColor.prim_color,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      width: 2,
                      color: AppColor.prim_color,
                    ),
                  ),
                  hintText: 'Send Message',
                  suffixIcon: Icon(Icons.send, color: AppColor.prim_color),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
