import 'package:flutter/material.dart';
import 'package:flutdeneme2/pages/register_page3.dart';
class register_page2 extends StatefulWidget {
  final String user_name;
  final String user_password;
  final String user_number;
  final String user_city;
  final String user_email;


  register_page2({required this.user_name,required this.user_password,required this.user_email,required this.user_city,required this.user_number});
  @override
  reg_clas2 createState() => reg_clas2();

}

class reg_clas2 extends State<register_page2> {
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
  final my_controller5 = TextEditingController();
  Widget build(BuildContext context) {

    return Scaffold(

      body:SingleChildScrollView(
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
                        hintText: 'Boy'),
                    controller: my_controller,
                  ),
                ),
              ),

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
                        hintText: 'Kilo'),
                    controller: my_controller2,
                  ),
                ),
              ),

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
                        hintText: 'Yaş'),
                    controller: my_controller3,
                  ),
                ),
              ),

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
                        hintText: 'Cinsiyet'),
                    controller: my_controller4,
                  ),
                ),
              ),

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
                        hintText: 'Kullandığı İlaçlar'),
                    controller: my_controller5,
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
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>register_page3(
                        user_email:user_email ,
                        user_password: user_password,
                        user_name: user_name,
                        user_city: user_city,
                        user_number: user_number,
                        user_height:my_controller.text ,
                        user_weight: my_controller2.text,
                        user_age: my_controller3.text,
                        user_gender: my_controller4.text,
                        user_pills: my_controller5.text,
                      )),);
                    },
                    child: Text(
                      'Sonraki Sayfa',
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