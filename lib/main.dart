
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutdeneme2/pages/home_page.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutdeneme2/pages/register_page.dart';
import 'package:flutdeneme2/pages/forgot_passpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutdeneme2/pages/auth.dart';
import 'package:flutdeneme2/pages/dietician_homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home:MyApp()));
}




class MyApp extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<MyApp> {

  var isDisable=true;
  var isDisable2=false;
  void setButton(){
    if(isDisable){
      isDisable = false;
      isDisable2=true;
    }

  }
  void setButton2(){
    if(isDisable2){
      isDisable2 = false;
      isDisable=true;
    }

  }

  int current_index=2;
  int user_type=0;
  int current_index2=1;
  var user_type_str;
  var user_id_value;
  final my_controller = TextEditingController();
  final my_controller2= TextEditingController();
  AuthService _authService = AuthService();

  void _onPressed(String valueid)async{
    current_index2=0;
    Navigator.push(context,MaterialPageRoute(builder: (context)=> Home_page_dietician(
      user_name: my_controller.text,
      user_password: my_controller2.text,
      user_id:valueid,
      current_index:current_index2,
    ))).then((_) {
      // This block runs when you have returned back to the 1st Page from 2nd.
      setState(() {
        _onPressed(valueid);
      });
    });
  }
  void _onPressed2(String valueid)async{
    current_index=3;
    Navigator.push(context,MaterialPageRoute(builder: (context)=> Home_page(
      user_name: my_controller.text,
      user_password: my_controller2.text,
      user_id:valueid,
      index_value: current_index,
    ))).then((_) {
      // This block runs when you have returned back to the 1st Page from 2nd.
      setState(() {
        _onPressed2(valueid);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView ( child: Container(
        height: 900,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/login_back.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(

          children: <Widget>[
            SizedBox(height: 210),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Container(
                  height: 30,
                  width: 100,
                  decoration: BoxDecoration(
                      color: isDisable ? Colors.red: Colors.grey ,borderRadius: BorderRadius.circular(10)),
                 child: TextButton(

                  onPressed: (){
                    setState((){
                      setButton();
                    });
                    user_type=1;
                  },
                  child: Text(
                    'customer',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                ),
                  SizedBox(width: 30),
               Container(
                 height: 30,
                 width: 100,
                 decoration: BoxDecoration(
                     color:   isDisable2 ? Colors.orange: Colors.grey, borderRadius: BorderRadius.circular(10)) ,
                child: TextButton(

                  onPressed: (){
                    setState((){
                      setButton2();
                    });
                    user_type=0;
                  },
                  child: Text(
                    'nutritionist',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
               ),
               ]
              ),

            ),
            SizedBox(height: 20),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    fillColor: Color(0xffD9D9D9),
                    filled: true,
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
                controller:my_controller,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(

                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    fillColor: Color(0xffD9D9D9),
                    filled: true,
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
                controller: my_controller2,
              ),
            ),
            TextButton(
              onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=> forgetpass(

                )),);
              },
              child: Text(
                'Forgot Password',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Color(0xff196A2B), borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: ()async{
                  if(user_type==1){
                    print("yes thats true");
                    _authService.signIn(
                        my_controller.text, my_controller2.text)   .catchError((err) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Hata"),
                              content: Text(err.message),
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
                    });
                    await _authService.signIn(
                        my_controller.text, my_controller2.text)
                        .then((value) {
                      user_id_value=value!.uid;
                    });
                    await FirebaseFirestore.instance.collection('users').doc(user_id_value).get()
                        .then((value) {
                      user_type_str = value.data()!['type'];
                    });
                    Timer(Duration(seconds: 1), () {
                      if(user_type_str=="type1"){
                        _authService.signIn(
                            my_controller.text, my_controller2.text)
                            .then((value) {
                          return Navigator.push(context,MaterialPageRoute(builder: (context)=> Home_page(
                            user_name: my_controller.text,
                            user_password: my_controller2.text,
                            user_id:value!.uid,
                            index_value: current_index,
                          ))).then((_) {
                            // This block runs when you have returned back to the 1st Page from 2nd.
                            setState(() {
                              _onPressed2(value!.uid);
                            });
                          });
                          print('${value!.uid}');
                        }
                        );
                      }
                      else{
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Hatalı kullanıcı tipi"),
                                content: Text("Birdaha deneyin"),
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
                    });



                  }
                  else{
                    print("yes thats true");
                    _authService.signIn(
                        my_controller.text, my_controller2.text)   .catchError((err) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Hata"),
                              content: Text(err.message),
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
                    });
                    await _authService.signIn(
                        my_controller.text, my_controller2.text)
                        .then((value) {
                      user_id_value=value!.uid;
                    });
                    await FirebaseFirestore.instance.collection('users').doc(user_id_value).get()
                        .then((value) {
                      user_type_str = value.data()!['type'];
                    });
                    Timer(Duration(seconds: 1), () {
                      if(user_type_str=="type2"){
                        _authService.signIn(
                            my_controller.text, my_controller2.text)
                            .then((value) {
                          return Navigator.push(context,MaterialPageRoute(builder: (context)=> Home_page_dietician(
                            user_name: my_controller.text,
                            user_password: my_controller2.text,
                            user_id:value!.uid,
                            current_index: current_index2,

                          ))).then((_) {
                            // This block runs when you have returned back to the 1st Page from 2nd.
                            setState(() {
                             _onPressed(value!.uid);
                            });
                          });
                          print('${value!.uid}');
                        }
                        );
                      }
                      else{
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Hatalı kullanıcı tipi"),
                                content: Text("Birdaha deneyin"),
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
                    });

                  }
                },
                child: Text(
                  'Giriş',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Color(0xff196A2B), borderRadius: BorderRadius.circular(20)),
            child: TextButton(
              onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>register_page(user_type: user_type,)),);
              },
                child:Text('Kayıt Ol',style: TextStyle(color: Colors.white, fontSize: 25),)),
            ),
          ],
        ),
      ),
      ),
    );

  }

}

