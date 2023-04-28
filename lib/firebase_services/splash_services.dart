import 'package:firebase_auth/firebase_auth.dart';
import 'package:firetuto/screens/auth/login_screen.dart';
import 'package:firetuto/screens/posts/post_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

//ignore_for_file:prefer_const_constructors

class SplashServices {
  void isLogin(BuildContext context) {

    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;
    if(user!=null){

        Timer(
        const Duration(seconds: 3),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (contex) => PostScreen())));
    }
    else{

    Timer(
        const Duration(seconds: 3),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (contex) => LoginScreen())));
    }
  }
}
