import 'package:dio/dio.dart';
import 'package:baking_calculation_helper/repository/repository_ab.dart';

class Repository implements RepositoryAB{
  // 파이어베이스 데이터 받아오기
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  // late final doc= firestore.collection('test_collection').doc('test_doc');

  @override
  Future<Map<String, dynamic>> getRecipe(String address) async {
    var response = await Dio().get('');

    Map<String, dynamic> result = response.data;
    return result;
  }
}
