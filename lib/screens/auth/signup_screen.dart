import 'package:firebase_auth/firebase_auth.dart';
import 'package:firetuto/screens/auth/login_screen.dart';
import 'package:firetuto/utils/utils.dart';
import 'package:firetuto/widgets/round_button.dart';
import 'package:flutter/material.dart';

//ignore_for_file:prefer_const_constructors

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void signup() {
    setState(() {
      loading = true;
    });

    _auth
        .createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 20.0,
        title: Center(child: Text("SignUp Here")),
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
              title: 'Sign up',
              loading: loading,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  signup();
                }
              },
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: Text("Login"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
