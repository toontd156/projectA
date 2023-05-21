import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:random_string/random_string.dart';

class add_code extends StatefulWidget {
  const add_code({super.key});

  @override
  State<add_code> createState() => _add_codeState();
}

class _add_codeState extends State<add_code> {
  String generatedCode = '';

  @override
  void initState() {
    super.initState();
    generatedCode = randomAlpha(4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CREATE CODE'),
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Generated Code: $generatedCode',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              onPressed: () {
                FirebaseFirestore.instance.collection('secretCode').add({
                  'code': generatedCode,
                  'use': false,
                  'Time': DateTime.now(),
                }).then((value) {
                  print('success add code to database ');
                });
                Navigator.pop(context);
              },
              child: Text('CREATE'),
            ),
          ],
        ),
      ),
    );
  }
}
