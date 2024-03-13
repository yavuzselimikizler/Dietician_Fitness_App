import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var my_data = "";

  //giriş yap fonksiyonu
  Future<User?> signIn(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    //print('${user.user}');
    return user.user;
  }

  //çıkış yap fonksiyonu
  signOut() async {
    return await _auth.signOut();
  }

  //kayıt ol fonksiyonu
  Future<User?> createPerson(String email, String name, String password,
      String number, String city,
      String height, String weight, String age, String gender, String pills,
      String allergy, String activity, String defecation,
      String weist, String neck, String hip,String type,String dietician,String breakfast,String snack1,String lunch,String snack2,String dinner,String image) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    await _firestore
        .collection("users")
        .doc(user.user!.uid)
        .set({
      'userName': name,
      'email': email,
      'number': number,
      'number': number,
      'city': city,
      'height': height,
      'weight': weight,
      'age': age,
      'gender': gender,
      'pills': pills,
      'allergy': allergy,
      'activity': activity,
      'defecation': defecation,
      'weist': weist,
      'neck': neck,
      'hip': hip,
      'type':type,
      'dietician':dietician,
      'kahvaltı':breakfast,
      'ara öğün 1':snack1,
      'öğle yemeği':lunch,
      'ara öğün 2':snack2,
      'akşam yemeği':dinner,
      'image':image
    });

    return user.user;
  }

  Future<User?> createPerson2(String email, String name, String password,
      String number, String city,
       String age, String gender,
      String expertise, String education,
      String type,String empty,String image) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    await _firestore
        .collection("users")
        .doc(user.user!.uid)
        .set({
      'userName': name,
      'email': email,
      'number': number,

      'city': city,
      'expertise':expertise,
      'education':education,

      'age': age,
      'gender': gender,

      'type':type,
      'current':empty,
      'image':image
    });

    return user.user;
  }
}

