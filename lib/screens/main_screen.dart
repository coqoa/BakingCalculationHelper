import 'package:baking_calculation_helper/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;
  void getCurrentUser(){
    try{
      final user = _authentication.currentUser;
    if(user != null){
      loggedUser = user;
      print(loggedUser!.email);
    }
    }catch(e){
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MainScreen'),
        actions: [
          IconButton(
            onPressed: (){
              _authentication.signOut();
              Navigator.pop(context);
            }, 
            icon: Icon(
              Icons.exit_to_app_sharp,
              color: Palette.white
            )
          )
        ],
      ),
      body: Text('mainmain'),
    );
  }
}