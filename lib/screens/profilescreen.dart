import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'signupscreen.dart';
import 'splashscreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String FirstName = '';
  late String LastName = '';
  late String Email = '';
  late String Phone = '';
  late String BirthDate = '';
  late String Gender = '';
  late String Account = '';

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('User')
        .doc(UserID)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          try {
            dynamic data = documentSnapshot.data();
            FirstName = data['FirstName'];
            LastName = data['LastName'];
            Email = data['Email'];
            Phone = data['Phone'];
            BirthDate = data['BirthDate'];
            Gender = data['Gender'];
            Account = data['Account'];
          } on StateError catch (e) {}
        });
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name : $FirstName $LastName',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            Text(
              'Email : $Email',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            Text(
              'Phone : +20$Phone',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            Text(
              'Birth Date : $BirthDate',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            Text(
              'Gender : $Gender',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            Text(
              'Account : $Account',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            Container(
              alignment: Alignment.center,
              child: MaterialButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignupScreen(),
                      ));
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 100,
                  padding: EdgeInsets.all(5),
                  child: Text(
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
