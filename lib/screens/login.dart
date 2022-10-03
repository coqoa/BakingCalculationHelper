import 'package:baking_calculation_helper/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isSignupScreen = false;
  String userName = '';
  String userPassword = '';
  String userPasswordCheck = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.red,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width< 1950 
          ? MediaQuery.of(context).size.width*0.6 
          : MediaQuery.of(context).size.width*0.5,
          height: 400,
          // color: Colors.green,
          padding: EdgeInsets.fromLTRB(40, 40, 40, 40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 15,
                spreadRadius: 5
              )
            ]
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 로그인 / 회원가입 탭
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isSignupScreen = false;
                        });
                      },
                      child: Column(
                        children: [
                          Text('Login',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: !isSignupScreen 
                                      ? Palette.activeColor
                                      : Palette.textColor1
                            )
                          ),
                          SizedBox(height: 5),
                          if(!isSignupScreen)
                          Container(
                            height: 3,
                            width: 58,
                            color: Colors.orange,
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 80),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isSignupScreen = true;
                        });
                      },
                      child: Column(
                        children: [
                          Text('Signup',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isSignupScreen ? Palette.activeColor : Palette.textColor1
                            )
                          ),
                          SizedBox(height: 5),
                          if(isSignupScreen)
                          Container(
                            height: 3,
                            width: 55,
                            color: Colors.orange,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // 텍스트 폼 필드
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged: (value){
                          userName = value;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.account_circle,
                            color: Palette.iconColor
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Palette.textColor1
                            ),
                            borderRadius: BorderRadius.circular(25)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Palette.black
                            ),
                            borderRadius: BorderRadius.circular(25)
                          ),
                          hintText: 'User name',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Palette.textColor1
                          ),
                          contentPadding: EdgeInsets.all(10.0)
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        onChanged: (value){
                          userPassword = value;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.account_circle,
                            color: Palette.iconColor
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Palette.textColor1
                            ),
                            borderRadius: BorderRadius.circular(25)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Palette.black
                            ),
                            borderRadius: BorderRadius.circular(25)
                          ),
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Palette.textColor1
                          ),
                          contentPadding: EdgeInsets.all(10.0)
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  print(MediaQuery.of(context).size.width);
                },
                child: Center(
                  child: Container(
                    height: 70,
                    width: 120,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Palette.white,
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.orange,
                            Colors.red
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0,1)
                          )
                        ]
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Palette.white
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}