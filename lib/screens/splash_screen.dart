import 'package:firetuto/firebase_services/splash_services.dart';
import 'package:flutter/material.dart';

//ignore_for_file:prefer_const_constructors


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  SplashServices splashServices = SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashServices.isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Fire Tuto", style: TextStyle(color: Colors.blueGrey, fontSize: 24),)),
    );
  }
}
