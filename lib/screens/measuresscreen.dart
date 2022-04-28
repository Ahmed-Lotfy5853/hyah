import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'loginscreen.dart';
import 'profilescreen.dart';

class MeasuresScreen extends StatefulWidget {
  const MeasuresScreen({Key? key}) : super(key: key);

  @override
  State<MeasuresScreen> createState() => _MeasuresScreenState();
}

class _MeasuresScreenState extends State<MeasuresScreen> {
  late String babypulse = '-';
  late String babyspo = '-';
  late String babytemperature = '-';
  late String incubationtemperature = '-';
  late String incubationhumidity = '-';
  late String babyname = '-';
  late String firstname = '-';
  late String account = '-';

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    // String IncubationPulse = Measures.get()
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: const Text('Measures'),
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Hello ${(account == 'Doctor') ? 'Dr/ ' : 'Mr/ '}$firstname',
                style: const TextStyle(fontSize: 25),
              ),
              Center(
                  child: Text(
                babyname,
                style: const TextStyle(fontSize: 25),
              )),
              const Text(
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
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
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
                              babypulse,
                              style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        'Pulse rate',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        constraints:
                            const BoxConstraints(minWidth: 80, maxHeight: 80),
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
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
                              babyspo,
                              style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const Text(
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
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
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
                            babytemperature,
                            style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      'Temperature',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    )
                  ],
                ),
              ),
              const Divider(
                color: Colors.grey,
                thickness: 2,
              ),
              const Text(
                'Incubation Measures',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Temperature : $incubationtemperature',
                style: const TextStyle(color: Colors.black, fontSize: 25),
              ),
              Text(
                'Humidity : $incubationhumidity',
                style: const TextStyle(color: Colors.black, fontSize: 22),
              ),
            ],
          )),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(
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
                        builder: (context) => const ProfileScreen(),
                      ));
                },
              ),
              ListTile(
                leading: const Icon(
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
                        builder: (context) => const LoginScreen(),
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
