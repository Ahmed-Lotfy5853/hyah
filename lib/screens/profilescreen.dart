import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'signupscreen.dart';
import 'splashscreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String firstname = '';
  late String lastname = '';
  late String email = '';
  late String phone = '';
  late String birthdate = '';
  late String gender = '';
  late String account = '';

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('User')
        .doc(userID)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          try {
            dynamic data = documentSnapshot.data();
            firstname = data['FirstName'];
            lastname = data['LastName'];
            email = data['Email'];
            phone = data['Phone'];
            birthdate = data['BirthDate'];
            gender = data['Gender'];
            account = data['Account'];
          } on StateError catch (e) {
            if (kDebugMode) {
              print(e);
            }
          }
        });
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name : $firstname $lastname',
              style: const TextStyle(color: Colors.black, fontSize: 25),
            ),
            Text(
              'Email : $email',
              style: const TextStyle(color: Colors.black, fontSize: 25),
            ),
            Text(
              'Phone : +20$phone',
              style: const TextStyle(color: Colors.black, fontSize: 25),
            ),
            Text(
              'Birth Date : $birthdate',
              style: const TextStyle(color: Colors.black, fontSize: 25),
            ),
            Text(
              'Gender : $gender',
              style: const TextStyle(color: Colors.black, fontSize: 25),
            ),
            Text(
              'Account : $account',
              style: const TextStyle(color: Colors.black, fontSize: 25),
            ),
            Container(
              alignment: Alignment.center,
              child: MaterialButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ));
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 100,
                  padding: const EdgeInsets.all(5),
                  child: const Text(
                    'Edit',
                    style: TextStyle(color: Colors.white, fontSize: 23),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
