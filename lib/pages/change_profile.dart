import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutdeneme2/pages/user_profile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
class change_profile extends StatefulWidget {

  final String user_number;
  final String user_city;

  final String user_height;
  final String user_weight;
  final String user_age;

  final String user_pills;
  final String user_allergy;
  final String user_activity;
  final String user_defecation;
  final String user_lip;
  final String user_neck;
  final String user_weist;
  final String user_id;
  change_profile({required this.user_city,required this.user_number,
    required this.user_height,required this.user_weight,required this.user_age,required this.user_pills,
    required this.user_allergy,required this.user_activity,required this.user_defecation,required this.user_lip,required this.user_weist,required this.user_neck
  ,required this.user_id});
  @override
  _change_profile createState() => _change_profile();
}

class _change_profile extends State<change_profile> {

  late String user_number;
  late String user_city;
  late String user_id;
  late String user_height;
  late String user_weight;
  late String user_age;

  late String user_pills;
  late String user_allergy;
  late String user_activity;
  late String user_defecation;
  late String user_lip;
  late String user_neck;
  late String user_weist;

  void initState(){
    super.initState();
     user_number=widget.user_number;
     user_city=widget.user_city;

     user_height=widget.user_height;
     user_weight=widget.user_weight;
     user_age=widget.user_age;

     user_pills=widget.user_pills;
     user_allergy=widget.user_allergy;
    user_activity=widget.user_activity;
     user_defecation=widget.user_defecation;
     user_lip=widget.user_lip;
     user_neck=widget.user_neck;
     user_weist=widget.user_weist;
     user_id=widget.user_id;

  }
  CollectionReference users = FirebaseFirestore.instance.collection('users');
 Future<void> upload_image()async{



      users
         .doc(user_id)
         .update({
       'image':"profiles/"+user_id+".jpg",


     })
         .then((value) => print("User Updated"))
         .catchError((error) => print("Failed to update user: $error"));

      final image = await ImagePicker().pickImage(source: ImageSource.gallery,maxWidth: 512,maxHeight: 512,imageQuality: 75);
      Reference  ref = FirebaseStorage.instance.ref().child("profiles/"+user_id+".jpg");

      await ref.putFile(File(image!.path));
   }

  Future<void> updateUser (
  String user_number,
  String user_city,

  String user_height,
   String user_weight,
   String user_age,

  String user_pills,
   String user_allergy,
   String user_activity,
  String user_defecation,
   String user_lip,
   String user_neck,
   String user_weist,
   String user_id
      ) async{
    return users
        .doc(user_id)
        .update({'age': user_age,
      'number': user_number,
      'city': user_city,
      'weight': user_weight,
      'height': user_height,
      'pills': user_pills,
      'allergy': user_allergy,
      'activity': user_activity,
      'defecation': user_defecation,
      'hip': user_lip,
      'neck': user_neck,
      'weist': user_weist,


      })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }



