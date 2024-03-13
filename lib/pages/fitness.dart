import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutdeneme2/pages/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';
class fitness_movement extends StatefulWidget {
  final int exercise_type;


  fitness_movement({required this.exercise_type});
  @override
  ex_clas createState() => ex_clas();
}

class ex_clas extends State<fitness_movement> {

  late int body_part;


  void initState() {
    super.initState();
    body_part=widget.exercise_type;
  }
  final List<String> body_list=['arm','chest','shoulder','back','belly'];
  final List<String> body_list_turkish=['kol','göğüs','omuz','sırt','karın'];
 final List<String> text_list=[""];
  Future<String> loadImage(String img_url) async{
    //current user id


    //collect the image name


    //a list of images names (i need only one)
   print(img_url);

    //select the image url
    Reference  ref = FirebaseStorage.instance.ref().child("${img_url}");
 String url2="";
    //get image url from firebase storage
    var url = (await ref.getDownloadURL());


   // put the URL in the state, so that the UI gets rerendered
 print(url);
   return url;
  }
 Widget build(BuildContext context){
   text_list.clear();
   return StreamBuilder(
       stream: FirebaseFirestore.instance
       .collection(body_list[body_part])


       .snapshots(),
   builder: (context, snapshot)  {
   if (!snapshot.hasData) {
   return Center(

   child: CircularProgressIndicator(),);
   }
   else{
    return Scaffold(
      backgroundColor: Colors.black,
       appBar: AppBar(
         title: Text(body_list_turkish[body_part]+" egzersizleri"),backgroundColor: Colors.black,centerTitle: true,
       ),
       body: Stack(
         children: <Widget>[
           ListView.builder(
             itemCount: snapshot.data?.docs.length,
             shrinkWrap: true,

             reverse: true,

             padding: EdgeInsets.only(top: 10, bottom: 10),
             physics: AlwaysScrollableScrollPhysics(),

             itemBuilder: (context, index) {
               text_list.add(snapshot.data?.docs[index].data()["text"]);
               var my_str=snapshot.data?.docs[index].data()["image"];




               //select the image url


               //get image url from firebase storage


               return FutureBuilder(
               future:loadImage(my_str),
               builder: (BuildContext context, AsyncSnapshot snap){

               if(snap.data==null){
                return Center(

                   child: CircularProgressIndicator(),);
               }
               else{
                 print(snap.data.toString());
               return Container(
               padding: EdgeInsets.only(
               left: 14, right: 14, top: 10, bottom: 10),
               child:Column(
               children:<Widget>[
               Image.network(snap.data.toString()),
               Text(text_list[index],style: TextStyle(fontSize: 12,color: Colors.white),),

               ],
               ),
               );
               }

               }
               );
             },

           ),


         ],
       ),
     );
   }
   },);
 }

}



  class fitness_center extends StatefulWidget {
  final String user_name;
  final String user_password;

  fitness_center({required this.user_name,required this.user_password});
  @override
  fitt_clas createState() => fitt_clas();
}

class fitt_clas extends State<fitness_center> {
  AuthService _authService = AuthService();
  late String user_name;
  late String user_password;
  late String get_str;
  void initState() {
    super.initState();
    user_name=widget.user_name;
    user_password=widget.user_password;

  }



  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Fitness Sayfası"),backgroundColor: Colors.black,centerTitle: true,
      ),
       body:SingleChildScrollView(

         child: Column(

           children: <Widget>[

             Text("Kol Egzersizleri",
               style: TextStyle(color: Colors.white, fontSize: 25),),
             Padding(
               padding: const EdgeInsets.only(
                   left: 15.0, right: 15.0, top: 15, bottom: 0),
               child: TextButton(
                 onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (
                     context) => fitness_movement(
                   exercise_type: 0,



                 )),); }, child: Image.asset("assets/kol_fitness.jpg"),
             ) ,
             ),
             Text("Göğüs Egzersizleri",
             style: TextStyle(color: Colors.white, fontSize: 25),),
             Padding(
             padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextButton(
                 onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (
                     context) => fitness_movement(
                   exercise_type: 1,



                 )),);  }, child: Image.asset("assets/göğüs_fitness.jpg"),
             ),
             ),
             Text("Omuz Egzersizleri",
               style: TextStyle(color: Colors.white, fontSize: 25),),
             Padding(
               padding: EdgeInsets.symmetric(horizontal: 15),
               child: TextButton(
                 onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (
                     context) => fitness_movement(
                   exercise_type: 2,



                 )),);  }, child: Image.asset("assets/omuz_fitness.jpeg"),
               ),
             ),
             Text("Sırt Egzersizleri",
               style: TextStyle(color: Colors.white, fontSize: 25),),
             Padding(
               padding: EdgeInsets.symmetric(horizontal: 15),
               child: TextButton(
                 onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (
                     context) => fitness_movement(
                   exercise_type: 3,



                 )),);  }, child: Image.asset("assets/sırt_img.jpeg"),
               ),
             ),
             Text("Karın Egzersizleri",
               style: TextStyle(color: Colors.white, fontSize: 25),),
             Padding(
               padding: EdgeInsets.symmetric(horizontal: 15),
               child: TextButton(
                 onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (
                     context) => fitness_movement(
                   exercise_type: 4,



                 )),);  }, child: Image.asset("assets/karın_fitness.jpg"),
               ),
             ),


           ],
         ),
       ),


    );
  }

}