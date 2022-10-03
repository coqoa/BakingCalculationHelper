// import 'package:baking_calculation_helper/repository/repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Controller extends GetxController{
  // final Repository _repo = Repository();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final testdoc= firestore.collection('test').doc('testd');
  
  Future<void> getList() async {

    testdoc.get().then(((value) => 
      print(value.data())
    ));
  }
  void setDB(){
    testdoc.set({
      'filed4' : '4',
      'field5' : '5',
      'field6' : '6',
      'field7' : '7'
    });
  }
  void readDB(){
    testdoc.get().then((value){
      print(value.data());
    });
  }

  void updateDB(String key, String value){
    testdoc.update({
      key:value
    });
  }
}