  Widget build(BuildContext context) {
    final my_controller = TextEditingController(text:user_age);
    final my_controller2 = TextEditingController();
    final my_controller3 = TextEditingController();
    final my_controlle4 = TextEditingController();
    final my_controller5 = TextEditingController();
    final my_controller6 = TextEditingController();
    final my_controller7 = TextEditingController();
    final my_controller8 = TextEditingController();
    final my_controller9 = TextEditingController();
    final my_controller10 = TextEditingController();
    final my_controller11 = TextEditingController();
    final my_controller12 = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("Profili Düzenle"),backgroundColor: Colors.blue,centerTitle: true,),
        body: SingleChildScrollView(

          child: Column(

            children: <Widget>[
              SizedBox(height: 20),
              Container(



                child:Center(
                  child: GestureDetector(
                    onTap: (){
                      upload_image();
                    },
                    child:CircleAvatar(

                    backgroundColor: Colors.black,
                    radius: 50,
                    child: Text(
                      "profile",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),


                  ),
                ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  autofocus: false,
                  initialValue: user_age,
                  // <-- SEE HERE
                  decoration: InputDecoration(
                    labelText: 'Yaş',
                    border: OutlineInputBorder(),
                    fillColor: Color(0xffD9D9D9),
                  ),
                   onChanged: (text){
                    user_age=text;
                   },
                ),
              ),
              SizedBox(height: 30),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  autofocus: false,
                  initialValue: user_weight,
                  // <-- SEE HERE
                  decoration: InputDecoration(
                    labelText: 'Kilo(kg)',
                    border: OutlineInputBorder(),
                    fillColor: Color(0xffD9D9D9),
                  ),
                  onChanged: (text){
                    user_weight=text;
                  },

                ),
              ),
              SizedBox(height: 30),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  autofocus: false,
                  initialValue: user_height,
                  // <-- SEE HERE
                  decoration: InputDecoration(
                    labelText: 'Boy(cm)',
                    border: OutlineInputBorder(),
                    fillColor: Color(0xffD9D9D9),
                  ),
                  onChanged: (text){
                    user_height=text;
                  },

                ),
              ),
              SizedBox(height: 30),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  autofocus: false,
                  initialValue: user_city,
                  // <-- SEE HERE
                  decoration: InputDecoration(
                    labelText: 'Şehir',
                    border: OutlineInputBorder(),
                    fillColor: Color(0xffD9D9D9),
                  ),
                  onChanged: (text){
                    user_city=text;
                  },

                ),
              ),
              SizedBox(height: 30),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  autofocus: false,
                  initialValue: user_activity,
                  // <-- SEE HERE
                  decoration: InputDecoration(
                    labelText: 'Aktivite Durumu',
                    border: OutlineInputBorder(),
                    fillColor: Color(0xffD9D9D9),
                  ),
                  onChanged: (text){
                    user_activity=text;
                  },

                ),
              ),
              SizedBox(height: 30),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  autofocus: false,
                  initialValue: user_pills,
                  // <-- SEE HERE
                  decoration: InputDecoration(
                    labelText: 'Kullandığı İlaçlar',
                    border: OutlineInputBorder(),
                    fillColor: Color(0xffD9D9D9),
                  ),
                  onChanged: (text){
                    user_pills=text;
                  },

                ),
              ),
              SizedBox(height: 30),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  autofocus: false,
                  initialValue: user_allergy,
                  // <-- SEE HERE
                  decoration: InputDecoration(
                    labelText: 'Alerjileri',
                    border: OutlineInputBorder(),
                    fillColor: Color(0xffD9D9D9),
                  ),
                  onChanged: (text){
                    user_allergy=text;
                  },

                ),
              ),
              SizedBox(height: 30),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  autofocus: false,
                  initialValue: user_defecation,
                  // <-- SEE HERE
                  decoration: InputDecoration(
                    labelText: 'Dışkılama Problemi',
                    border: OutlineInputBorder(),
                    fillColor: Color(0xffD9D9D9),
                  ),
                  onChanged: (text){
                    user_defecation=text;
                  },

                ),
              ),
              SizedBox(height: 30),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  autofocus: false,
                  initialValue: user_lip,
                  // <-- SEE HERE
                  decoration: InputDecoration(
                    labelText: 'Kalça Çevresi(cm)',
                    border: OutlineInputBorder(),
                    fillColor: Color(0xffD9D9D9),
                  ),
                  onChanged: (text){
                    user_lip=text;
                  },

                ),
              ),
              SizedBox(height: 30),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  autofocus: false,
                  initialValue: user_neck,
                  // <-- SEE HERE
                  decoration: InputDecoration(
                    labelText: 'Boyun Çevresi(cm)',
                    border: OutlineInputBorder(),
                    fillColor: Color(0xffD9D9D9),
                  ),
                  onChanged: (text){
                    user_neck=text;
                  },

                ),
              ),
              SizedBox(height: 30),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  autofocus: false,
                  initialValue: user_weist,
                  // <-- SEE HERE
                  decoration: InputDecoration(
                    labelText: 'Bel Çevresi(cm)',
                    border: OutlineInputBorder(),
                    fillColor: Color(0xffD9D9D9),
                  ),
                  onChanged: (text){
                    user_weist=text;
                  },

                ),
              ),
              TextButton(onPressed: (){
                updateUser(user_number, user_city, user_height, user_weight, user_age, user_pills, user_allergy, user_activity, user_defecation, user_lip, user_neck, user_weist, user_id);
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Profil değiştirildi"),
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
              }

                  , child: Text("Bitir")),


            ],


          ),


        ),
    );
  }

}