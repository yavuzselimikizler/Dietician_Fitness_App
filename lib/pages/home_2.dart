import 'dart:async';
import 'dart:math';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'main.dart';

class tip_page extends StatefulWidget {

  final String tip_text;
  final String tip_name;
  tip_page({required this.tip_text,required this.tip_name});
  @override
  tip_page_ createState() => tip_page_();
}
class tip_page_ extends State<tip_page>{

  late String tip_text;
  late String tip_name;
  initState(){

    super.initState();
    tip_text=widget.tip_text;
    tip_name=widget.tip_name;
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
        title: Text(tip_name),backgroundColor: Colors.yellow[600],centerTitle: true,
      ),
      body: SingleChildScrollView(
        child:Text(tip_text,style: TextStyle(
            color: Colors.black, fontSize: 18),),
      )




    );
  }
}

class weight_data{
  weight_data(this.weight,this.date);
  final double weight;
  final double date;


}
String readTimestamp(int timestamp) {
  var now = new DateTime.now();

  var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
  var diff = date.difference(now);
  var time = '';

  if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
    time = date.toString();
  } else {
    if (diff.inDays == 1) {
      time = diff.inDays.toString() + 'DAY AGO';
    } else {
      time = diff.inDays.toString() + 'DAYS AGO';
    }
  }

  return time;
}
class Home_page2 extends StatefulWidget {

  final String user_name;
  final String user_id;
Home_page2({required this.user_name,required this.user_id});
  @override
  _home_state2 createState() => _home_state2();
}

class _home_state2 extends State<Home_page2> {

