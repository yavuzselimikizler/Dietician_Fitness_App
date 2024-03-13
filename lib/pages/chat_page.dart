import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutdeneme2/pages/message_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
class ChatMessage{
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}
class add_dietician extends StatefulWidget {
  final String user_id;
  final String user_name;
  add_dietician({required this.user_name,required this.user_id});
  @override
  _add_dietician createState() => _add_dietician();
}

class _add_dietician extends State<add_dietician> {
  late String userid;
  late String username;
  void initState() {
    super.initState();
    userid=widget.user_id;
    username=widget.user_name;

    // bmi_value=double.parse(user_info_list['weight']!)/((double.parse(user_info_list['height']!)/100)*(double.parse(user_info_list['height']!)/100));
    //print('${user_info_list["weight"].toString()}');
  }
  final List<String> name_list = [];
  final List<String> age_list = [];
  final List<String> city_list = [];
  final List<String> expertise_list = [];
  final List<String> email_list = [];
  final List<String> image_list=[];
  String dietician_name="";
  String myimage="empty";
  Future<String> get_image(String dieticianid)async{
    var myurl;
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {

        if(doc['type']=='type2' && doc['email']==dieticianid){

          dietician_name=doc['userName'];
          myimage=doc['image'];
        }

      });
    });
    if(myimage!="empty"){

      Reference  ref = FirebaseStorage.instance.ref().child("${myimage}");
      myurl= await ref.getDownloadURL();

    }
    else{
      myurl=myimage;
    }

    return myurl;
  }
  Future<String> asicron_method( List<String>  name_list,List<String>  age_list,List<String>  city_list,List<String>  expertise_list
      ,List<String>  email_list) async{

    var sth;
   await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {

        if(doc['type']=='type2'){

          name_list.add(doc["userName"]);
          age_list.add(doc["age"]);
          city_list.add(doc["city"]);
          expertise_list.add(doc["expertise"]);
          email_list.add(doc["email"]);
          image_list.add(doc["image"]);
        }

      });
    });





    return name_list[0];

  }
  Future<void> updateUser (
      String dietician,
      String user_id

      ) async{
    return FirebaseFirestore.instance.collection('users')
        .doc(user_id)
        .update({'dietician': dietician,




    })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  MessageService dialog= MessageService();


  Widget build(BuildContext context) {

    return FutureBuilder(
        future: asicron_method(name_list,age_list,city_list,expertise_list,email_list),
        builder: (BuildContext context, AsyncSnapshot snap)
    {
      if(snap.data==null){
        return Center(
          child: CircularProgressIndicator(),);
      }
      else{
        return Scaffold(
          appBar: AppBar(title: Text("Mesajlaşma Sayfası"),
            backgroundColor: Colors.amber,
            centerTitle: true,),
          body: SingleChildScrollView(
           child: Container(
             alignment:Alignment.center,
             decoration: BoxDecoration(
               border: Border.all(),
               color: Colors.pinkAccent,
             ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                for(var i=0;i<name_list.length;i++)
                  Container(
                    alignment:Alignment.center,

                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: Colors.grey,
                    ),
                    child:Column(

                      children: <Widget>[

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              children:[
                                FutureBuilder(future:get_image(email_list[i]),
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

                            Text(name_list[i],style:TextStyle(fontSize: 15, color: Colors.black),),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text("Şehir: ${city_list[i]}",style:TextStyle(fontSize: 15, color: Colors.black),),

                            Text("Yaş: ${age_list[i]}",style:TextStyle(fontSize: 15, color: Colors.black),),
                            Text("Uzmanlık: ${expertise_list[i]} yıl",style:TextStyle(fontSize: 15, color: Colors.black),),
                          ],
                        ),
                        TextButton(onPressed: (){
                          updateUser(email_list[i], userid);
                          dialog.createdialoge(email_list[i], username);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Diyetisyen eklendi"),
                                  content: Text("başarılı"),
                                  actions: [
                                    TextButton(
                                      child: Text("Ok"),
                                      onPressed: () {
                                        Navigator.of(context).pop();

                                      },
                                    )
                                  ],
                                );
                              });


                        }, child: Text("add"))
                      ],
                    ),
                  ),





              ],
            ),
           ),

          ),
        );
      }

    } );
  }

}
class chat_center extends StatefulWidget {
  final String user_name;
  final String user_password;
  final String user_id;
  chat_center({required this.user_name,required this.user_password,required this.user_id});
  @override
  chat_clas createState() => chat_clas();
}

class chat_clas extends State<chat_center> {
 late String userid;
 late String username;
 late String full_id;
late String dietician_id;

