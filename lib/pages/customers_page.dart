
import 'dart:async';
import 'dart:math';
import 'package:flutdeneme2/pages/message_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutdeneme2/pages/dietician_homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'main.dart';

class customers_generate extends StatefulWidget {


  final String user_id;
  final int mealtime;

  customers_generate({required this.user_id,required this.mealtime});

  @override
  _customers_generate createState() => _customers_generate();
}
class _customers_generate extends State<customers_generate> {
  late String user_id;
  late int mealtime;
  void initState() {
    super.initState();
    user_id = widget.user_id;
    mealtime=widget.mealtime;



  }

  final List<String> meals=[];
 final List<String> mealTimeList=["kahvaltı","ara öğün 1","öğle yemeği","ara öğün 2","akşam yemeği"];
  Future<void> upload_list()async{
String listword="";

for(int i=0 ;i<meals.length;i++){
  listword= listword+meals[i] + '*';
}
if (listword != null && listword.length > 0) {
  listword = listword.substring(0, listword.length - 1);

}

await FirebaseFirestore.instance.collection('users').doc(user_id)
    .update({

  mealTimeList[mealtime]:listword,

})
    .then((value) => print("User Updated"))
    .catchError((error) => print("Failed to update user: $error"));

Navigator.of(context).pop();
  }
  TextEditingController mycontroller= TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Liste Oluştur"),
        backgroundColor: Colors.green,
        centerTitle: true,),
      body:SingleChildScrollView(

        child:Column(
          children: <Widget>[
            SizedBox(height: 10,),
            Container(
              width:300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.horizontal(),
                color: (Colors.green[400]),
              ),
              child: TextButton(
                onPressed: (){
                  upload_list();
                },
                child:Text(
                  'Onayla',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),

            ),
             SizedBox(height: 20,),
             Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 40,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[

                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "enter a meal...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none
                      ),
                      controller: mycontroller,
                    ),
                  ),
                  SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: () {
                     meals.add(mycontroller.text);
                     mycontroller.clear();
                     setState(() {

                     });
                    },
                    child: Icon(
                      Icons.add, color: Colors.white, size: 18,),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],

              ),
            ),
            SizedBox(height: 20,),
            for(int i=0;i<meals.length;i++)Container(
              padding: EdgeInsets.only(
                  left: 14, right: 14, top: 10, bottom: 10),
              child: Align(
                alignment: (Alignment.center),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: (Colors.grey[200]),
                  ),
                  padding: EdgeInsets.all(16),
                  child:


                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(meals[i]),

                          IconButton(
                            icon: const Icon(Icons.remove),

                            onPressed: () {
                         meals.removeAt(i);
                         setState(() {

                         });
                            },
                          ),

                        ],
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


class customers_setlist extends StatefulWidget {


  final String user_id;


  customers_setlist({required this.user_id});

  @override
  _customers_setlist createState() => _customers_setlist();
}
class _customers_setlist extends State<customers_setlist> {
  late String user_id;

  void initState() {
    super.initState();
    user_id = widget.user_id;




  }



  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Diyet Programı Ekle"),backgroundColor: Colors.green,centerTitle: true,),
      body:Container(

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: (Colors.white),
        ),

        padding: EdgeInsets.only(
            left: 14, right: 14, top: 10, bottom: 10),
        child: Align(
          alignment: Alignment.center,
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(),
              color: (Colors.grey[400]),
            ),
            child:Center(child:Text(
              'Öğünler',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            ),
          ),
        SizedBox(height: 10,),
        Container(



          child: Container(
            width: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(),
              color: (Colors.grey[400]),
            ),
           // padding: EdgeInsets.all(16),
            padding: EdgeInsets.only(
                left: 14, right: 14, top: 10, bottom: 10),
            child: Column(
              children: <Widget>[
                Container(
                  width:300,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(),
                  color: (Colors.red[400]),
                ),
                  child: TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (
                          context) => customers_generate(user_id:user_id ,mealtime: 0,)),);

                    },
                    child:Text(
                      'kahvaltı',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
                ),
                SizedBox(height: 80),
                Container(
                  width:300,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(),
                  color: (Colors.blue[400]),
                ),
                  child: TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (
                          context) => customers_generate(user_id:user_id ,mealtime: 1,)),);
                    },
                    child:Text(
                      'Ara Öğün 1',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(height: 80),
                Container(
                  width:300,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(),
                  color: (Colors.yellow[400]),
                ),
                  child: TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (
                          context) => customers_generate(user_id:user_id ,mealtime: 2,)),);
                    },
                    child:Text(
                      'Öğle Yemeği',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(height: 80),
                Container(
                  width:300,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(),
                  color: (Colors.green[400]),
                ),
                  child: TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (
                          context) => customers_generate(user_id:user_id ,mealtime: 3,)),);
                       print(user_id);
                    },
                    child:Text(
                      'Ara Öğün 2',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(height: 80),
                Container(
                  width:300,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(),
                  color: (Colors.orange[400]),
                ),
                  child: TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (
                          context) => customers_generate(user_id:user_id ,mealtime: 4,)),);
                    },
                    child:Text(
                      'Akşam Yemeği',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ),



              ],
            ),
          ),

        ),
        ],
      ),

        ),

      ),
    );
  }
}


