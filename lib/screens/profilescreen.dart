import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'signupscreen.dart';
import 'splashscreen.dart';

class ProfileScreen extends StatefulWidget {

  late String firstname = '';
  late String lastname = '';
  late String email = '';
  late String phone = '';
  late String birthdate = '';
  late String gender = '';
  late String account = '';


  ProfileScreen(
      {
        required this.firstname,
        required this.lastname,
        required this.email,
        required this.phone,
        required this.birthdate,
        required this.gender,
        required this.account
      });


  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  @override
  Widget build(BuildContext context) {

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
              'Name : ${widget.firstname} ${widget.lastname}',
              style: const TextStyle(color: Colors.black, fontSize: 25),
            ),
            Text(
              'Email : ${widget.email}',
              style: const TextStyle(color: Colors.black, fontSize: 25),
            ),
            Text(
              'Phone : +20${widget.phone}',
              style: const TextStyle(color: Colors.black, fontSize: 25),
            ),
            Text(
              'Birth Date : ${widget.birthdate}',
              style: const TextStyle(color: Colors.black, fontSize: 25),
            ),
            Text(
              'Gender : ${widget.gender}',
              style: const TextStyle(color: Colors.black, fontSize: 25),
            ),
            Text(
              'Account : ${widget.account}',
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
