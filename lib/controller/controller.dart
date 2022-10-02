import 'dart:developer';

import 'package:baking_calculation_helper/repository/repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Controller extends GetxController{
  final Repository _repo = Repository();
  
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final doc= firestore.collection('test_collection').doc('test_doc');
  
  Future<void> getList(String address) async {

    doc.get().then(((value) => 
      print(value.data())
    ));

    await _repo.getRecipe(address).then((result) {
      doc.get().then(((value) => 
        print('value.data === ${value.data()}')
      ));
    });
  }
  void setDB(){
    doc.set({
      'filed4' : '4',
      'field5' : '5',
      'field6' : '6',
      'field7' : '7'
    });
  }
  void readDB(){
    doc.get().then((value){
      print(value.data());
    });
  }

  void updateDB(String key, String value){
    doc.update({
      key:value
    });
  }
}