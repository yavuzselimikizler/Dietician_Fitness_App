import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class diet_page extends StatefulWidget {
  final String user_id;

  diet_page({required this.user_id});
  @override
  diet_clas createState() => diet_clas();
}

class diet_clas extends State<diet_page> {

  late String userid;

  void initState() {
    super.initState();

    userid=widget.user_id;

  }
  List<List<String>> diet_list= [[]];
  List<List<List<String>>> all_list= [[[]]];
  String snack1="";
  String snack2="";
  String breakfast="";
  String lunch="";
  String dinner="";
 void add_list(String sub_list){
   List<String> parts = sub_list.split('*');


   diet_list.add(parts);


 }
 List<String> mealtimelist=["kahvaltı","ara öğün 1","öğle yemeği","ara öğün 2","akşam yemeği",];
  void fill_list(){

    List<String> parts = breakfast.split('*');


    diet_list.add(parts);
    List<String> parts2 = snack1.split('*');


    diet_list.add(parts2);
    List<String> parts3 = lunch.split('*');


    diet_list.add(parts3);

    List<String> parts4 = snack2.split('*');


    diet_list.add(parts4);

    List<String> parts5 = dinner.split('*');


    diet_list.add(parts5);





  }
  Future <String> get_item() async{

   return diet_list[0][0];
  }
  List<int> index_list=[];
  void openindex(List<int> index){
    index_list==index;
  }
  Future<void> upload_list( List<List<String>> my_list)async {

     breakfast="";
     snack1="";
     snack2="";
    lunch="";
     dinner="";
     for(int i=0 ;i<my_list[0].length;i++){
       breakfast= breakfast+my_list[0][i] + '*';
     }
     if (breakfast != null && breakfast.length > 0) {
       breakfast = breakfast.substring(0, breakfast.length - 1);
     }
     for(int i=0 ;i<my_list[1].length;i++){
       snack1= snack1+my_list[1][i] + '*';
     }
     if (snack1 != null && snack1.length > 0) {
       snack1 = snack1.substring(0, snack1.length - 1);
     }
     for(int i=0 ;i<my_list[2].length;i++){
       lunch= lunch+my_list[2][i] + '*';
     }
     if (lunch != null && lunch.length > 0) {
       lunch = lunch.substring(0, lunch.length - 1);
     }
     for(int i=0 ;i<my_list[3].length;i++){
       snack2= snack2+my_list[3][i] + '*';
     }
     if (snack2 != null && snack2.length > 0) {
       snack2 = snack2.substring(0, snack2.length - 1);
     }
     for(int i=0 ;i<my_list[4].length;i++){
       dinner= dinner+my_list[4][i] + '*';
     }
     if (dinner != null && dinner.length > 0) {
       dinner = dinner.substring(0, dinner.length - 1);
     }

    FirebaseFirestore.instance.collection('users').doc(userid)
          .update({

        'kahvaltı':breakfast,
        'öğle yemeği':lunch,
        'akşam yemeği': dinner,
         'ara öğün 1':snack1,
         'ara öğün 2':snack2
      })
          .then((value) => print("User Updated"))
          .catchError((error) => print("Failed to update user: $error"));

     Timer(Duration( seconds: 1),(){
       setState(() {

       });
     });
  }
  void add_list2(List<List<String>> mylist2){
   // print(mylist2[0]);

    List<String> temp2=  List.generate(mylist2[0].length, (index) => ",");
    List<List<String>> temp3=List.generate(mylist2.length, (index) => temp2);

   for(int j=0;j<mylist2.length;j++){

     for(int k=0;k<mylist2[j].length;k++){

       temp3[j][k]=mylist2[j][k];
     }

   }
print(temp3);
all_list.add(temp3);

  }
  Future <void> remove_list() async{
    FirebaseFirestore.instance.collection('users').doc(userid)
        .update({

      'kahvaltı':'empty',
      'öğle yemeği':'empty',
      'akşam yemeği': 'empty',
      'ara öğün 1':'empty',
      'ara öğün 2':'empty'
    })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
    Timer(Duration( seconds: 1),(){
      setState(() {

      });
    });

  }
  List<bool> isopen=[];

