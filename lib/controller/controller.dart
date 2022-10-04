// import 'package:baking_calculation_helper/repository/repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Controller extends GetxController{
  // final Repository _repo = Repository();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final userDoc= firestore.collection('Home').doc('User');
  
  void checkUser(){}

  void addUser(String userEmail)async{
    await userDoc.collection(userEmail).doc(userEmail).set({"userEmail":userEmail});
  }


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