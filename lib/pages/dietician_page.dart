import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
class change_profile extends StatefulWidget {

  final String user_number;
  final String user_city;
  final String user_name;

  final String user_age;
  final String user_id;
  final String user_expertise;
  change_profile({required this.user_city,required this.user_number,
    required this.user_age, required this.user_expertise,required this.user_name,

    required this.user_id});
  @override
  _change_profile createState() => _change_profile();
}

class _change_profile extends State<change_profile> {

  late String user_number;
  late String user_city;
  late String user_id;
  late String user_expertise;
  late String user_age;
  late String user_name;


  void initState(){
    super.initState();
    user_number=widget.user_number;
    user_city=widget.user_city;
    user_id=widget.user_id;

    user_age=widget.user_age;
    user_name=widget.user_name;
    user_expertise=widget.user_expertise;

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

      String user_expertise,
      String user_age,
       String user_id,

      ) async{
    return users
        .doc(user_id)
        .update({'age': user_age,
      'number': user_number,
      'city': user_city,
      'expertise':user_expertise,


    })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }



  Widget build(BuildContext context) {
    final my_controller = TextEditingController(text:user_age);
    final my_controller2 = TextEditingController();
    final my_controller3 = TextEditingController();
    final my_controlle4 = TextEditingController();

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
                      "profil fotoğrafı ekle",
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
                initialValue: user_expertise,
                // <-- SEE HERE
                decoration: InputDecoration(
                  labelText: 'Tecrübe',
                  border: OutlineInputBorder(),
                  fillColor: Color(0xffD9D9D9),
                ),
                onChanged: (text){
                  user_expertise=text;
                },

              ),
            ),

            SizedBox(height: 30),


            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                autofocus: false,
                initialValue: user_number,
                // <-- SEE HERE
                decoration: InputDecoration(
                  labelText: 'telefon no',
                  border: OutlineInputBorder(),
                  fillColor: Color(0xffD9D9D9),
                ),
                onChanged: (text){
                  user_number=text;
                },

              ),
            ),
            TextButton(onPressed: (){
              updateUser(user_number, user_city, user_expertise, user_age, user_id);
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

class dietician_page extends StatefulWidget {
 final String user_id;
  dietician_page({required  this.user_id});
  @override
  _dietician_state2 createState() => _dietician_state2();
}

class _dietician_state2 extends State<dietician_page> {

  late String userid;
  final Map<String,String> user_info_list ={
    "education":"",
    "age":"",
    "gender":"",
    "expertise":"",
    "city":"",
    "number":"",
    "userName":"",

  };
  void initState() {
    super.initState();
    userid=widget.user_id;


    // bmi_value=double.parse(user_info_list['weight']!)/((double.parse(user_info_list['height']!)/100)*(double.parse(user_info_list['height']!)/100));
    //print('${user_info_list["weight"].toString()}');
  }
  String myimage="empty";

  Future<String> get_image() async{
    var myurl;
    await FirebaseFirestore.instance.collection('users').doc(userid).get()
        .then((value) {
// Get value of field date from document dashboard/totalVisitors
      myimage=value.data()!["image"];

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
  Future<String> asicron_method(Map <String,String> user_info_list ,String userid) async{
    await FirebaseFirestore.instance.collection('users').doc(userid).get()
        .then((value) {
// Get value of field date from document dashboard/totalVisitors
      user_info_list.forEach((key, val) {
        user_info_list[key] = value.data()![key];

      });

    });

    return user_info_list["userName"].toString();
  }
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: asicron_method(user_info_list, userid), // the function to get your data from firebase or firestore
        builder : (BuildContext context, AsyncSnapshot snap){
          if(snap.data == null){
            return Center(
              child: CircularProgressIndicator(),);
          }
          else{
            return Scaffold(

              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text("Profil Sayfası"),backgroundColor: Colors.blue,centerTitle: true,
              ),

              body:SingleChildScrollView(

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:  <Widget>[
                    SizedBox(height: 30),
                    Container(


                     child :Column(

                      children: <Widget>[


                        Column(
                          children:[
                            FutureBuilder(future:get_image(),
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
                                          radius: 50,
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
                                          radius: 50,
                                          backgroundImage:NetworkImage(snap.data.toString()),


                                        )
                                    );
                                  }
                                }

                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            user_info_list["userName"].toString(),
                            style: TextStyle(fontSize: 30, color: Colors.black),
                          ),
                        )
                ],
            ),
                    ),
                    SizedBox(height: 50),
                    Container(

                      child: Row(

                        children : <Widget>[
                          Expanded( // <-- SEE HERE
                            child: SizedBox.shrink(),
                            flex: 1,
                          ),
                          Container(

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Yaş",style: TextStyle(color: Colors.black)),
                                Text(user_info_list["age"].toString(),style: TextStyle(color: Colors.black,fontSize:28.0)),
                              ],
                            ),
                          ),
                          Expanded( // <-- SEE HERE
                            child: SizedBox.shrink(),
                            flex: 3,
                          ),
                          Container(

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Cinsiyet",style: TextStyle(color: Colors.black)),
                                Text(user_info_list["gender"].toString(),style: TextStyle(color: Colors.black,fontSize:28.0)),
                              ],
                            ),
                          ),
                          Expanded( // <-- SEE HERE
                            child: SizedBox.shrink(),
                            flex: 1,
                          ),
                        ],

                      ),


                    ),
                    SizedBox(height: 50),
                    Container(

                      child: Row(

                        children : <Widget>[
                          Expanded( // <-- SEE HERE
                            child: SizedBox.shrink(),
                            flex: 1,
                          ),
                          Container(

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Eğitim",style: TextStyle(color: Colors.black)),
                                Text(user_info_list["education"].toString(),style: TextStyle(color: Colors.black,fontSize:28.0)),
                              ],
                            ),
                          ),
                          Expanded( // <-- SEE HERE
                            child: SizedBox.shrink(),
                            flex: 3,
                          ),
                          Container(

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Uzmanlık",style: TextStyle(color: Colors.black)),
                                Text("${user_info_list["expertise"].toString()} yıl",style: TextStyle(color: Colors.black,fontSize:28.0)),
                              ],
                            ),
                          ),
                          Expanded( // <-- SEE HERE
                            child: SizedBox.shrink(),
                            flex: 1,
                          ),
                        ],

                      ),


                    ),
                    SizedBox(height: 50),
                    Container(

                      child: Row(

                        children : <Widget>[
                          Expanded( // <-- SEE HERE
                            child: SizedBox.shrink(),
                            flex: 1,
                          ),




                        ],

                      ),


                    ),
                    SizedBox(height: 60),
                    Container(

                      child: Center(




                          child:Container(

                            child:


                                TextButton(
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (
                                        context) => change_profile(

                                      user_city: user_info_list["city"].toString(),
                                      user_number: user_info_list["number"].toString(),
                                      user_name: user_info_list["userName"].toString(),
                                      user_age: user_info_list["age"].toString(),
                                      user_expertise: user_info_list["expertise"].toString(),

                                      user_id: userid,
                                    )),).then((_) {
                                      // This block runs when you have returned back to the 1st Page from 2nd.
                                      setState(() {
                                        // Call setState to refresh the page.
                                      });
                                    });
                                  },
                                  child: Text(
                                    'Profili Düzenle',
                                    style: TextStyle(color: Colors.blue, fontSize: 20),
                                  ),
                                ),


                          ),



                      ),


                    ),
                  ],




                ),
              ),
            );
          }
        }
    );
  }

}