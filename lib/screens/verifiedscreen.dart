import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'loginscreen.dart';

class VerifiedScreen extends StatefulWidget {
  String FirstName;
  String LastName;
  String Email;
  String Phone;
  String Password;
  String BabyName;
  String BirthDate;
  String Gender;
  String Account;
  bool verified;

  String UserId;

  VerifiedScreen({
    required this.FirstName,
    required this.LastName,
    required this.Email,
    required this.Phone,
    required this.Password,
    required this.BabyName,
    required this.BirthDate,
    required this.Gender,
    required this.Account,
    required this.verified,
    required this.UserId,
  });

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
                  Icon(Icons.info_outline),
                  Text('Please verify your mail'),
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
                        }).catchError((e) => print(e));
                      } else {
                        setState(() {
                          widget.verified =
                              FirebaseAuth.instance.currentUser!.emailVerified;
                        });
                        print('true authenticated');
                        Fluttertoast.showToast(
                            msg: 'Your mail is verified',
                            backgroundColor: Colors.blue);
                      }
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    color: Colors.blue,
                    child: Text('Send Verifcation'),
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