class customers_listpage extends StatefulWidget {


  final String user_name;


  customers_listpage({required this.user_name});

  @override
  _customers_program createState() => _customers_program();
}
class _customers_program extends State<customers_listpage> {
  late String user_name;
  late Map<String,String> my_map;
  void initState() {
    super.initState();
    user_name = widget.user_name;




  }
  String snack1="";
  String snack2="";
  String breakfast="";
  String lunch="";
  String dinner="";
  final List<String> mealtime=[];
  List<List<String>> diet_list= [[]];
  void fill_list(){
    int prev=0;
    diet_list.clear();
    List<String> parts = breakfast.split('*');
  print(breakfast);

    diet_list.add(parts);
    List<String> parts2 = snack1.split('*');


    diet_list.add(parts2);
    List<String> parts3 = lunch.split('*');


    diet_list.add(parts3);

    List<String> parts4 = snack2.split('*');


    diet_list.add(parts4);

    List<String> parts5 = dinner.split('*');


    diet_list.add(parts5);

   //print(parts5);
    print(diet_list[4]);


  }
  List<String> mealtimelist=["kahvaltı","ara öğün 1","öğle yemeği","ara öğün 2","akşam yemeği",];
  Future<String> asicron_method( List<String> mealtime ) async{

    var sth;
    print(user_name);
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {

        if(doc['type']=='type1' && doc['email']==user_name){


            breakfast=doc["kahvaltı"];
            snack1=doc["ara öğün 1"];
            lunch=doc["öğle yemeği"];
            snack2=doc["ara öğün 2"];
            dinner=doc["akşam yemeği"];







        }

      });
    });



    fill_list();

    return dinner;

  }

  Widget build(BuildContext context) {
   return FutureBuilder(future: asicron_method(mealtime),
       builder: (BuildContext context, AsyncSnapshot snap){
     if(snap.data==''){
      return Center(
         child: CircularProgressIndicator(),);
     }
     else{
     /* for (var i =0;i<diet_list.length;i++){
        diet_list[i].clear();
      }
      diet_list.clear();*/


      return Scaffold(
        appBar: AppBar(title: Text("Diyet Sayfası"),backgroundColor: Colors.green,centerTitle: true,),
        body: SingleChildScrollView(

          child: Column(
            children: <Widget>[

              for(var index2=0;index2<5;index2++)Container
                (

                child : Column(

                  children: <Widget>[







                    Container
                      (
                      child:Stack(
                        children: <Widget>[
                          Text(" "+mealtimelist[index2]+ " :"),
                          ListView.builder(
                              itemCount: diet_list[index2].length,
                              shrinkWrap: true,

                              reverse: false,
                              physics: ScrollPhysics(),
                              padding: EdgeInsets.only(top: 10, bottom: 10),


                              itemBuilder: (context, index3) {


                                return Container(
                                  padding: EdgeInsets.only(
                                      left: 14, right: 14, top: 10, bottom: 10),
                                  child: Text(diet_list[index2][index3]),
                                );
                              }
                          ),
                        ],

                      ),
                    ),
                  ],
                ),




              ),
            ],
          ),
        ),
      );
     }
       });
  }
}

class customers_info_page extends StatefulWidget {


   final String user_name;
  final String user_height;
  final String user_weight;
  final String user_age;
 final String user_gender;
  final String user_pills;
  final String user_allergy;
  final String user_activity;
  final String user_defecation;
  final String user_hip;
  final String user_neck;
  final String user_weist;

  customers_info_page({required this.user_name,required this.user_gender,
    required this.user_height,required this.user_weight,required this.user_age,required this.user_pills,
    required this.user_allergy,required this.user_activity,required this.user_defecation,required this.user_hip,required this.user_weist,required this.user_neck
    });

