import 'package:flutter/material.dart';
import 'package:flutdeneme2/pages/register_page2.dart';
import 'package:flutdeneme2/pages/register_dietician.dart';
class register_page extends StatefulWidget {

   late int user_type;


  register_page({required this.user_type});
  @override
  reg_clas createState() => reg_clas();
}

class reg_clas extends State<register_page> {
  final my_controller = TextEditingController();
  final my_controller2 = TextEditingController();
  final my_controller3 = TextEditingController();
  final my_controller4 = TextEditingController();
  final my_controller5 = TextEditingController();
  late int user_type;
  void initState() {
    super.initState();
    user_type=widget.user_type;

  }
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


              child: SizedBox(
                width: 208,
                height: 50,
                child: TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,

                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Color(0xffD9D9D9),
                      hintText: 'Şifre'),
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
                      hintText: 'İsim-Soyisim'),
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
                      hintText: 'Telefon Numarası'),
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
                      hintText: 'Şehir'),
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
                    if(user_type==1) {
                      print('${user_type}');
                      Navigator.push(context, MaterialPageRoute(builder: (
                          context) => register_page2(
                        user_email:my_controller.text ,
                        user_password: my_controller2.text,
                        user_name: my_controller3.text,
                        user_city: my_controller5.text,
                        user_number: my_controller4.text,
                      )),);
                    }
                    else{
                      Navigator.push(context, MaterialPageRoute(builder: (
                          context) => register_dietician(
                        user_email:my_controller.text ,
                        user_password: my_controller2.text,
                        user_name: my_controller3.text,
                        user_city: my_controller5.text,
                        user_number: my_controller4.text,)),);
                    }
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