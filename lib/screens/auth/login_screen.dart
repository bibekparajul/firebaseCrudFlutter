import 'package:firebase_auth/firebase_auth.dart';
import 'package:firetuto/screens/auth/signup_screen.dart';
import 'package:firetuto/screens/posts/post_screen.dart';
import 'package:firetuto/utils/utils.dart';
import 'package:firetuto/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//ignore_for_file:prefer_const_constructors

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
  
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login(){
    setState(() {
      loading = true;
    });

    _auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text.toString()).then((value) {
      Utils().toastMessage(value.user!.email.toString());
      Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen()));
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {

      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
    setState(() {
      loading = false;
    });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          elevation: 20.0,
          automaticallyImplyLeading: false,
          title: Center(child: Text("Login Here")),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            helperText: 'abc1@gmail.com',
                            prefixIcon: Icon(Icons.alternate_email)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Email';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.password_outlined)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter password';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  )),
              SizedBox(
                height: 50,
              ),
              RoundButton(
                title: 'Login',
                loading: loading ,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    login();
                  }
                },
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("Don't have an account?"),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                }, child: Text("Sign Up"))
    
              ],),
              
    
            ],
          ),
        ),
      ),
    );
  }
}