  final List<String> breakfast_list = [];
  final List<String> snack1_list=[];
  final List<String> lunch_list = [];
  final List<String> snack2_list = [];
  final List<String> dinner_list = [];
  Future<void> change_list(int counter_index) async{
    int counter=0;
    breakfast_list.clear();
    snack1_list.clear();
     lunch_list.clear();
     snack2_list.clear();
    dinner_list.clear();

    String user_id="";
 print(counter_index);
    await FirebaseFirestore.instance
        .collection('lists')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {



          snack1_list.add(doc['ara öğün 1']);
          snack2_list.add(doc['ara öğün 2']);
          breakfast_list.add(doc['kahvaltı']);
          lunch_list.add( doc['öğle yemeği']);
          dinner_list.add(doc['akşam yemeği']);



      });
    });
    print(dinner_list[counter_index]);
    FirebaseFirestore.instance.collection('users').doc(userid)
        .update({

      'kahvaltı':breakfast_list[counter_index],
      'öğle yemeği':lunch_list[counter_index],
      'akşam yemeği': dinner_list[counter_index],
      'ara öğün 1':snack1_list[counter_index],
      'ara öğün 2':snack2_list[counter_index]
    })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));

    Timer(Duration( seconds: 1),(){
      setState(() {

      });
    });

  }
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
int _selectedIndex = 0;
  Widget build(BuildContext context) {
    isopen.clear();

    return FutureBuilder(future:empty_list(),
        builder : (BuildContext context, AsyncSnapshot snap){
      if(snap.data==null){
        return Center(
          child: CircularProgressIndicator(),);
      }
      else if(snap.data==true){
        return StreamBuilder(
          stream: FirebaseFirestore.instance
            .collection('lists')


            .snapshots(),
          builder: (context, snapshot){
         if(!snapshot.hasData){
           return Center(

             child: CircularProgressIndicator(),);
         }
         else{
           int? number=snapshot.data?.docs.length;
           all_list.clear();


         for(int index=0;index<number!;index ++){

           //print(diet_list);
           //select the image url
         //  if(index>=all_list.length) {
          // add_list2(diet_list);
         /*  List<List<String>> temp=List.from(diet_list);
           print(temp);
all_list.add(temp);*/


        //   }
         }
        // print(all_list);
        // print(all_list.length);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar:AppBar(title: Text("Diyet Sayfası"),backgroundColor: Colors.green,centerTitle: true,),
            body: Stack(





         children: [

          ListView.builder(

            itemCount: snapshot.data?.docs.length,
                shrinkWrap: true,

                reverse: false,

                padding: EdgeInsets.only(top: 10, bottom: 10),
                physics: AlwaysScrollableScrollPhysics(),

                itemBuilder: (context, index) {
                  //get image url from firebase storage
                  for (var i =0;i<diet_list.length;i++){
                    diet_list[i].clear();
                  }
                  diet_list.clear();

                  add_list(snapshot.data?.docs[index].data()["kahvaltı"]);
                  add_list(snapshot.data?.docs[index].data()["ara öğün 1"]);
                  add_list(snapshot.data?.docs[index].data()["öğle yemeği"]);
                  add_list(snapshot.data?.docs[index].data()["ara öğün 2"]);
                  add_list(snapshot.data?.docs[index].data()["akşam yemeği"]);

                  isopen.add(false);
                  for(int i=0;i<index_list.length;i++){
                    if(index==index_list[i]){
                      isopen[index]=true;
                    }
                  }

                  return Container(
                    padding: EdgeInsets.only(
                        left: 14, right: 14, top: 10, bottom: 10),
                    child: Align(
                      alignment: (Alignment.center),
                      child: Container(

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: (Colors.grey[200]),
                        ),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                  children: <Widget>[

                                    Text("liste ${index + 1} "),
                                    IconButton(onPressed: () {
                                      print(index);
                                      change_list(index);
                                    }, icon: const Icon(Icons.add),),

                                    IconButton(onPressed: () {
                                      if (!index_list.contains(index)) {
                                        index_list.add(index);
                                      }
                                      else {
                                        index_list.remove(index);
                                      }

                                      setState(() {
                                        openindex(index_list);
                                      });
                                    },
                                      icon: !isopen[index]
                                          ? const Icon(
                                          Icons.arrow_downward_sharp)
                                          : const Icon(
                                          Icons.arrow_upward_sharp),)
                                  ],

                                ),
                              ],
                            ),
                            if (isopen[index]) for(var index2 = 0; index2 <
                                5; index2++)Container
                              (


                              child: Column(
                                children: [


                                  Container
                                    (
                                    child: Stack(
                                      children: <Widget>[
                                        Text(mealtimelist[index2] + " :"),
                                        ListView.builder(
                                            itemCount: diet_list[index2]
                                                .length,
                                            shrinkWrap: true,

                                            reverse: false,
                                            physics: ScrollPhysics(),
                                            padding: EdgeInsets.only(
                                                top: 10, bottom: 10),


                                            itemBuilder: (context, index3) {
                                              return Container(
                                                padding: EdgeInsets.only(
                                                    left: 14,
                                                    right: 14,
                                                    top: 10,
                                                    bottom: 10),
                                                child: Text(
                                                  diet_list[index2][index3],
                                                  style: TextStyle(
                                                      fontSize: 16),),
                                              );
                                            }
                                        ),
                                      ],

                                    ),
                                  ),

                                ],
                              ),


                            )
                            else
                              Container
                                (


                                child: Column(
                                  children: [


                                    Container
                                      (
                                      child: Stack(
                                        children: <Widget>[
                                          Text(mealtimelist[0] + " :"),
                                          ListView.builder(
                                              itemCount: diet_list[0].length,
                                              shrinkWrap: true,

                                              reverse: false,
                                              physics: ScrollPhysics(),
                                              padding: EdgeInsets.only(
                                                  top: 10, bottom: 10),


                                              itemBuilder: (context, index3) {
                                                return Container(
                                                  padding: EdgeInsets.only(
                                                      left: 14,
                                                      right: 14,
                                                      top: 10,
                                                      bottom: 10),
                                                  child: Text(
                                                    diet_list[0][index3],
                                                    style: TextStyle(
                                                        fontSize: 16),),
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
                    ),
                  );

                }
        ),







],
                ),



            );


         }

        },


        );


      }
      else{
        for (var i =0;i<diet_list.length;i++){
          diet_list[i].clear();
        }
        diet_list.clear();
        fill_list();
         return Scaffold(
          appBar: AppBar(title: Text("Diyet Sayfası"),backgroundColor: Colors.green,centerTitle: true,flexibleSpace: SafeArea(
            child:Align(
              alignment: Alignment.centerRight,
              child:IconButton(
                icon: const Icon(Icons.remove,color: Colors.red,),

                onPressed: ()  {

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
                              onPressed: ()  {
                                remove_list();
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      });
                },
              ),
            ),
          ),),
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
          child: Text(diet_list[index2][index3],style: TextStyle(fontSize: 16),),
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



      }

    );

  }

}