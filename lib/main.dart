import 'package:baking_calculation_helper/controller/controller.dart';
import 'package:baking_calculation_helper/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:baking_calculation_helper/apikey.dart';
import 'package:get/route_manager.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // 추가
  FIREBASE_API_KEYS firebaseOptions = FIREBASE_API_KEYS();

  try{
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: firebaseOptions.apiKey,
        authDomain: firebaseOptions.authDomain,
        projectId: firebaseOptions.projectId,
        storageBucket: firebaseOptions.storageBucket,
        messagingSenderId: firebaseOptions.messagingSenderId,
        appId: firebaseOptions.appId
      ),
    );
  }catch(e){
    print(e);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const BakingCalculationApp(),
      // home: Login(),
    );
  }
}
class BakingCalculationApp extends StatefulWidget {
  const BakingCalculationApp({Key? key}) : super(key: key);

  @override
  State<BakingCalculationApp> createState() => _BakingCalculationAppState();
}

class _BakingCalculationAppState extends State<BakingCalculationApp> {
  Controller firebaseController = Controller();
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  // late final doc1= firestore.collection('test').doc('testd');
  
  
  @override
  void initState() {
    // Firebase.initializeApp().whenComplete(
    //   (){
    //     print('COMPLETED');
    //     setState((){});
    //   }
    // );
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('베이킹 계산 도우미'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 100, 
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      firebaseController.getList();
                    }, 
                    child: const Text('버튼1')),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/3,
                      color: Colors.green,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text('asd'),
                        ],
                      )
                    
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text('asd'),
                        ],
                      )
                    )
                  ],
                )
              ),
            )
            
          ],
        ),
      ),
    );
  }
}