import 'package:flutter/material.dart';
import 'package:flutdeneme2/pages/register_page4.dart';
import 'package:flutdeneme2/pages/main.dart';
import 'package:flutdeneme2/pages/auth.dart';
class register_dietician extends StatefulWidget {
  final String user_name;
  final String user_password;
  final String user_number;
  final String user_city;
  final String user_email;


  register_dietician({required this.user_name,required this.user_password,required this.user_email,required this.user_city,required this.user_number});
  @override
  reg_diet createState() => reg_diet();
}

class reg_diet extends State<register_dietician> {

  late String user_name;
  late String user_password;
  late String user_number;
  late String user_city;
  late String user_email;
  void initState() {
    super.initState();
    user_name=widget.user_name;
    user_password=widget.user_password;
    user_city=widget.user_city;

    user_email=widget.user_email;
    user_number=widget.user_number;
  }

  final my_controller = TextEditingController();
  final my_controller2 = TextEditingController();
  final my_controller3 = TextEditingController();
  final my_controller4 = TextEditingController();
  AuthService _authService = AuthService();
  Widget build(BuildContext context) {

    return Scaffold(

      body: SingleChildScrollView(child:Container(
         height: 900,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/login_back.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child:Column(

            children: <Widget>[
              SizedBox(height: 270),
              Padding(

                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),


                child: SizedBox(
                  width: 320,
                  height: 50,
                  child: TextField(
                    textAlign: TextAlign.center,


                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Color(0xffD9D9D9),
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        hintText: 'Tecrübe'),
                    maxLines: 5,
                    minLines: 2,
                    controller: my_controller,
                  ),
                ),
              ),

              Padding(

                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),


                child: SizedBox(
                  width: 320,
                  height: 50,
                  child: TextField(
                    textAlign: TextAlign.center,


                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Color(0xffD9D9D9),
                        hintText: 'Eğitim'),
                    maxLines: 5,
                    minLines: 2,
                    controller: my_controller2,
                  ),
                ),
              ),

              Padding(

                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),


                child: SizedBox(
                  width: 320,
                  height: 50,
                  child: TextField(
                    textAlign: TextAlign.center,


                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        filled: true,
                        fillColor: Color(0xffD9D9D9),
                        hintText: 'Yaş'),
                    maxLines: 5,
                    minLines: 2,
                    controller: my_controller3,
                  ),
                ),
              ),
              Padding(

                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),


                child: SizedBox(
                  width: 320,
                  height: 50,
                  child: TextField(
                    textAlign: TextAlign.center,


                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        filled: true,
                        fillColor: Color(0xffD9D9D9),
                        hintText: 'Cinsiyet'),
                    maxLines: 5,
                    minLines: 2,
                    controller: my_controller4,
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
                      _authService
                          .createPerson2(
                        user_email,
                        user_name,
                        user_password,
                        user_number,
                        user_city,

                        my_controller3.text,
                        my_controller4.text,
                        my_controller.text,
                        my_controller2.text,
                        "type2",
                        "empty",
                        "empty",
                      )
                          .then((value) {
                        return Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyApp()));
                      });
                    },
                    child: Text(
                      'Bitir',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ),




            ],
          ),
        ),
        /* add child content here */
      ),),


    );
  }

}