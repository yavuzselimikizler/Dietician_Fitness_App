import 'package:flutter/material.dart';
import 'package:flutdeneme2/pages/auth.dart';
import 'package:flutdeneme2/pages/kod_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutdeneme2/pages/main.dart';
class forgetpass extends StatefulWidget {





  for_clas createState() => for_clas();
}

class for_clas extends State<forgetpass> {



  Future<bool> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      return true;
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(e.toString()),
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
      return false;
    }
  }
  final my_controller = TextEditingController();
  final my_controller2 = TextEditingController();
  final my_controller3 = TextEditingController();


  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/login_back.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child:Column(

            children: <Widget>[
              SizedBox(height: 230),
              Padding(

                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),


                child: SizedBox(
                  width: 208,
                  height: 50,
                  child: TextField(
                    textAlign: TextAlign.center,


                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Color(0xffD9D9D9),
                        hintText: 'E-Mail'),
                    controller: my_controller,
                  ),
                ),
              ),





              Padding(

                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),


                child: Container(
                  width: 208,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color(0xff196A2B), borderRadius: BorderRadius.circular(20)),
                  child:TextButton(
                    onPressed: (){

                      if(my_controller.text!=null){
                        resetPassword(my_controller.text);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyApp()));
                      }
                      else{
                        setState(() {

                        });
                      }
                    },
                    child: Text(
                      'Kod Gönder',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ),







            ],
          ),
        ),
        /* add child content here */
      ),


    );
  }

}