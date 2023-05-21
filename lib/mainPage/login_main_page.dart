import 'package:ass1/adminPage/main_admin_page.dart';
import 'package:ass1/mainPage/register_page.dart';
import 'package:ass1/techerpage/main_techer_page.dart';
import 'package:ass1/StudentPage/main_student_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

String textuser = '';

class _LoginPageState extends State<LoginPage> {
  final username = TextEditingController();
  final password = TextEditingController();
  @override
  void initState() {
    username.text = 'admin2@gmail.com';
    password.text = '123456';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 131, 9, 0),
        title: Text('MFU Login'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            child: Image.network(// img mfu
                'https://archives.mfu.ac.th/wp-content/uploads/2019/06/Mae-Fah-Luang-University-2.png'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              // ช่องกรอก id
              controller: username,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'ID Player',
                prefixIcon: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              // ช่องกรอก password
              controller: password,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return RegisterPage();
              }));
            },
            child: Text('Register',
                style: TextStyle(color: Colors.red)), // ลิงค์ไปหน้า register
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  if (username.text == '' || password.text == '') {
                    setState(() {
                      textuser = 'Please fill in the blank';
                      Future.delayed(Duration(seconds: 3), () {
                        setState(() {
                          textuser = '';
                        });
                      });
                    });
                    return;
                  }
                  try {
                    final user = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: username.text, password: password.text);

                    if (user != null) {
                      print('success');
                      final datauser = await FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.user!.uid)
                          .get();
                      if (datauser.data()!['role'] == 'student') {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => mainpage(
                                      name: datauser.data()!['name'],
                                      role: datauser.data()!['role'],
                                      email: username.text,
                                    )),
                            (route) => false);
                      } else if (datauser.data()!['role'] == 'Teacher') {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TecherPage(
                                      name: datauser.data()!['name'],
                                      role: datauser.data()!['role'],
                                      email: username.text,
                                    )),
                            (route) => false);
                      } else if (datauser.data()!['role'] == 'admin') {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminPage(
                                      name: datauser.data()!['name'],
                                      role: datauser.data()!['role'],
                                      email: username.text,
                                    )),
                            (route) => false);
                      }
                    } else {
                      print('fail');
                    }
                  } catch (e) {
                    print(e);
                    setState(() {
                      textuser = 'Login Fail';
                      Future.delayed(Duration(seconds: 3), () {
                        setState(() {
                          textuser = '';
                        });
                      });
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text('Login'),
              )),
          Text(
            textuser,
            style: TextStyle(color: Colors.red),
          )
        ],
      ),
    );
  }
}
