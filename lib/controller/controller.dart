// import 'package:baking_calculation_helper/repository/repository.dart';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Controller extends GetxController{
  // final Repository _repo = Repository();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final userDoc= firestore.collection('Home').doc('User');
  
  void setUserInit(String userEmail){
    log('serUserInit');
    firestore.collection(userEmail).doc(userEmail).set({
      "initData":"initData"
    });
  }
  void getUser(String userEmail, String doc){
    log('getUser');
    firestore.collection(userEmail).doc(doc).set({
      "test1":"test1",
      "test2":"test2"
    });
  }

  void addUser(String userEmail)async{
    await userDoc.collection(userEmail).doc(userEmail).set({"userEmail":userEmail});
  }
  // void getUser(String userEmail)async{
  //   DocumentSnapshot test1 = await firestore.collection('Home').doc('User').collection(userEmail).doc(userEmail).get();
  //   if(test1['userEmail']==userEmail){
  //     print('Success');
  //   }else{
  //     print('error');
  //   }
  //   // print(test1['userEmail']); // 데이터 출력 성공
    
  // }


  //  ---
  Future<void> getList() async {

    userDoc.get().then(((value) => 
      print(value.data())
    ));
  }
  void setDB(){
    userDoc.set({
      'filed4' : '4',
      'field5' : '5',
      'field6' : '6',
      'field7' : '7'
    });
  }
  void readDB(){
    userDoc.get().then((value){
      print(value.data());
    });
  }

  void updateDB(String key, String value){
    userDoc.update({
      key:value
    });
  }
}