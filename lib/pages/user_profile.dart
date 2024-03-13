import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutdeneme2/pages/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutdeneme2/pages/change_profile.dart';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
class more_info extends StatefulWidget {
  final String user_info1;
  final String user_info2;
  final String user_info3;
  final String user_info4;
  more_info({required this.user_info1,required this.user_info2,required this.user_info3,required this.user_info4});
  @override
  _more_info createState() => _more_info();
}

class _more_info extends State<more_info> {
  late  String user_info1;
  late String user_info2;
  late String user_info3;
  late String user_info4;
  void initState() {
    super.initState();
    user_info1=widget.user_info1;
    user_info2=widget.user_info2;
    user_info3=widget.user_info3;
    user_info4=widget.user_info4;
    // bmi_value=double.parse(user_info_list['weight']!)/((double.parse(user_info_list['height']!)/100)*(double.parse(user_info_list['height']!)/100));
    //print('${user_info_list["weight"].toString()}');
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profil Sayfası"),backgroundColor: Colors.blue,centerTitle: true,),
    body:SingleChildScrollView(

    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,

    children:  <Widget>[
    SizedBox(height: 30),
    Container(



    child:Center(
    child: Text(
      "profile",
      style: TextStyle(fontSize: 30, color: Colors.white),
    ),
    ),
    ),
      SizedBox(height: 50),


         Container(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Alerjileri",style: TextStyle(color: Colors.black),textAlign: TextAlign.center),
              Text(user_info1,style: TextStyle(color: Colors.black,fontSize:28.0),textAlign: TextAlign.center),
            ],
          ),
        ),
      SizedBox(height: 50),


      Container(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Aktivite Durumu",style: TextStyle(color: Colors.black)),
            Text(user_info2,style: TextStyle(color: Colors.black,fontSize:28.0)),
          ],
        ),
      ),
      SizedBox(height: 50),


      Container(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text("İlaçlar",style: TextStyle(color: Colors.black)),
            Text(user_info3,style: TextStyle(color: Colors.black,fontSize:28.0)),
          ],
        ),
      ),
      SizedBox(height: 50),
      Container(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Dışkılama Problemi",style: TextStyle(color: Colors.black)),
            Text(user_info4,style: TextStyle(color: Colors.black,fontSize:28.0)),
          ],
        ),
      ),
            
            
            
            
           
          




      
    ],
    ),
    ),
    );
  }

}
class User_profile extends StatefulWidget {
  final String user_id;





  User_profile({required this.user_id});
  @override
  user createState() => user();
}

class user extends State<User_profile> {


  late String userid;
  final Map<String,String> user_info_list ={
    "activity":"",
    "age":"",
    "allergy":"",
    "city":"",
    "defecation":"",
    "email":"",
    "gender":"",
    "height":"",
    "hip":"",
    "neck":"",
    "number":"",
    "pills":"",
    "userName":"",
    "weight":"",
    "weist":"",
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
double bmi_value=0;
 double o_rate=0;
  Future<String> asicron_method(Map <String,String> user_info_list ,String userid) async{
    await FirebaseFirestore.instance.collection('users').doc(userid).get()
        .then((value) {
// Get value of field date from document dashboard/totalVisitors
user_info_list.forEach((key, val) {
  user_info_list[key] = value.data()![key];

});
try {
  bmi_value=double.parse(user_info_list['weight']!)/((double.parse(user_info_list['height']!)/100)*(double.parse(user_info_list['height']!)/100));
} catch (e) {
print(e.toString());
}
try {
  o_rate=495 / (1.0324 - 0.19077 * log((double.parse(user_info_list['weist']!)-double.parse(user_info_list['neck']!))) + 0.15456 * log (double.parse(user_info_list['height']!))) - 450;
} catch (e) {
 print( e.toString());
}

});

 return user_info_list["email"].toString();
  }


// Get document with ID totalVisitors in collection dashboard


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



                      child:Column(
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
                                Text("Boy",style: TextStyle(color: Colors.black)),
                                Text(user_info_list["height"].toString(),style: TextStyle(color: Colors.black,fontSize:28.0)),
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
                                Text("Kilo",style: TextStyle(color: Colors.black)),
                                Text(user_info_list["weight"].toString(),style: TextStyle(color: Colors.black,fontSize:28.0)),
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
                                Text("BMI",style: TextStyle(color: Colors.black)),
                                Text(bmi_value.toStringAsFixed(2),style: TextStyle(color: Colors.black,fontSize:28.0)),
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
                                Text("Yağ Oranı",style: TextStyle(color: Colors.black)),
                                Text(o_rate.toStringAsFixed(2),style: TextStyle(color: Colors.black,fontSize:28.0)),
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
                    SizedBox(height: 60),
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

                                TextButton(
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (
                                        context) => more_info(user_info1: user_info_list["allergy"].toString(), user_info2: user_info_list["activity"].toString(), user_info3: user_info_list["pills"].toString(),user_info4: user_info_list["defecation"].toString())),);
                                  },
                                  child: Text(
                                    'Ayrıntıl Bilgi',
                                    style: TextStyle(color: Colors.blue, fontSize: 20),
                                  ),
                                ),
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

                                TextButton(
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (
                                        context) => change_profile(

                                      user_city: user_info_list["city"].toString(),
                                      user_number: user_info_list["number"].toString(),
                                      user_height:user_info_list["height"].toString(),
                                      user_weight: user_info_list["weight"].toString(),
                                      user_age: user_info_list["age"].toString(),

                                      user_pills: user_info_list["pills"].toString(),
                                      user_allergy: user_info_list["allergy"].toString(),
                                      user_activity: user_info_list["activity"].toString(),
                                      user_defecation: user_info_list["defecation"].toString(),
                                      user_lip: user_info_list["hip"].toString(),
                                      user_weist: user_info_list["weist"].toString(),
                                      user_neck: user_info_list["neck"].toString(),
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
                  ],




                ),
              ),
            );
          }
        }
    );



  }
}

