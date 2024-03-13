import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class MessageService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var my_data = "";

  //giriş yap fonksiyonu


  //çıkış yap fonksiyonu


  //kayıt ol fonksiyonu
  Future<String?> createdialoge(String first,String second) async {

 String full_name=first+second;
    await _firestore
        .collection("messages")
        .doc(full_name)
        .set({
        'başlangıç':'dialog başlatıldı',
    });

    return full_name;
  }


}

