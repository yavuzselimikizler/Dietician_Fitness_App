import 'package:flutter/material.dart';
import 'package:flutdeneme2/pages/home_2.dart';
import 'package:flutdeneme2/pages/user_profile.dart';
import 'package:flutdeneme2/pages/home_2.dart';
import 'package:flutdeneme2/pages/fitness.dart';
import 'package:flutdeneme2/pages/diet_page.dart';
import 'package:flutdeneme2/pages/chat_page.dart';
class Home_page extends StatefulWidget {

  final String user_name;
  final String user_password;
  final String user_id;
  final int index_value;
  Home_page({required this.user_name,required this.user_password,required this.user_id,required this.index_value});


  @override
  _home_state createState() => _home_state();
}

class _home_state extends State<Home_page> {


  late String newname;
  late String newpassword;
  late String userid;
  late int index_value;
void initState() {
   super.initState();
   newname=widget.user_name;
   newpassword=widget.user_password;
   userid=widget.user_id;
   index_value=widget.index_value;
  }


  int current_index=0;




  
  Widget build(BuildContext context) {
    final screens =[
      chat_center(user_name:newname ,user_password: newpassword,user_id: userid),
      fitness_center(user_name:newname ,user_password: newpassword),
      Home_page2(user_name: newname,user_id: userid,),
      diet_page(user_id: userid),
      User_profile(user_id: userid),




    ];
    return Scaffold(

    body:screens[index_value],
      bottomNavigationBar: BottomNavigationBar(

        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0x747272),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black45,
        iconSize: 40,
        currentIndex: index_value,
        onTap: (index)=> setState(()=> index_value = index),

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.message),label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center_outlined),label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.home),label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.monitor_heart_outlined),label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: ''),


        ],
      ),

    );
  }
}