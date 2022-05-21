import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hyah/screens/measuresscreen.dart';
import 'package:hyah/widgets/textformfield.dart';

import 'signupscreen.dart';
import 'splashscreen.dart';

bool signed = false;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController loginusercontroller = TextEditingController();

  TextEditingController loginpasswordcontroller = TextEditingController();

  bool invisible = true;

  var loginkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: loginkey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              customTextFormField(
                  controller: loginusercontroller,
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
              const SizedBox(
                height: 10,
              ),
              customTextFormField(
                  controller: loginpasswordcontroller,
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
              const SizedBox(
                height: 10,
              ),
              InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  if (loginkey.currentState!.validate()) {
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: loginusercontroller.text,
                            password: loginpasswordcontroller.text)
                        .then((value) async {
                          print("this is user object:    ${FirebaseAuth.instance.currentUser}");
                      if (value.user!.emailVerified) {
                        setState(() {
                          userID = value.user!.uid;
                        });
                        signed = true;
                        Fluttertoast.showToast(
                            msg: 'Successeded Signed in',
                            backgroundColor: Colors.blue);

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MeasuresScreen()));
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
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ),
              Row(
                children: [
                  const Text(
                    'New user ?',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.normal),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupScreen(),
                            ));
                      },
                      child: const Text(
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
