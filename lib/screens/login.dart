import 'dart:developer';

import 'package:baking_calculation_helper/config/palette.dart';
import 'package:baking_calculation_helper/controller/controller.dart';
import 'package:baking_calculation_helper/screens/main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  // 신규 가입 계정에도 [firebase_auth/email-already-in-use] The email address is already in use by another account. 에러뜨고 안넘어감
  // 말도안되는 계정메일 걸러야함
  // 텍스트필드 클래스화하기
  // 코드 정리하기

  // db에 ID 있는지 검증하는 변수
  bool signupIdDefault = true;

  // 어디에 쓰는 변수?
  bool signupPasswordValidator = true;
  bool signupPasswordCheckValidator = true;
  String validatorValue = '';

  // 사인업 페이지 각 항목 유효성 체크 결과
  String signupIdValidateValue = '';
  String signupPasswordValidateValue = '';
  String signupPasswordCheckValidateValue = '';

  // 사인업 아이디 유효성 검사 함수
  void signupIdValidateFunc(userEmail, signupIdDefault){
    if(userEmail.length < 1){
      setState(() {
        signupIdValidateValue = '이메일을 입력해주세요';
      });
    }
    if(!userEmail.contains('@')){
      setState(() {
        signupIdValidateValue = '이메일 형식으로 작성해주세요 (예시 : abc@example.com)';
      });
    }
    if(!userEmail.contains('.')){
      setState(() {
        signupIdValidateValue = '이메일 형식으로 작성해주세요 (예시 : abc@example.com)';
      });
    }
    if(userEmail.contains('@') && userEmail.contains('.')){
      setState(() {
        signupIdValidateValue = '';
      });
    }
    if(signupIdDefault == false){
      setState(() {
        signupIdValidateValue = '존재하는 아이디 입니다';
      });
    }
    
  }

  // // Firebase Auth Error Handling Function
  // void authErrorHandlingfunc(String errorCode){
  //   switch (errorCode) {
  //     case '[firebase_auth/invalid-email] The email address is badly formatted.':
  //         setState(() {
  //           validatorValue = '이메일형식지켜';
  //         });
  //         log('validatorValue');
  //         print(validatorValue);
  //       break;
  //     case '[firebase_auth/missing-email] Error':
  //         setState(() {
  //           validatorValue = '에러다임마';
  //         });
  //         log('validatorValue');
  //         print(validatorValue);
  //       break;

  //     default:
  //       log('---------------------------errorCode--------------------------');
  //       print(errorCode);
  //       log('---------------------------errorCode--------------------------');
  //   }
  // }

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
      body: Center(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeIn,
          width: MediaQuery.of(context).size.width< 1950 
            ? MediaQuery.of(context).size.width*0.6 
            : MediaQuery.of(context).size.width*0.5,
          height: !isSignupScreen ? 300 : 400,
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
                                color: Palette.blue
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
                                color: Palette.blue
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
                
                // 사인업
                : Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // 아이디
                        TextFormField(
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9,a-z,A-Z,@,.]'))], // 정규식
                          autofocus: true,
                          keyboardType: TextInputType.emailAddress,
                          key: ValueKey(3),
                          // validator: (value){
                          //   // 유효성검사
                          //   if(value!.isEmpty || value.length < 4){
                          //     return 'Please enter at least 4 characters';
                          //   }
                          //   return null;
                          // },
                          // onSaved: (value){
                          //   userEmail = value!;
                          // },

                          onChanged: (value){
                            userEmail = value;
                            // 유저아이디 유효성 체크
                            if(userEmail.length>0){
                              firestore.collection(userEmail).doc(userEmail).get().then((value){
                                if(value.data() == null){ // null이면 데이터가 없으니깐 사용가능
                                  setState(() {
                                    signupIdDefault = true;
                                    signupIdValidateFunc(userEmail, signupIdDefault);
                                  });
                                }else{
                                  setState(() {
                                    signupIdDefault = false;
                                    signupIdValidateFunc(userEmail, signupIdDefault);
                                  });
                                }
                              });
                            }
                            
                          },
                          style: TextStyle(
                            color: signupIdDefault ? Palette.black : Palette.red 
                          ),
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
                                // color: signupIdDefault ? Palette.blue : Palette.red 
                                color: Palette.blue
                              ),
                              borderRadius: BorderRadius.circular(25)
                            ),
                            hintText: 'E-Mail',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: "NotoSansRegular",
                              color: Palette.textColor1
                            ),
                            contentPadding: EdgeInsets.all(10.0)
                          ),
                        ),

                        // 회원가입 아이디 검증 결과
                        Container(
                          height: 30,
                          child: Text(signupIdValidateValue,
                           style: TextStyle(
                              fontSize: 12,
                              fontFamily: "NotoSansRegular",
                              color: Colors.red[400],
                           ),
                          ),
                        ),


                         // 비밀번호
                        TextFormField(
                          key: ValueKey(4),
                          // validator: (value){
                          //   // 유효성검사
                          //   if(value!.isEmpty || value.length < 4){
                          //     return 'Please enter at least 4 characters';
                          //   }
                          //   return null;
                          // },
                          // onSaved: (value){
                          //   userPassword = value!;
                          // },
                          onChanged: (value){
                            userPassword = value;
                            if(userPassword.length < 6){
                              setState(() {
                                signupPasswordValidator = false;
                              });
                            }else{
                              setState(() {
                                signupPasswordValidator = true;
                              });
                            }
                          },
                          style: TextStyle(
                            color: signupPasswordValidator ? Palette.black : Palette.red 
                          ),
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: signupPasswordValidator ? Palette.iconColor : Palette.red
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: signupPasswordValidator ? Palette.textColor1 : Palette.red
                              ),
                              borderRadius: BorderRadius.circular(25)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: signupPasswordValidator ? Palette.blue : Palette.red
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

                        Container(
                          height: 20,
                          child: Text(signupPasswordValidator ? '' : '6자 이상 입력하세요',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: "NotoSansRegular",
                              color: Colors.red[400],
                              // fontWeight: FontWeight.bold,
                            ),
                          ),  
                        ),

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
                            if(userPassword != userPasswordCheck){
                              setState(() {
                                signupPasswordCheckValidator = false;
                              });
                            }else{
                              setState(() {
                                signupPasswordCheckValidator = true;
                              });
                            }
                          },
                          style: TextStyle(
                            color: signupPasswordCheckValidator ? Palette.black : Palette.red 
                          ),
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock_outlined,
                              color: signupPasswordCheckValidator ? Palette.iconColor : Palette.red
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: signupPasswordCheckValidator ? Palette.textColor1 : Palette.red
                              ),
                              borderRadius: BorderRadius.circular(25)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: signupPasswordCheckValidator ? Palette.blue : Palette.red
                              ),
                              borderRadius: BorderRadius.circular(25)
                            ),
                            hintText: 'Password Check',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color:Palette.textColor1
                            ),
                            contentPadding: EdgeInsets.all(10.0)
                          ),
                        ),

                        Container(
                          height: 20,
                          child: Text(signupPasswordCheckValidator ? '' : '비밀번호가 일치하지 않습니다',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: "NotoSansRegular",
                              color: Colors.red[400],
                              // fontWeight: FontWeight.bold,
                            ),
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
                          try{ // 조건 조정하기, 에러메시지 제대로 출력하기 / 한군데서 관리하기(validator통합)
                            print('A');
                            if(userEmail.length>0 && userPassword.length > 5 && userPassword==userPasswordCheck){
                              final newUser = await _authentication.createUserWithEmailAndPassword(
                                email: userEmail, 
                                password: userPassword
                              );
                            // if(userEmail.length>0 && userPassword.length > 6 && userPassword==userPasswordCheck){
                              if(newUser.user != null){
                                // 엔터키 이벤트에도 아래 두 라인 추가하기 // 221006
                                controller.setUserInit(userEmail);
                                Get.to(MainScreen());
                              }
                            }
                            
                          }catch(e){
                            // setState(() {
                              // authErrorHandlingfunc(e.toString());
                            // });

                          }
                        }
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            width: 120,
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
                          SizedBox(height: 10,),
                          Container(
                            child: Text(validatorValue),
                          )
                        ],
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