  @override
  _customers_info createState() => _customers_info();
}
class _customers_info extends State<customers_info_page>{
  late String user_name;
  late String user_height;
  late String user_weight;
  late String user_age;
  late String user_gender;
  late String user_pills;
  late String user_allergy;
  late String user_activity;
  late String user_defecation;
  late String user_hip;
  late String user_neck;
  late String user_weist;
  late double bmi_value;
  late double o_rate;
  void initState() {
    super.initState();
     user_name=widget.user_name;
     user_height=widget.user_height;
     user_weight=widget.user_weight;
     user_age=widget.user_age;
     user_gender=widget.user_gender;
    user_pills=widget.user_pills;
    user_allergy=widget.user_allergy;
     user_activity=widget.user_activity;
     user_defecation=widget.user_defecation;
     user_hip=widget.user_hip;
     user_neck=widget.user_neck;
     user_weist=widget.user_weist;


     bmi_value=double.parse(user_weight)/((double.parse(user_height)/100)*(double.parse(user_height)/100));
   o_rate=495 / (1.0324 - 0.19077 * log((double.parse(user_weist)-double.parse(user_neck))) + 0.15456 * log (double.parse(user_height))) - 450;
    //print('${user_info_list["weight"].toString()}');
  }

 /* void get_the_other(String user_weight,String user_height,String user_neck,String user_weist,double bmi_value,double o_rate){
bmi_value=double.parse(user_weight)/((double.parse(user_height)/100)*(double.parse(user_height)/100));
    o_rate=495 / (1.0324 - 0.19077 * log((double.parse(user_weist)-double.parse(user_neck))) + 0.15456 * log (double.parse(user_height))) - 450;
  return;
  }*/
  Widget build(BuildContext context){
    print("girildi");
   // get_the_other(user_weight,user_height,user_neck,user_weist, bmi_value, o_rate);
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Profil Sayfası"),backgroundColor: Colors.blue,centerTitle: true,
      ),

      body:Container(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:  <Widget>[
            SizedBox(height: 30),
            Container(



              child:Center(

                  child: Text(
                    user_name,
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),



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
                        Text(user_age,style: TextStyle(color: Colors.black,fontSize:28.0)),
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
                        Text(user_gender,style: TextStyle(color: Colors.black,fontSize:28.0)),
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
                        Text(user_height,style: TextStyle(color: Colors.black,fontSize:28.0)),
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
                        Text(user_weight,style: TextStyle(color: Colors.black,fontSize:28.0)),
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

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: <Widget>[

                           Text("Aktivite Durumu",style: TextStyle(color: Colors.black)),
                           Text(user_activity,style: TextStyle(color: Colors.black,fontSize:28.0)),
                         ],
                       ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[

                            Text("Kullandığı ilaçlar",style: TextStyle(color: Colors.black)),
                            Text(user_pills,style: TextStyle(color: Colors.black,fontSize:28.0)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[

                            Text("Dışkılama problemi",style: TextStyle(color: Colors.black)),
                            Text(user_defecation,style: TextStyle(color: Colors.black,fontSize:28.0)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[

                            Text("Alerji Durumu",style: TextStyle(color: Colors.black)),
                            Text(user_allergy,style: TextStyle(color: Colors.black,fontSize:28.0)),
                          ],
                        ),

                      ],
                    ),
                  ),
                  Expanded( // <-- SEE HERE
                    child: SizedBox.shrink(),
                    flex: 3,
                  ),

                  Expanded( // <-- SEE HERE
                    child: SizedBox.shrink(),
                    flex: 1,






            ),
          ],




        ),
      ),
    );
  }
}

class customers_page extends StatefulWidget {

  final String user_name;
  final String user_id;
  customers_page({required this.user_name,required this.user_id});

  @override
  _customers_state2 createState() => _customers_state2();
}




class _customers_state2 extends State<customers_page> {
  late String username;
  late String userid;
  void initState() {
    super.initState();

    username=widget.user_name;
    userid=widget.user_id;
    // bmi_value=double.parse(user_info_list['weight']!)/((double.parse(user_info_list['height']!)/100)*(double.parse(user_info_list['height']!)/100));
    //print('${user_info_list["weight"].toString()}');
  }
  final ScrollController _controller = ScrollController();
  final List<String> name_list = [];

