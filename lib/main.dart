import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/utils.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // 추가
  
  try{
    await Firebase.initializeApp(
      options: const FirebaseOptions(
       apiKey: "AIzaSyBCUtKPIfnY2QGBHcB08D238ykGpV5SFGY",
       authDomain: "baking-weighing-assistant.firebaseapp.com",
       projectId: "baking-weighing-assistant",
       storageBucket: "baking-weighing-assistant.appspot.com",
       messagingSenderId: "545566933824",
       appId: "1:545566933824:web:4af0c89fb3dd4af7bcb0a5"
       
       ),
    );
  }catch(e){
    print('e');
    print(e);
  }
  // // ignore: unrelated_type_equality_checks
  // if(Firebase.apps.length==false){
  //   await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //      apiKey: "AIzaSyBCUtKPIfnY2QGBHcB08D238ykGpV5SFGY",
  //      authDomain: "baking-weighing-assistant.firebaseapp.com",
  //      projectId: "baking-weighing-assistant",
  //      storageBucket: "baking-weighing-assistant.appspot.com",
  //      messagingSenderId: "545566933824",
  //      appId: "1:545566933824:web:4af0c89fb3dd4af7bcb0a5"
       
  //      ),
  //   );
  // }else{
  //   Firebase.app();
  // }
  
  // await Firebase.initializeApp(
  //  options: const FirebaseOptions(
  //      apiKey: "AIzaSyBCUtKPIfnY2QGBHcB08D238ykGpV5SFGY",
  //      authDomain: "baking-weighing-assistant.firebaseapp.com",
  //      projectId: "baking-weighing-assistant",
  //      storageBucket: "baking-weighing-assistant.appspot.com",
  //      messagingSenderId: "545566933824",
  //      appId: "1:545566933824:web:4af0c89fb3dd4af7bcb0a5"
       
  //      ),
 
  // ); //  추가

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BakingCalculationApp(),
    );
  }
}
class BakingCalculationApp extends StatefulWidget {
  const BakingCalculationApp({Key? key}) : super(key: key);

  @override
  State<BakingCalculationApp> createState() => _BakingCalculationAppState();
}

class _BakingCalculationAppState extends State<BakingCalculationApp> {

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final doc1= firestore.collection('test').doc('testd');
  
  
  @override
  void initState() {
    Firebase.initializeApp().whenComplete(
      (){print('COMPLETED');
      setState(() {
      
      });}
    );
    
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
                  ElevatedButton(onPressed: (){
                    doc1.get().then(((value) => 
                      print(value.data())
                    ));
                  }, child: const Text('버튼1')),
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