  void initState() {
    super.initState();
    userid=widget.user_id;
    username=widget.user_name;
    new Timer.periodic(Duration(seconds: 1), (Timer t) => setState((){}));
    // bmi_value=double.parse(user_info_list['weight']!)/((double.parse(user_info_list['height']!)/100)*(double.parse(user_info_list['height']!)/100));
    //print('${user_info_list["weight"].toString()}');
  }

 Future<String> dietician_exist() async{
    String dietician_checker="";
   await FirebaseFirestore.instance.collection('users').doc(userid).get()
       .then((value) {
// Get value of field date from document dashboard/totalVisitors

       dietician_checker = value.data()!["dietician"];



   });

   return dietician_checker;
 }
 _getRequests()async{

 }
 TextEditingController mycontroller= TextEditingController();
 List<ChatMessage> messages = [

 ];
 final ScrollController _controller = ScrollController();
 final String dietician_checker="";
// This is what you're looking for!
  void _scrollDown() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }
  String dietician_name="";
  String myimage="empty";
  Future<String> get_image(String dieticianid)async{
    var myurl;
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {

        if(doc['type']=='type2' && doc['email']==dieticianid){

          dietician_name=doc['userName'];
          myimage=doc['image'];
        }

      });
    });
    if(myimage!="empty"){

      Reference  ref = FirebaseStorage.instance.ref().child("${myimage}");
      myurl= await ref.getDownloadURL();

    }
    else{
      myurl=myimage;
    }

    return myurl;
  }
  Future<void> send_message(final String message,final String dialog_id,final String user_type)async{
  String dietician_checker="";
    await FirebaseFirestore.instance.collection('users').doc(userid).get()
        .then((value) {
// Get value of field date from document dashboard/totalVisitors

      dietician_checker = value.data()!["dietician"];

    });
    var documentReference = FirebaseFirestore.instance
        .collection('messages')
        .doc(dietician_checker+dialog_id)
        .collection(dietician_checker+dialog_id)
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
  late String dietician_email;
  Widget build(BuildContext context) {

    return FutureBuilder(
    future: dietician_exist(),
        builder: (BuildContext context, AsyncSnapshot snap){
      if(snap.data=="empty"){
        return
           Align(
             alignment: Alignment.center,
        child:Container(
          alignment: Alignment.center,
        height: 100,
        child:Column(
        children: <Widget>[

            Text("Diyetisyen Ekle"),
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (
                  context) => add_dietician(user_name:username,user_id: userid,))).then((_) {
                // This block runs when you have returned back to the 1st Page from 2nd.
                setState(() {
                  // Call setState to refresh the page.
                });
              });
            },
            icon: const Icon(Icons.supervisor_account),
          ),
          ],
          ),
        ),
          );


      }
      else if(snap.data==null){
        return Center(

          child: CircularProgressIndicator(),);
      }
      else{
         final List<String> message_list=[];
        dietician_exist().then((value){
          full_id=value + username;
          dietician_id=value;
        });


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
                           FutureBuilder(future:get_image(dietician_id),
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
                                   get_image(dietician_id);
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
                         child:
                             Text(dietician_name, style: TextStyle(
                                 fontSize: 12, fontWeight: FontWeight.w600),),



                       ),

                       TextButton(onPressed: (){
                         showDialog(
                             context: context,
                             builder: (BuildContext context) {
                               return AlertDialog(
                                 title: Text("Uyarı"),
                                 content: Text("Emin misiniz !"),
                                 actions: [
                                   TextButton(
                                     child: Text("iptal"),
                                     onPressed: () {
                                       Navigator.of(context).pop();
                                     },
                                   ),
                                   TextButton(
                                     child: Text("onayla"),
                                     onPressed: () async {
                                       await FirebaseFirestore.instance.collection("users").doc(userid).update({
                                         'dietician':'empty',


                                       })
                                           .then((value) => print("User Updated"))
                                           .catchError((error) => print("Failed to update user: $error"));
                                       Navigator.of(context).pop();
                                     },
                                   )
                                 ],
                               );
                             });
                         Timer(Duration(seconds: 1),(){
                           setState(() {

                           });
                         });

                       }, child: Text("Diyetisyenimi Çıkar",style: TextStyle(color: Colors.red,fontSize: 13,decoration: TextDecoration.underline,),)),


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
                         alignment: (snapshot.data?.docs[index].data()["type"].toString() == "type2"
                             ? Alignment.topLeft
                             : Alignment.topRight),
                         child: Container(
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(20),
                             color: (snapshot.data?.docs[index].data()["type"].toString() == "type2"
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
                             ChatMessage add_message = ChatMessage(
                                 messageContent: mycontroller.text,
                                 messageType: "sender");

                             messages.add(add_message);



                             dietician_exist();
                             send_message(
                                 mycontroller.text,
                                 dietician_checker + username,
                                 "type1");
                           /*  Timer(Duration(seconds: 1),(){
                               setState(() {

                               });
                             });*/


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