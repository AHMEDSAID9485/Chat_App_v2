
import 'package:chatappx/const/App_color.dart';
import 'package:chatappx/models/messege_model.dart';
import 'package:chatappx/widgets/CustomChatBubbleWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ChatView extends StatelessWidget {
   ChatView({super.key, required this.email});
   final String email;
 final CollectionReference users = FirebaseFirestore.instance.collection('Messages');
 final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      body: StreamBuilder(
      stream: users.orderBy('timestamp').snapshots(),
      builder: ( context,snapshot){
        List<MessegeModel> messges = [];
         if(snapshot.hasData){
         for(int i = 0 ; i < snapshot.data!.docs.length ; i++){
          messges.add(MessegeModel(
            messege: snapshot.data!.docs[i]['messege'],
            timestamp: (snapshot.data!.docs[i]['timestamp'] as Timestamp).toDate(),
            id: snapshot.data!.docs[i]['id'],
          ));
         }
          return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                separatorBuilder: (context, index) => Gap(10),
                itemBuilder: (context, index) => messges[index].id == email
                    ? CustomChatBubbleWidget(messege: messges[index].messege)
                    : CustomChatBubbleWidget(messege: messges[index].messege,bubbleColor: Colors.orange,),
                itemCount: messges.length,
                shrinkWrap: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                controller: controller,
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
                  suffixIcon: GestureDetector(
                    onTap: () {
                      if(controller.text.isNotEmpty && controller.text !=''){
                        users.add({'messege':controller.text,'timestamp':DateTime.now(), 'id':email});
                      }
                       controller.clear();                    
                      // FocusScope.of(context).unfocus();
                    },
                    child: Icon(Icons.send, color: AppColor.prim_color)),
                ),
              ),
            ),
          ],
        ),
      );
         }else{
          return Center(child: CircularProgressIndicator(color: AppColor.prim_color,));
         }
      }),
    );
  }
}
