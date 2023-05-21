import 'package:ass1/service/Aceept_reject_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Noti_Student extends StatefulWidget {
  final String name;
  final String role;
  final String email;
  const Noti_Student(
      {Key? key, required this.name, required this.role, required this.email})
      : super(key: key);

  @override
  State<Noti_Student> createState() => _Noti_StudentState();
}

class _Noti_StudentState extends State<Noti_Student> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pending appove'),
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('req')
                .where('EmailS', isEqualTo: widget.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: snapshot.data!.docs.map((req) {
                    final timestamp = req['Time'] as Timestamp;
                    final time = timestamp.toDate();
                    final formattedTime = DateFormat('HH:mm').format(time);
                    final formattedDate = DateFormat('dd/MM/yyyy').format(time);
                    return Card(
                      child: Column(
                        children: [
                          if (req['Status'] == 'pending') ...[
                            Container(
                              width: 422,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 131, 9, 0),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    '${req['Teacher']}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '${formattedTime}',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  Text(
                                    '${formattedDate}',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  }).toList(),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
