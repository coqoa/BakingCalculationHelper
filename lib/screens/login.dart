import 'package:baking_calculation_helper/config/palette.dart';
import 'package:baking_calculation_helper/controller/controller.dart';
import 'package:baking_calculation_helper/screens/main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String loginValidator = '';

  bool isSignupScreen = false;
  String userEmail = '';
  String userPassword = '';
  String userPasswordCheck = '';
  final _formKey = GlobalKey<FormState>();

  Controller controller = Controller();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _authentication = FirebaseAuth.instance;

  bool signupIdCheck = true;

  void _tryValudation(){
    final isValid = _formKey.currentState!.validate();
    if(isValid){
      _formKey.currentState!.save();
    }
  }

  @override
  void initState() {
    super.initState();
    // controller.checkUser('admin1@gmail.com');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Palette.red,
      body: Center(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeIn,
          width: MediaQuery.of(context).size.width< 1950 
          ? MediaQuery.of(context).size.width*0.6 
          : MediaQuery.of(context).size.width*0.5,
          height: !isSignupScreen ? 280 : 350,
          // color: Colors.green,
          padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                spreadRadius: 1
              )
            ]
          ),

          
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
          
                // 상단 로그인 / 회원가입 탭 부분
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
                !isSignupScreen 
                // 로그인 탭
                ? Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          key: ValueKey(1),
                          validator: (value){
                            // 유효성검사
                            if(value!.isEmpty || value.length < 4){
                              return 'Please enter at least 4 characters';
                            }
                            return null;
                          },
                          onSaved: (value){
                            userEmail = value!;
                          },
                          onChanged: (value){
                            userEmail = value;
                          },
                          onFieldSubmitted: (value) => {
                            controller.getUser(userEmail, "recipee")
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
                            hintText: 'E-Mail',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: Palette.textColor1
                            ),
                            contentPadding: EdgeInsets.all(10.0)
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          child: Text(loginValidator),
                        
                        ),
                        TextFormField(
                          key: ValueKey(2),
                          validator: (value){
                            // 유효성검사
                            if(value!.isEmpty || value.length < 6){
                              return 'Password must be at least 7 characters long';
                            }
                            return null;
                          },
                          onSaved: (value){
                            userPassword = value!;
                          },
                          onChanged: (value){
                            userPassword = value;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
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
                )
                
                // 사인업 탭
                : Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // 아이디
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          key: ValueKey(3),
                          validator: (value){
                            // 유효성검사
                            if(value!.isEmpty || value.length < 4){
                              return 'Please enter at least 4 characters';
                            }
                            return null;
                          },
                          onSaved: (value){
                            userEmail = value!;
                          },

                          onChanged: (value){
                            userEmail = value;
                            // 유저아이디 유효성 체크
                            if(userEmail.length>0){
                              firestore.collection(userEmail).doc(userEmail).get().then((value){
                                if(value.data() == null){
                                  setState(() {
                                    signupIdCheck = true;
                                  });
                                }else{
                                  setState(() {
                                    signupIdCheck = false;
                                  });
                                }
                              });
                            }
                          },
                          style: TextStyle(
                            color: signupIdCheck ? Palette.black : Palette.red 
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.account_circle,
                              color: signupIdCheck ? Palette.iconColor : Palette.red 
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: signupIdCheck ? Palette.textColor1 : Palette.red 
                              ),
                              borderRadius: BorderRadius.circular(25)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: signupIdCheck ? Palette.textColor1 : Palette.red 
                              ),
                              borderRadius: BorderRadius.circular(25)
                            ),
                            hintText: 'E-Mail',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: Palette.textColor1
                            ),
                            contentPadding: EdgeInsets.all(10.0)
                          ),
                        ),
                        Container(
                          height: 20,
                          child: Text(signupIdCheck ? '' : '존재하는 아이디 입니다',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: "NotoSansRegular",
                              color: Colors.red[400],
                              // fontWeight: FontWeight.bold,
                            ),
                          ),  
                        ),
                         // 비밀번호
                        TextFormField(
                          key: ValueKey(4),
                          validator: (value){
                            // 유효성검사
                            if(value!.isEmpty || value.length < 4){
                              return 'Please enter at least 4 characters';
                            }
                            return null;
                          },
                          onSaved: (value){
                            userPassword = value!;
                          },
                          onChanged: (value){
                            userPassword = value;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
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
                         SizedBox(height: 20),
                         // 비밀번호 확인
                        TextFormField(
                          key: ValueKey(5),
                          validator: (value){
                            // 유효성검사
                            if(value!.isEmpty || value.length < 4){
                              return 'Please enter at least 4 characters';
                            }else if(value != userPassword){
                              return 'Password Uncorrect';
                            }
                            return null;
                          },
                          onSaved: (value){
                            userPasswordCheck = value!;
                          },
                          onChanged: (value){
                            userPasswordCheck = value;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock_outlined,
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
                            hintText: 'Password Check',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: Palette.textColor1
                            ),
                            contentPadding: EdgeInsets.all(10.0)
                          ),
                        ),
                      ],
                    )
                  ),
                ),
                SizedBox(height: 10),
                // 버튼
                Center(
                  child: Container(
                    height: 70,
                    width: 120,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Palette.white,
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: GestureDetector(
                      onTap: () async{
                        if(!isSignupScreen){
                          // 로그인 탭이면
                          _tryValudation();
                          try{
                            final user = await _authentication.signInWithEmailAndPassword(
                              email: userEmail, 
                              password: userPassword
                            );
                            if(user.user != null){
                              Get.to(MainScreen());
                            }
                          }catch(e){
                            print(e);
                          }
                        }else{
                          // 사인업 탭이면
                          _tryValudation();
                          try{
                            final newUser = await _authentication.createUserWithEmailAndPassword(
                              email: userEmail, 
                              password: userPassword
                            );
                            if(newUser.user != null){

                              // 엔터키 이벤트에도 아래 두 라인 추가하기 // 221006
                              controller.setUserInit(userEmail);
                              Get.to(MainScreen());
                            }
                          }catch(e){
                            print(e);

                          }
                        }
                        
                        
                      },
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
      ),
    );
  }
}