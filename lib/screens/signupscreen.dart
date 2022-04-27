import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hyah/screens/loginscreen.dart';
import 'package:hyah/screens/profilescreen.dart';
import 'package:hyah/screens/verifiedscreen.dart';
import 'package:selection_menu/selection_menu.dart';

import '../widgets/textformfield.dart';
import 'splashscreen.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController SignFirstNameController = TextEditingController();

  TextEditingController SignLastNameController = TextEditingController();

  TextEditingController SignupEmailController = TextEditingController();

  TextEditingController SignupPasswordController = TextEditingController();
  TextEditingController SignupbabyController = TextEditingController();

  TextEditingController SignPhoneController = TextEditingController();
  TextEditingController SignDateController = TextEditingController();
  String gender = 'Male';
  String client = 'Parent';

  bool invisible = true;

  var SignKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (signed) {
      setState(() {
        FirebaseFirestore.instance
            .collection('User')
            .doc(UserID)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            setState(() {
              try {
                dynamic data = documentSnapshot.data();
                SignFirstNameController.text = data['FirstName'];
                SignLastNameController.text = data['LastName'];
                SignupEmailController.text = data['Email'];
                SignupPasswordController.text = data['Email'];
                SignPhoneController.text = data['Phone'];
                SignDateController.text = data['BirthDate'];
                SignupbabyController.text = data['BirthDate'];
                gender = data['Gender'];
                client = data['Account'];
              } on StateError catch (e) {}
            });
          }
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference User = FirebaseFirestore.instance.collection('User');

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: SignKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 150,
                      child: TextFormField(
                        controller: SignFirstNameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: 'First Name',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.blue)),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field is empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                        width: 150,
                        child: TextFormField(
                          controller: SignLastNameController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: 'Last Name',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Colors.blue)),
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
                SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  Controller: SignupbabyController,
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
                SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  Controller: SignupEmailController,
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
                SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  Controller: SignupPasswordController,
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
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: SignPhoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      hintText: ' Phone',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Colors.blue)),
                      prefixIcon: Icon(Icons.phone),
                      prefixText: '+20'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field is empty';
                    } else if (value!.length == 10) {
                      return 'Invalid number';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: SignDateController,
                  keyboardType: TextInputType.datetime,
                  onTap: () {
                    showDatePicker(
                            firstDate: DateTime(1900),
                            context: context,
                            lastDate: DateTime(2200),
                            initialDate: DateTime(DateTime.now().year - 20,
                                DateTime.now().month, DateTime.now().day))
                        .then((value) {
                      SignDateController.text =
                          DateTime(value!.year, value!.month, value.day)
                              .toString()
                              .replaceAll("00:00:00.000", "");
                    });
                  },
                  decoration: InputDecoration(
                      hintText: 'Birth Date',
                      prefixIcon: Icon(Icons.calendar_month),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Colors.blue))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      //return 'حقل كلمه المرور فارغاً';
                      return 'Field is empty';
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SelectionMenu<String>(
                      initiallySelectedItemIndex: 0,
                      showSelectedItemAsTrigger: true,

                      itemsList: <String>['Male', 'Female'],
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
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                        );
                      },
                      // other Properties...
                    ),
                    SelectionMenu<String>(
                      initiallySelectedItemIndex: 0,
                      showSelectedItemAsTrigger: true,
                      itemsList: <String>['Parent', 'Doctor'],
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
                            style: TextStyle(
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
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () async {
                    if (SignKey.currentState!.validate()) {
                      if (UserID == null) {
                        // Call the user's CollectionReference to add a new user
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: SignupEmailController.text,
                                password: SignupPasswordController.text)
                            .then((value) {
                          User.doc(value.user!.uid).set({
                            'UserId': value.user!.uid,
                            'Verified': value.user!.emailVerified,
                            'FirstName': SignFirstNameController.text,
                            // John Doe
                            'LastName': SignLastNameController.text,
                            // Stokes and Sons
                            'BabyName': SignupbabyController.text,
                            'Email': SignupEmailController.text,
                            'Password': SignupPasswordController.text,
                            // 42
                            'Phone': SignPhoneController.text,
                            // 42
                            'BirthDate': SignDateController.text,
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
                                        FirstName: SignFirstNameController.text,
                                        LastName: SignLastNameController.text,
                                        BabyName: SignupbabyController.text,
                                        Email: SignupEmailController.text,
                                        Password: SignupPasswordController.text,
                                        Phone: SignPhoneController.text,
                                        BirthDate: SignDateController.text,
                                        Gender: gender,
                                        Account: client,
                                        UserId: value.user!.uid,
                                        verified: value.user!.emailVerified,
                                      )));
                        });
                      } else {
                        User.doc(UserID).update({
                          'FirstName': SignFirstNameController.text,
                          // John Doe
                          'LastName': SignLastNameController.text,
                          // Stokes and Sons
                          'BabyName': SignupbabyController.text,
                          'Email': SignupEmailController.text,
                          'Password': SignupPasswordController.text,
                          // 42
                          'Phone': SignPhoneController.text,
                          // 42
                          'BirthDate': SignDateController.text,
                          // 42
                          'Gender': gender,
                          // 42
                          'Account': client,
                          // 42
                        });
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileScreen()));
                      }
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      signed ? 'Save Edit' : 'Sign up',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: !signed,
                  child: Row(
                    children: [
                      Text(
                        'Have an account ?',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.normal),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ));
                          },
                          child: Text(
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
