import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hyah/screens/splashscreen.dart';

import 'loginscreen.dart';
import 'profilescreen.dart';

class MeasuresScreen extends StatefulWidget {
  MeasuresScreen({Key? key}) : super(key: key);

  @override
  State<MeasuresScreen> createState() => _MeasuresScreenState();
}

class _MeasuresScreenState extends State<MeasuresScreen> {
  late String BabyPulse = '-';
  late String BabySpo = '-';
  late String BabyTemperature = '-';
  late String IncubationTemperature = '-';
  late String IncubationHumidity = '-';
  late String BabyName = '-';
  late String FirstName = '-';
  late String Account = '-';

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    var Users = FirebaseFirestore.instance
        .collection('User')
        .doc(UserID)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          try {
            dynamic data = documentSnapshot.data();
            BabyName = data['BabyName'];
            FirstName = data['FirstName'];
            Account = data['Account'];
          } on StateError catch (e) {}
        });
      }
    });
    var Measures = FirebaseFirestore.instance
        .collection('Measures')
        .doc(UserID)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          try {
            dynamic data = documentSnapshot.data();
            BabyPulse = data['BabyPulse'];
            BabySpo = data['BabySpo'];
            BabyTemperature = data['BabyTemperature'];
            IncubationTemperature = data['IncubationTemperature'];
            IncubationHumidity = data['IncubationHumidity'];
          } on StateError catch (e) {}
        });
      }
    });
    // String IncubationPulse = Measures.get()
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text('Measures'),
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Hello ${(Account == 'Doctor') ? 'Dr/ ' : 'Mr/ '}$FirstName',
                style: TextStyle(fontSize: 25),
              ),
              Center(
                  child: Text(
                '$BabyName',
                style: TextStyle(fontSize: 25),
              )),
              Text(
                'Baby Measures',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              'assets/svg/pulse.svg',
                              width: 35,
                              height: 35,
                            ),
                            Text(
                              '${BabyPulse}',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Pulse rate',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        constraints:
                            BoxConstraints(minWidth: 80, maxHeight: 80),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              'assets/svg/oxygen-svgrepo-com.svg',
                              width: 35,
                              height: 35,
                            ),
                            Text(
                              '${BabySpo}',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'SPO2',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      )
                    ],
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'assets/svg/thermometer-temperature-svgrepo-com.svg',
                            width: 35,
                            height: 35,
                          ),
                          Text(
                            '${BabyTemperature}',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Temperature',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    )
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                thickness: 2,
              ),
              Text(
                'Incubation Measures',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Temperature : ${IncubationTemperature}',
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
              Text(
                'Humidity : ${IncubationHumidity}',
                style: TextStyle(color: Colors.black, fontSize: 22),
              ),
            ],
          )),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.person,
                  size: 30,
                ),
                title: Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(),
                      ));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  size: 30,
                ),
                title: Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
                onTap: () {
                  setState(() {
                    signed = false;
                  });
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
