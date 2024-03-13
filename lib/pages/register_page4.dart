import 'package:flutdeneme2/pages/main.dart';
import 'package:flutter/material.dart';
import 'package:flutdeneme2/pages/main.dart';
import 'package:flutdeneme2/pages/auth.dart';
class register_page4 extends StatefulWidget {

  final String user_name;
  final String user_password;
  final String user_number;
  final String user_city;
  final String user_email;
  final String user_height;
  final String user_weight;
  final String user_age;
  final String user_gender;
  final String user_pills;
  final String user_allergy;
  final String user_activity;
  final String user_defecation;
  register_page4({required this.user_name,required this.user_password,required this.user_email,required this.user_city,required this.user_number,
    required this.user_height,required this.user_weight,required this.user_age,required this.user_gender,required this.user_pills,
    required this.user_allergy,required this.user_activity,required this.user_defecation
  });
  @override
  reg_clas4 createState() => reg_clas4();
}

class reg_clas4 extends State<register_page4> {

  late String user_name;
  late String user_password;
  late String user_number;
  late String user_city;
  late String user_email;
  late String user_height;
  late String user_weight;
  late String user_age;
  late String user_gender;
  late String user_pills;
  late String user_allergy;
  late String user_activity;
  late String user_defecation;
  void initState() {
    super.initState();
    user_name=widget.user_name;
    user_password=widget.user_password;
    user_city=widget.user_city;

    user_email=widget.user_email;
    user_number=widget.user_number;
    user_height=widget.user_height;
    user_weight=widget.user_weight;
    user_age=widget.user_age;

    user_gender=widget.user_gender;
    user_pills=widget.user_pills;
    user_allergy=widget.user_allergy;

    user_activity=widget.user_activity;
    user_defecation=widget.user_defecation;

  }
  final my_controller = TextEditingController();
  final my_controller2 = TextEditingController();
  final my_controller3 = TextEditingController();
  AuthService _authService = AuthService();
  Widget build(BuildContext context) {

    return Scaffold(

      body: SingleChildScrollView(
        child:Container(
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
                        hintText: 'Bel Çevresi (cm)'),
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
                        hintText: 'Boyun Çevresi (cm)'),
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
                        hintText: 'Kalça çevresi (cm) '),
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


                child: Container(
                  width: 208,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color(0xff196A2B), borderRadius: BorderRadius.circular(20)),
                  child:TextButton(
                    onPressed: (){
                      _authService
                          .createPerson(
                          user_email,
                          user_name,
                          user_password,
                          user_number,
                        user_city,
                        user_height,
                        user_weight,
                        user_age,
                        user_gender,
                        user_pills,
                        user_allergy,
                        user_activity,
                        user_defecation,
                        my_controller.text,
                        my_controller2.text,
                        my_controller3.text,
                        "type1",
                        "empty",
                        "empty",
                        "empty",
                        "empty",
                        "empty",
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