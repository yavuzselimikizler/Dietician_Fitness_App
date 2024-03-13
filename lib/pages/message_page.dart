import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../main.dart';
class message_page extends StatefulWidget {
  final String user_id;
  late String newname;
  message_page({required this.user_id,required this.newname});
  @override
  _message_state2 createState() => _message_state2();
}

class _message_state2 extends State<message_page> {

 late String userid;
late String full_id;
late String newname;
  void initState() {
    super.initState();
    userid=widget.user_id;
    full_id="";
    newname=widget.newname;
    new Timer.periodic(Duration(seconds: 1), (Timer t) => setState((){}));

    // bmi_value=double.parse(user_info_list['weight']!)/((double.parse(user_info_list['height']!)/100)*(double.parse(user_info_list['height']!)/100));
    //print('${user_info_list["weight"].toString()}');
  }
 TextEditingController mycontroller= TextEditingController();
 final ScrollController _controller = ScrollController();
 Future<String> dietician_exist() async{
   String dietician_checker="";
   await FirebaseFirestore.instance.collection('users').doc(userid).get()
       .then((value) {
// Get value of field date from document dashboard/totalVisitors

     dietician_checker = value.data()!["current"];



   });

   return dietician_checker;
 }
 String user_name="";
 String myimage="empty";
 Future<String> get_image(String fullid)async{
   var myurl;
  print(userid + " burası");

  String user_id="sth";
 // for(int i=userid.length)
   user_id= fullid.substring(newname.length, fullid.length) ;
   print(newname);


 print("birşey söyle");
   await FirebaseFirestore.instance
       .collection('users')
       .get()
       .then((QuerySnapshot querySnapshot) {
     querySnapshot.docs.forEach((doc) {

       if(doc['type']=='type1' && doc['email']==user_id){

         user_name=doc['userName'];
         myimage=doc['image'];
       }

     });
   });
   if(myimage!="empty"){
     print(myimage);
     Reference  ref = FirebaseStorage.instance.ref().child("${myimage}");
     myurl= await ref.getDownloadURL();

   }
   else{
     myurl=myimage;
   }
   print(myimage);
   return myurl;
 }
 Future<void> send_message(final String message,final String dialog_id,final String user_type)async{
   String dietician_checker="";

   var documentReference = FirebaseFirestore.instance
       .collection('messages')
       .doc(dialog_id)
       .collection(dialog_id)
       .doc(DateTime.now().millisecondsSinceEpoch.toString());

   FirebaseFirestore.instance.runTransaction((transaction) async {
     await transaction.set(
       documentReference,
       {

         'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
         'content': message,
         'type': user_type,
       },
     );
   });
   _controller.animateTo(
       0.0,
       duration: Duration(milliseconds: 300),
       curve: Curves.easeOut);
   mycontroller.clear();

 }
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: dietician_exist(),
        builder: (BuildContext context, AsyncSnapshot snap){
          if(snap.data=="empty"){
            return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text("Müşteriler Sayfası", style: TextStyle(color: Colors.white,
                      fontSize: 16, fontWeight: FontWeight.w600),),
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.redAccent,
                  flexibleSpace: SafeArea(

                    // padding: EdgeInsets.only(right: 16),

                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,




                    child: Align(
                      alignment: Alignment.centerRight,
                      child:IconButton(
                        icon: const Icon(Icons.exit_to_app),

                        onPressed: ()  {
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) => MyApp(




                          )),);

                        },
                      ),
                    ),



                  ),
                ),
              body:Center(
              child: Text("you have not any dialog"),),);
          }
          else if(snap.data==null){
          return Center(

          child: CircularProgressIndicator(),);
          }
          else {
            final List<String> message_list=[];
            dietician_exist().then((value){
              full_id=value;
            });
            print(full_id);

            return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('messages')
                  .doc(full_id)
                  .collection(full_id)
                  .orderBy('timestamp', descending: true)

                  .snapshots(),
              builder: (context, snapshot)
              {
                if (!snapshot.hasData) {
                  return Center(

                    child: CircularProgressIndicator(),);
                }
                else {

                  return Scaffold(
                    appBar: AppBar(
                      elevation: 0,
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.white,
                      flexibleSpace: SafeArea(
                        child: Container(
                          padding: EdgeInsets.only(right: 16),
                          child: Row(
                            children: <Widget>[

                              SizedBox(width: 2,),
                              Column(
                                children:[
                                  FutureBuilder(future:get_image(full_id),
                                      builder: (BuildContext context, AsyncSnapshot snap){
                                        if(snap.data==null){
                                          return Center(

                                            child: CircularProgressIndicator(),);
                                        }
                                        else if(snap.data=="empty"){
                                          return Center(
                                              child:

                                              CircleAvatar(

                                                backgroundColor: Colors.black,
                                                radius: 20,
                                                child: Text(
                                                  userid,
                                                  style: TextStyle(fontSize: 30, color: Colors.white),
                                                ),


                                              )

                                          );
                                        }
                                        else{
                                          return Center(
                                              child:CircleAvatar(

                                                backgroundColor: Colors.black,
                                                radius: 20,
                                                backgroundImage:NetworkImage(snap.data.toString()),


                                              )
                                          );
                                        }
                                      }

                                  ),
                                ],
                              ),
                              SizedBox(width: 12,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(user_name, style: TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.w600),),
                                    SizedBox(height: 6,),

                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                    body: Stack(
                      children: <Widget>[
                        ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          shrinkWrap: true,
                          controller: _controller,
                          reverse: true,

                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          physics: AlwaysScrollableScrollPhysics(),

                          itemBuilder: (context, index) {
                            message_list.add(snapshot.data?.docs[index].data()["content"]);
                            String? message=snapshot.data?.docs[index].data()["content"].toString();
                            return Container(
                              padding: EdgeInsets.only(
                                  left: 14, right: 14, top: 10, bottom: 10),
                              child: Align(
                                alignment: (snapshot.data?.docs[index].data()["type"].toString() == "type1"
                                    ? Alignment.topLeft
                                    : Alignment.topRight),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: (snapshot.data?.docs[index].data()["type"].toString() == "type1"
                                        ? Colors.grey.shade200
                                        : Colors.blue[200]),
                                  ),
                                  padding: EdgeInsets.all(16),
                                  child: Text(message!,
                                    style: TextStyle(fontSize: 15),),
                                ),
                              ),
                            );
                          },

                        ),

                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                            height: 40,
                            width: double.infinity,
                            color: Colors.white,
                            child: Row(
                              children: <Widget>[

                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintText: "Write message...",
                                        hintStyle: TextStyle(color: Colors.black54),
                                        border: InputBorder.none
                                    ),
                                    controller: mycontroller,
                                  ),
                                ),
                                SizedBox(width: 15,),
                                FloatingActionButton(
                                  onPressed: () {




                                    dietician_exist();
                                    send_message(
                                        mycontroller.text,
                                        full_id,
                                        "type2");

                                      setState(() {

                                      });



                                  },
                                  child: Icon(
                                    Icons.send, color: Colors.white, size: 18,),
                                  backgroundColor: Colors.blue,
                                  elevation: 0,
                                ),
                              ],

                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            );




          }

        });
  }

}