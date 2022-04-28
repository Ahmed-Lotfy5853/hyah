import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'loginscreen.dart';

class VerifiedScreen extends StatefulWidget {
  String firstName;
  String lastName;
  String email;
  String phone;
  String password;
  String babyName;
  String birthDate;
  String gender;
  String account;
  bool verified;

  String userId;

  VerifiedScreen({Key? key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password,
    required this.babyName,
    required this.birthDate,
    required this.gender,
    required this.account,
    required this.verified,
    required this.userId,
  }) : super(key: key);

  @override
  State<VerifiedScreen> createState() => _VerifiedScreenState();
}

class _VerifiedScreenState extends State<VerifiedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.info_outline),
                  const Text('Please verify your mail'),
                  // SizedBox(width: 20,),
                  MaterialButton(
                    onPressed: () async {
                      if (!FirebaseAuth.instance.currentUser!.emailVerified) {
                        FirebaseAuth.instance.currentUser!
                            .sendEmailVerification()
                            .then((value) {
                          setState(() {
                            widget.verified = FirebaseAuth
                                .instance.currentUser!.emailVerified;
                          });
                          return Fluttertoast.showToast(
                              msg: 'Check your mail',
                              backgroundColor: Colors.blue);
                        }).catchError((e) {
                          if (kDebugMode) {
                            print(e);
                          }

                        });
                      } else {
                        setState(() {
                          widget.verified =
                              FirebaseAuth.instance.currentUser!.emailVerified;
                        });
                        if (kDebugMode) {
                          print('true authenticated');
                        }
                        Fluttertoast.showToast(
                            msg: 'Your mail is verified',
                            backgroundColor: Colors.blue);
                      }
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    color: Colors.blue,
                    child: const Text('Send Verifcation'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
