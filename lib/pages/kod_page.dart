import 'package:flutter/material.dart';

import 'package:flutdeneme2/pages/main.dart';

class forgetpasscode extends StatefulWidget {





  code_clas createState() => code_clas();
}

class code_clas extends State<forgetpasscode> {
  final my_controller = TextEditingController();



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
              Text('Email Adresinize Onay Kodu gönderilmiştir',style: TextStyle(color:Colors.white), textAlign: TextAlign.left),
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
                        hintText: 'Kod'),
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
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>MyApp()),);
                    },
                    child: Text(
                      'Onayla',
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