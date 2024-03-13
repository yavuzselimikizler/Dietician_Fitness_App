import 'package:flutter/material.dart';
import 'package:flutdeneme2/pages/home_2.dart';
import 'package:flutdeneme2/pages/user_profile.dart';
import 'package:flutdeneme2/pages/home_2.dart';
import 'package:flutdeneme2/pages/dietician_page.dart';
import 'package:flutdeneme2/pages/customers_page.dart';
import 'package:flutdeneme2/pages/message_page.dart';
class Home_page_dietician extends StatefulWidget {

  final String user_name;
  final String user_password;
  final String user_id;
  final int current_index;
  Home_page_dietician({required this.user_name,required this.user_password,required this.user_id,required this.current_index});


  @override
  _home_state_dietician createState() => _home_state_dietician();
}

class _home_state_dietician extends State<Home_page_dietician> {


  late String newname;
  late String newpassword;
  late String userid;
  late int current_index;
  void initState() {
    super.initState();
    newname=widget.user_name;
    newpassword=widget.user_password;
    userid=widget.user_id;
    current_index=widget.current_index;
  }


  //int current_index=1;





  Widget build(BuildContext context) {
    final screens =[


      message_page(newname:newname,user_id:userid),
      customers_page(user_name: newname,user_id:userid),
      dietician_page(user_id:userid),




    ];
    return Scaffold(

      body:screens[current_index],
      bottomNavigationBar: BottomNavigationBar(

        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0x747272),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black45,
        iconSize: 40,
        currentIndex: current_index,
        onTap: (index)=> setState(()=> current_index = index),

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.message),label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.people_rounded),label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: ''),



        ],
      ),

    );
  }
}