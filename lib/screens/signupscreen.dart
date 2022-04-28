import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hyah/screens/loginscreen.dart';
import 'package:hyah/screens/profilescreen.dart';
import 'package:hyah/screens/verifiedscreen.dart';
import 'package:selection_menu/selection_menu.dart';

import '../widgets/textformfield.dart';
import 'splashscreen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController signfirstnamecontroller = TextEditingController();

  TextEditingController signlastnamecontroller = TextEditingController();

  TextEditingController signupemailcontroller = TextEditingController();

  TextEditingController signuppasswordcontroller = TextEditingController();
  TextEditingController signupbabycontroller = TextEditingController();

  TextEditingController signphonecontroller = TextEditingController();
  TextEditingController signdatecontroller = TextEditingController();
  String gender = 'Male';
  String client = 'Parent';

  bool invisible = true;

  var signkey = GlobalKey<FormState>();

  @override
  void initState() {
    if (signed) {
      setState(() {
        FirebaseFirestore.instance
            .collection('User')
            .doc(userID)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            setState(() {
              try {
                dynamic data = documentSnapshot.data();
                signfirstnamecontroller.text = data['FirstName'];
                signlastnamecontroller.text = data['LastName'];
                signupemailcontroller.text = data['Email'];
                signuppasswordcontroller.text = data['Email'];
                signphonecontroller.text = data['Phone'];
                signdatecontroller.text = data['BirthDate'];
                signupbabycontroller.text = data['BirthDate'];
                gender = data['Gender'];
                client = data['Account'];
              } on StateError {
                (e) {
                  if(kDebugMode)print(e);
                };
              }
            });
          }
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference user = FirebaseFirestore.instance.collection('User');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: signkey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 150,
                      child: TextFormField(
                        controller: signfirstnamecontroller,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: 'First Name',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.blue)),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field is empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                        width: 150,
                        child: TextFormField(
                          controller: signlastnamecontroller,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: 'Last Name',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.blue)),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is empty';
                            }
                            return null;
                          },
                        )),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                customTextFormField(
                  controller: signupbabycontroller,
                  hint: 'Baby Name',
                  keytype: TextInputType.name,
                  preicon: Icons.child_care,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Field is empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                customTextFormField(
                  controller: signupemailcontroller,
                  hint: 'Email',
                  keytype: TextInputType.emailAddress,
                  preicon: Icons.mail,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Field is empty';
                    } else if (!(value!.contains('@') &&
                        value!.contains('.com'))) {
                      return 'Email is invalid';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                customTextFormField(
                  controller: signuppasswordcontroller,
                  hint: 'Password',
                  keytype: TextInputType.visiblePassword,
                  preicon: Icons.lock,
                  suffix: invisible ? Icons.visibility : Icons.visibility_off,
                  secure: invisible,
                  suffixtap: () {
                    setState(() {
                      invisible = !invisible;
                    });
                  },
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Field is empty';
                    } else if (value!.length < 6) {
                      return 'Password is atleast 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: signphonecontroller,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      hintText: ' Phone',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.blue)),
                      prefixIcon: const Icon(Icons.phone),
                      prefixText: '+20'),
                  validator: (value) {

                    if (value!.isEmpty) {
                      return 'Field is empty';
                    } else if (value.length != 10) {

                      return 'Invalid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: signdatecontroller,
                  keyboardType: TextInputType.datetime,
                  onTap: () {
                    showDatePicker(
                            firstDate: DateTime(1900),
                            context: context,
                            lastDate: DateTime(2200),
                            initialDate: DateTime(DateTime.now().year - 20,
                                DateTime.now().month, DateTime.now().day))
                        .then((value) {
                      signdatecontroller.text =
                          DateTime(value!.year, value.month, value.day)
                              .toString()
                              .replaceAll("00:00:00.000", "");
                    });
                  },
                  decoration: InputDecoration(
                      hintText: 'Birth Date',
                      prefixIcon: const Icon(Icons.calendar_month),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.blue))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      //return 'حقل كلمه المرور فارغاً';
                      return 'Field is empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SelectionMenu<String>(
                      initiallySelectedItemIndex: 0,
                      showSelectedItemAsTrigger: true,

                      itemsList: const <String>['Male', 'Female'],
                      onItemSelected: (String selectedItem) {
                        setState(() {
                          gender = selectedItem;
                        });
                      },
                      itemBuilder: (BuildContext context, String item,
                          OnItemTapped onItemTapped) {
                        return ElevatedButton(
                          onPressed: onItemTapped,
                          child: Text(
                            item,
                            style: const TextStyle(color: Colors.white, fontSize: 22),
                          ),
                        );
                      },
                      // other Properties...
                    ),
                    SelectionMenu<String>(
                      initiallySelectedItemIndex: 0,
                      showSelectedItemAsTrigger: true,
                      itemsList: const <String>['Parent', 'Doctor'],
                      onItemSelected: (String selectedItem) {
                        setState(() {
                          client = selectedItem;
                        });
                      },
                      itemBuilder: (BuildContext context, String item,
                          OnItemTapped onItemTapped) {
                        return ElevatedButton(
                          onPressed: onItemTapped,
                          child: Text(
                            item,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                        );
                      },
                      // other Properties...
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () async {
                    if (signkey.currentState!.validate()) {
                      if (userID == null) {
                        // Call the user's CollectionReference to add a new user
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: signupemailcontroller.text,
                                password: signuppasswordcontroller.text)
                            .then((value) {
                          user.doc(value.user!.uid).set({
                            'UserId': value.user!.uid,
                            'Verified': value.user!.emailVerified,
                            'FirstName': signfirstnamecontroller.text,
                            // John Doe
                            'LastName': signlastnamecontroller.text,
                            // Stokes and Sons
                            'BabyName': signupbabycontroller.text,
                            'Email': signupemailcontroller.text,
                            'Password': signuppasswordcontroller.text,
                            // 42
                            'Phone': signphonecontroller.text,
                            // 42
                            'BirthDate': signdatecontroller.text,
                            // 42
                            'Gender': gender,
                            // 42
                            'Account': client,
                            // 42
                          });
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VerifiedScreen(
                                        firstName: signfirstnamecontroller.text,
                                        lastName: signlastnamecontroller.text,
                                        babyName: signupbabycontroller.text,
                                        email: signupemailcontroller.text,
                                        password: signuppasswordcontroller.text,
                                        phone: signphonecontroller.text,
                                        birthDate: signdatecontroller.text,
                                        gender: gender,
                                        account: client,
                                        userId: value.user!.uid,
                                        verified: value.user!.emailVerified,
                                      )));
                        });
                      } else {
                        user.doc(userID).update({
                          'FirstName': signfirstnamecontroller.text,
                          // John Doe
                          'LastName': signlastnamecontroller.text,
                          // Stokes and Sons
                          'BabyName': signupbabycontroller.text,
                          'Email': signupemailcontroller.text,
                          'Password': signuppasswordcontroller.text,
                          // 42
                          'Phone': signphonecontroller.text,
                          // 42
                          'BirthDate': signdatecontroller.text,
                          // 42
                          'Gender': gender,
                          // 42
                          'Account': client,
                          // 42
                        });
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  ProfileScreen(firstname: signfirstnamecontroller.text, lastname: signlastnamecontroller.text, email: signupemailcontroller.text, phone: signphonecontroller.text, birthdate: signdatecontroller.text, gender: gender, account: client)));
                      }
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      signed ? 'Save Edit' : 'Sign up',
                      style: const TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: !signed,
                  child: Row(
                    children: [
                      const Text(
                        'Have an account ?',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.normal),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ));
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 22, color: Colors.blue),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
