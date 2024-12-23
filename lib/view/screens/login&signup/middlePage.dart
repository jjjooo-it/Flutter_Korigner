import 'dart:ui';
import 'package:capstonedesign/view/screens/login&signup/loginPage.dart';
import 'package:capstonedesign/view/screens/login&signup/signupPage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../first/onBoardingPage.dart';


class MiddlePage extends StatefulWidget {
  @override
  _MiddlePageState createState()=> _MiddlePageState();
}
class _MiddlePageState extends State<MiddlePage>{

  //로고 이미지에 애니메이션 넣기
  bool _visible = false;
  @override
  void initState(){
    super.initState();
    Future.delayed(Duration(milliseconds: 400),(){ //서서히 나타나도록
      setState(() {
        _visible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:  Padding(
        padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
        child: Center (
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             const Text("Koreigner",
                style:  TextStyle(
                  fontSize: 40,
                  letterSpacing: 2
                ),
              ),
              SizedBox(height: 5),
              Text(
                tr("subtitle"),
                style: TextStyle(
                  fontSize: 23,
                  fontFamily: 'SejonghospitalLight',
                  color: Color.fromRGBO(92, 67, 239, 60),
                ),
              ),
              SizedBox(height: 5),
              AnimatedOpacity(
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 1000),
                opacity: _visible ? 1:0,
                child: Image.asset(
                  "assets/logo/logo_purple.png",
                  width: 200,
                  height: 200,
                )
              ),
              SizedBox(height: 150),
              ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context)=> LoginPage(welcomeMessage: tr("logout_success")))
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(92, 67, 239, 50),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(120, 15, 120, 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                  ),
                  child: Text(
                      tr("start_button"),
                    style: TextStyle(
                        fontSize: 20,
                      fontFamily: "SejonghospitalBold"
                    ),
                  )
              ),
              SizedBox(height: 10),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context)=> OnBoardingPage())
                    );
                  },
                  child:
                  Text( tr("sign_up_prompt"),
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        decoration: TextDecoration.underline,
                        fontFamily: "SejonghospitalLight"
                    ),
                  )
              ),
            ]
          ),
        ),
      ),
    );
  }
}
