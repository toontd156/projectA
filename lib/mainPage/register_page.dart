import 'package:ass1/mainPage/login_main_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final _sceretCode = TextEditingController();
  final _FirstName = TextEditingController();
  final _LastName = TextEditingController();
  String datasql = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Register'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _idController,
                decoration: InputDecoration(
                  labelText: 'email',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                    labelText: 'Password', prefixIcon: Icon(Icons.lock)),
                obscureText: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _FirstName,
                decoration: InputDecoration(
                    labelText: 'FirstName', prefixIcon: Icon(Icons.person)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _LastName,
                decoration: InputDecoration(
                    labelText: 'LastName', prefixIcon: Icon(Icons.person)),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _sceretCode,
                  decoration: InputDecoration(
                      labelText: 'Code (Dont Have Dont Input)',
                      prefixIcon: Icon(Icons.lock)),
                  obscureText: true,
                )),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              onPressed: () async {
                // if (_idController.text.isEmpty) {
                //   setState(() {
                //     datasql = 'Please enter your email';
                //   });
                //   return;
                // }
                // if (_passwordController.text.isEmpty) {
                //   setState(() {
                //     datasql = 'Please enter your password';
                //   });
                //   return;
                // }
                try {
                  final user = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: _idController.text,
                    password: _passwordController.text,
                  );
                  // Navigate to the home page if the registration is successful
                  if (_sceretCode.text.isNotEmpty) {
                    var SCT = _sceretCode.text.toUpperCase();
                    FirebaseFirestore.instance
                        .collection('secretCode')
                        .get()
                        .then((QuerySnapshot querySnapshot) {
                      querySnapshot.docs.forEach((doc) {
                        if (doc['Code'] == SCT) {
                          if (doc['use'] == true) {
                            setState(() {
                              datasql = 'The code is already in use.';
                            });
                            return;
                          }
                          final usertoFirestore = FirebaseFirestore.instance
                              .collection('users')
                              .doc(user.user!.uid)
                              .set({
                            'email': _idController.text,
                            'role': 'Teacher',
                            'name': _FirstName.text.toUpperCase(),
                            'lastname': _LastName.text.toUpperCase(),
                          });
                          FirebaseFirestore.instance
                              .collection('secretCode')
                              .doc(doc.id)
                              .update({
                            'use': true,
                          });
                        } else {
                          setState(() {
                            datasql = 'The code is incorrect.';
                          });
                        }
                      });
                    });
                  } else {
                    final usertoFirestore = FirebaseFirestore.instance
                        .collection('users')
                        .doc(user.user!.uid)
                        .set({
                      'email': _idController.text,
                      'role': 'student',
                      'name': _FirstName.text.toUpperCase(),
                      'lastname': _LastName.text.toUpperCase(),
                    });
                  }
                  if (user != null) {
                    Navigator.pop(context);
                  }
                } catch (e) {
                  // Show an error message if the registration fails
                  setState(() {
                    datasql = 'The email is already in use by another account.';
                  });
                }
              },
              child: Text('Register'),
            ),
            Text(datasql),
          ],
        ),
      ),
    );
  }
}