  final List<String> age_list = [];
  final List<String> email_list=[];
  final List<String> gender_list = [];
  final List<String> height_list = [];
  final List<String> weight_list = [];
  final List<String> allergy_list = [];
  final List<String> defecation_list = [];
  final List<String> pills_list = [];
  final List<String> activity_list = [];
  final List<String> neck_list = [];
  final List<String> hip_list = [];
  final List<String> weist_list = [];
  final List<String> id_list = [];
  Future<String> asicron_method( List<String> name_list ,
   List<String> age_list ,
   List<String> email_list,
   List<String> gender_list ,
   List<String> height_list ,
   List<String> weight_list ,
  List<String> allergy_list ,
   List<String> defecation_list ,
   List<String> pills_list ,
   List<String> activity_list ,
   List<String> neck_list ,
   List<String> hip_list ,
   List<String> weist_list ,) async{

    var sth;
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {

        if(doc['type']=='type1' && doc['dietician']==username){

          name_list.add(doc["userName"]);
          age_list.add(doc["age"]);
          id_list.add(doc.id);

          email_list.add(doc["email"]);
          gender_list.add(doc["gender"]);
          age_list.add(doc["age"]);
          height_list.add(doc["height"]);
          weight_list.add(doc["weight"]);
          allergy_list.add(doc["allergy"]);
          defecation_list.add(doc["defecation"]);
          pills_list.add(doc["pills"]);
          activity_list.add(doc["activity"]);
          neck_list.add(doc["neck"]);
          hip_list.add(doc["hip"]);
          weist_list.add(doc["weist"]);
        }

      });
    });





    return name_list[0];

  }

  String myimage="empty";
  Future<String> get_image(String dieticianid)async{
    var myurl;
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {

        if(doc['type']=='type1' && doc['email']==dieticianid){


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
  Widget build(BuildContext context) {
    name_list.clear();
    age_list.clear() ;
    email_list.clear();
    gender_list.clear() ;
    height_list.clear() ;
    weight_list.clear() ;
    allergy_list.clear() ;
    defecation_list.clear() ;
    pills_list.clear() ;
    activity_list.clear();
    neck_list.clear();
    hip_list.clear();
    weist_list.clear() ;
    return FutureBuilder(
        future: asicron_method( name_list ,
          age_list ,
          email_list,
          gender_list ,
          height_list ,
          weight_list ,
          allergy_list ,
          defecation_list ,
          pills_list ,
          activity_list ,
          neck_list ,
          hip_list ,
          weist_list ,),
        builder: (BuildContext context, AsyncSnapshot snap)
        {
          if(snap.data==null){
            return Scaffold(appBar: AppBar(
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
            ),body:Center(
              child: Text("you have not any customer"),),);
          }
          else{
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
              body: SingleChildScrollView(


                child:Container(

                 child: Column(
                    children: <Widget>[




                 for(var index=0;index<name_list.length;index++)
                       Container(
                        padding: EdgeInsets.only(
                            left: 14, right: 14, top: 10, bottom: 10),
                        child: Align(
                          alignment: (Alignment.center),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: (Colors.grey[200]),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Column(
                                      children:[
                                        FutureBuilder(future:get_image(email_list[index]),
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
                                                      radius: 40,
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
                                                      radius: 40,
                                                      backgroundImage:NetworkImage(snap.data.toString()),


                                                    )
                                                );
                                              }
                                            }

                                        ),
                                      ],
                                    ),

                                    Text(name_list[index],style:TextStyle(fontSize: 15, color: Colors.black),),
                                    IconButton(
                                      icon: const Icon(Icons.message),

                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .collection("users")
                                            .doc(userid)
                                            .update({
                                          'current':username+ email_list[index],
                                        });
                                       // Timer(Duration(seconds: 1),(){
                                          Navigator.of(context).pop();
                                       // });

                                      },
                                    ),
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    IconButton(
                                      icon: const Icon(Icons.add_box_outlined),

                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (
                                            context) => customers_setlist(

                                          user_id: id_list[index].toString(),


                                        )),);
                                      },
                                    ),

                                    IconButton(
                                      icon: const Icon(Icons.file_copy_rounded),

                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (
                                            context) => customers_listpage(

                                          user_name: email_list[index].toString(),


                                        )),);
                                      },
                                    ),
                                    Expanded(
                                    child:TextButton(
                                      onPressed: (){
                                        print(index);
                                        Navigator.push(context, MaterialPageRoute(builder: (
                                            context) => customers_info_page(

                                          user_name: name_list[index].toString(),
                                          user_gender: gender_list[index].toString() ,
                                          user_height:height_list[index].toString(),
                                          user_weight:weight_list[index].toString(),
                                          user_age: age_list[index].toString(),

                                          user_pills: pills_list[index].toString(),
                                          user_allergy: allergy_list[index].toString(),
                                          user_activity: activity_list[index].toString(),
                                          user_defecation: defecation_list[index].toString(),
                                          user_hip: hip_list[index].toString(),
                                          user_weist: weist_list[index].toString(),
                                          user_neck: neck_list[index].toString(),

                                        )),);

                                        setState(() {

                                        });
                                        print(index);
                                      },
                                      child: Text(
                                        'Daha Fazla Bilgi',
                                        style: TextStyle(color: Colors.blue, fontSize: 10),
                                      ),
                                    ),
                                    ),
                                  ],
                                ),



                              ],
                            ),
                          ),
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