  late String username;
  late String userid;
  initState(){

    super.initState();
    username=widget.user_name;
    userid=widget.user_id;
  }
  List <String> tip_list=["sağlıklı yaşam için 10 beslenme","aralıklı oruç",
   "dukan diyeti",
    "günlük kuruyemiş ihtiyacı",
    "günlük su tüketimi",
    "su diyeti"];
List<weight_data> get_weight_data(){
 final List<weight_data> my_data=[
  // weight_data(71,82),
  // weight_data(72,83),
 ];
 return my_data;
}
  final List<weight_data> weights=[];
TextEditingController weight_controller= TextEditingController();
  Future<void> add_weight(final String weight,final String weight_id)async{
    String dietician_checker="";

    var documentReference = FirebaseFirestore.instance
        .collection('weights')
        .doc(weight_id)
        .collection(weight_id)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    FirebaseFirestore.instance.runTransaction((transaction) async {
      await transaction.set(
        documentReference,
        {

          'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
          'weight': weight,

        },
      );
    });


  }
  String snack1="";
  String snack2="";
  String breakfast="";
  String lunch="";
  String dinner="";
  Future <bool?> empty_list() async {
    bool? empty_list;

    await FirebaseFirestore.instance.collection('users').doc(userid).get()
        .then((value) {
// Get value of field date from document dashboard/totalVisitors
      snack1= value.data()!['ara öğün 1'];
      snack2= value.data()!['ara öğün 2'];
      breakfast =value.data()!['kahvaltı'];
      lunch= value.data()!['öğle yemeği'];
      dinner=value.data()!['akşam yemeği'];
      print(dinner);
    });
    if(snack1 == 'empty' && snack2 == 'empty' && breakfast=='empty' &&
        lunch=='empty' &&
        dinner=='empty'){
      empty_list=true;
    }
    else if(snack1 == '' && snack2 == '' && breakfast=='' &&
        lunch=='' &&
        dinner==''){
      empty_list=null;
    }
    else{
      empty_list=false;
    }


    return empty_list;
  }
bool error_message=false;
  Widget build(BuildContext context) {
   weights.clear();
    return StreamBuilder(
       stream: FirebaseFirestore.instance
            .collection('weights')
            .doc(username+"weight")
            .collection(username+"weight").orderBy('timestamp', descending: false)

            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot){

    if(snapshot.data!=null) {
      snapshot.data?.docs.forEach((doc){
        weight_data temp_weight=weight_data(double.parse(doc['weight']!), double.parse(doc['timestamp']!));
        weights.add(temp_weight);
      });
      return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("tips")


            .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot2){

          if(snapshot2.data!=null){
            Random random = new Random();
            int rand1 = random.nextInt(snapshot2.data?.docs.length);
            int rand2=random.nextInt(snapshot2.data?.docs.length);
            while(rand1==rand2){
              rand2=random.nextInt(snapshot2.data?.docs.length);
            }
            print(rand1);
            print(rand2);
           return Scaffold(
          backgroundColor: Colors.yellow[100],
          appBar: AppBar(title: Text("Ana Sayfa"),
            backgroundColor: Colors.yellow[600],
            centerTitle: true,flexibleSpace: SafeArea(
              child:Align(
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

            child: Column(

              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      left: 14, right: 14, top: 10, bottom: 10),
                  child: Align(
                    alignment: (Alignment.center),
                    child: Container(

                      decoration: BoxDecoration(
                        color:
                         Colors.yellow[200],
                    ),
                    child: Column(
                      children: <Widget>[

                        Center(
                          child: Text(
                            "Ağırlık Değişim grafiğim", style: TextStyle(
                              color: Colors.black, fontSize: 18),
                          ),
                        ),

                        Row(

                          children: [


                            Text("Ağırlık", style: TextStyle(
                                color: Colors.black, fontSize: 18)),


                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: "0.0",
                                    hintStyle: TextStyle(color: Colors.black54),
                                    border: InputBorder.none
                                ),
                                controller: weight_controller,
                              ),
                            ),

                            IconButton(
                              onPressed: () {
                                try {
                                  if (weight_controller.text == null || weight_controller.text=="" ||!(double.parse(weight_controller.text)>0 && double.parse(weight_controller.text)<300)) {
                                    setState(() {
                                      error_message=true;
                                    });
                                  }
                                  else{

                                    add_weight(weight_controller.text,
                                        username + "weight");
                                    Timer(Duration(seconds: 1), () {
                                      setState(() {
                                        error_message=false;
                                      });
                                    });
                                  }

                                } catch (e) {
                                 print(e.toString());
                                }



                              },
                              icon: const Icon(Icons.add_box_outlined),

                            ),


                          ],
                        ),

                       error_message?Text("geçersiz ağırlık değeri",style: TextStyle(color: Colors.red),):SizedBox(height: 8,),




                               SfCartesianChart(series: <ChartSeries>[
                                  LineSeries<weight_data, double>(dataSource: weights,
                                    xValueMapper: (weight_data weig, _) => weig.date,
                                    yValueMapper: (weight_data weig, _) => weig.weight,
                                  )
                                ],),
                                //provide all the things u want to horizontally scroll here






                      ],

                    ),
                  ),
                ),
              ),
    FutureBuilder(future:empty_list(),
    builder : (BuildContext context, AsyncSnapshot snap){
      if(snap.data==null){
        return Center(
          child: CircularProgressIndicator(),);
      }
      else if(snap.data==true){
        return Container(
          padding: EdgeInsets.only(
              left: 14, right: 14, top: 10, bottom: 10),
          child: Align(
            alignment: (Alignment.center),
            child: Container(

              decoration: BoxDecoration(
                color: Colors.grey[400],
              ),
              child: Column(
                children: <Widget>[

                  Center(
                    child: Text("Uyarı! Henüz diyet listesi eklemediniz",
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("Diyet Sayfasına Yönlendir", style: TextStyle(
                          color: Colors.blue, fontSize: 18)),
                      FloatingActionButton(
                        onPressed: () {
                          Timer(Duration(seconds: 1), () {
                            Navigator.of(context).pop();
                          });
                        },
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white, size: 18,),
                        backgroundColor: Colors.red,
                        elevation: 0,
                      ),
                    ],
                  ),


                ],

              ),
            ),
          ),
        );
      }
      else{
        return SizedBox(height: 30,);
      }
    }),

              Text("Sağlıklı Olmak İçin İpuçları",
                style: TextStyle(color: Colors.black, fontSize: 25),),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (
                        context) => tip_page(
                      tip_text: snapshot2.data?.docs[rand1].data()["text"],
                      tip_name: tip_list[rand1],



                    )),);
                  },
                  child: Image.asset("assets/metabloizhızı.jpg"),
                ),
              ),
              Text(tip_list[rand1],
                style: TextStyle(color: Colors.black54, fontSize: 25),),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (
                        context) => tip_page(
                      tip_text: snapshot2.data?.docs[rand2].data()["text"],
                      tip_name: tip_list[rand2],



                    )),);
                  }, child: Image.asset("assets/su_diyeti.jpg"),
                ),
              ),
              Text(tip_list[rand2],
                style: TextStyle(color: Colors.black54, fontSize: 25),),
            ],
          ),

        ),
      );
    }
    else{
     return Center(
       child: CircularProgressIndicator(),);
    }});
    }
    else{
      return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("tips")


              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot2){

            if(snapshot2.data!=null){
              Random random = new Random();
              int rand1 = random.nextInt(snapshot2.data?.docs.length);
              int rand2=random.nextInt(snapshot2.data?.docs.length);
              while(rand1==rand2){
                rand2=random.nextInt(snapshot2.data?.docs.length);
              }
              print(rand1);
              print(rand2);
              return Scaffold(
                backgroundColor: Colors.yellow[100],
                appBar: AppBar(title: Text("Ana Sayfa"),
                  backgroundColor: Colors.yellow[600],
                  centerTitle: true,),
                body: SingleChildScrollView(

                  child: Column(

                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                            left: 14, right: 14, top: 10, bottom: 10),
                        child: Align(
                          alignment: (Alignment.center),
                          child: Container(

                            decoration: BoxDecoration(
                              color:
                              Colors.yellow[200],
                            ),
                            child: Column(
                              children: <Widget>[

                                Center(
                                  child: Text(
                                    "Ağırlık Değişim grafiğim", style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                  ),
                                ),

                                Row(

                                  children: <Widget>[


                                    Text("Ağırlık", style: TextStyle(
                                        color: Colors.black, fontSize: 18)),


                                    Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                            hintText: "0.0",
                                            hintStyle: TextStyle(color: Colors.black54),
                                            border: InputBorder.none
                                        ),
                                        controller: weight_controller,
                                      ),
                                    ),

                                    IconButton(
                                      onPressed: () {
                                        try {
                                          if (weight_controller.text == null || weight_controller.text=="" ||!(double.parse(weight_controller.text)>0 && double.parse(weight_controller.text)<300)) {
                                            setState(() {
                                              error_message=true;
                                            });
                                          }
                                          else{

                                            add_weight(weight_controller.text,
                                                username + "weight");
                                            Timer(Duration(seconds: 1), () {
                                              setState(() {
                                                error_message=false;
                                              });
                                            });
                                          }

                                        } catch (e) {
                                        print(e.toString());
                                        }
                                      },
                                      icon: const Icon(Icons.add_box_outlined),

                                    ),


                                  ],
                                ),
                                error_message?Text("geçersiz ağırlık değeri",style: TextStyle(color: Colors.red),):SizedBox(height: 8,),
                                SfCartesianChart(series: <ChartSeries>[
                                  LineSeries<weight_data, double>(dataSource: weights,
                                    xValueMapper: (weight_data weig, _) => weig.date,
                                    yValueMapper: (weight_data weig, _) => weig.weight,
                                  )
                                ],),


                              ],

                            ),
                          ),
                        ),
                      ),
                      FutureBuilder(future:empty_list(),
                          builder : (BuildContext context, AsyncSnapshot snap){
                            if(snap.data==null){
                              return Center(
                                child: CircularProgressIndicator(),);
                            }
                            else if(snap.data==true){
                              return Container(
                                padding: EdgeInsets.only(
                                    left: 14, right: 14, top: 10, bottom: 10),
                                child: Align(
                                  alignment: (Alignment.center),
                                  child: Container(

                                    decoration: BoxDecoration(
                                      color: Colors.grey[400],
                                    ),
                                    child: Column(
                                      children: <Widget>[

                                        Center(
                                          child: Text("Uyarı! Henüz diyet listesi eklemediniz",
                                            style: TextStyle(color: Colors.red, fontSize: 18),
                                          ),
                                        ),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Text("Diyet Sayfasına Yönlendir", style: TextStyle(
                                                color: Colors.blue, fontSize: 18)),
                                            FloatingActionButton(
                                              onPressed: () {
                                                Timer(Duration(seconds: 1), () {
                                                  Navigator.of(context).pop();
                                                });
                                              },
                                              child: Icon(
                                                Icons.arrow_forward_rounded,
                                                color: Colors.white, size: 18,),
                                              backgroundColor: Colors.red,
                                              elevation: 0,
                                            ),
                                          ],
                                        ),


                                      ],

                                    ),
                                  ),
                                ),
                              );
                            }
                            else{
                              return SizedBox(height: 30,);
                            }
                          }),
                      Text("Sağlıklı Olmak İçin İpuçları",
                        style: TextStyle(color: Colors.black, fontSize: 25),),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (
                                context) => tip_page(
                              tip_text: snapshot2.data?.docs[rand1].data()["text"],
                              tip_name: tip_list[rand1],



                            )),);
                          },
                          child: Image.asset("assets/metabloizhızı.jpg"),
                        ),
                      ),
                      Text(tip_list[rand1],
                        style: TextStyle(color: Colors.black54, fontSize: 25),),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (
                                context) => tip_page(
                              tip_text: snapshot2.data?.docs[rand2].data()["text"],
                              tip_name: tip_list[rand2],



                            )),);
                          }, child: Image.asset("assets/su_diyeti.jpg"),
                        ),
                      ),
                      Text(tip_list[rand2],
                        style: TextStyle(color: Colors.black54, fontSize: 25),),
                    ],
                  ),

                ),
              );
            }
            else{
              return Center(
                child: CircularProgressIndicator(),);
            }});
    }
  }
    );
  }

}