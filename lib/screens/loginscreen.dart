import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hyah/screens/measuresscreen.dart';
import 'package:hyah/widgets/textformfield.dart';

import 'signupscreen.dart';
import 'splashscreen.dart';

bool signed = false;

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController LoginUserController = TextEditingController();

  TextEditingController LoginPasswordController = TextEditingController();

  bool invisible = true;

  var LoginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: LoginKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextFormField(
                  Controller: LoginUserController,
                  keytype: TextInputType.name,
                  hint: 'User Email',
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Field is empty';
                    } else if (!(value!.contains('@') &&
                        value!.contains('.com'))) {
                      return 'Email is invalid';
                    }
                    return null;
                  },
                  preicon: Icons.person),
              SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                  Controller: LoginPasswordController,
                  keytype: TextInputType.visiblePassword,
                  hint: 'Password',
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Field is empty';
                    }
                    return null;
                  },
                  preicon: Icons.lock,
                  suffix: invisible ? Icons.visibility : Icons.visibility_off,
                  suffixtap: () {
                    setState(() {
                      invisible = !invisible;
                    });
                  },
                  secure: invisible),
              SizedBox(
                height: 10,
              ),
              InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  if (LoginKey.currentState!.validate()) {
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: LoginUserController.text,
                            password: LoginPasswordController.text)
                        .then((value) async {
                      if (value.user!.emailVerified) {
                        setState(() {
                          UserID = value.user!.uid;
                        });
                        signed = true;
                        Fluttertoast.showToast(
                            msg: 'Successeded Signed in',
                            backgroundColor: Colors.blue);

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MeasuresScreen()));
                      } else {
                        Fluttertoast.showToast(
                            msg: 'Mail is not verified ',
                            backgroundColor: Colors.blue);
                      }
                    }).catchError((e) => Fluttertoast.showToast(
                            msg: 'Failed Signed in',
                            backgroundColor: Colors.blue));
                  }
                },
                child: Container(
                  width: 100,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    'New user ?',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.normal),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupScreen(),
                            ));
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(fontSize: 22, color: Colors.blue),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
