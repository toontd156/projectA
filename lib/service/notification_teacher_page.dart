import 'package:ass1/service/Aceept_reject_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Noti_Techer extends StatefulWidget {
  final String name;
  final String role;
  final String email;
  const Noti_Techer(
      {Key? key, required this.name, required this.role, required this.email})
      : super(key: key);

  @override
  State<Noti_Techer> createState() => _Noti_TecherState();
}

class _Noti_TecherState extends State<Noti_Techer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pending approve'),
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('req')
                .where('EmailT', isEqualTo: widget.email)
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
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Ap_RJ(
                                                  idsql: req.id,
                                                  nametecher: widget.name,
                                                  namestudent: req['Student'],
                                                  time: formattedTime,
                                                  dates: formattedDate,
                                                )));
                                    // Ap_RJ(idsql: req.id);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        '${req['Student']}',
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
                                      // SizedBox(
                                      //   width: 20,
                                      //   height: 20,
                                      //   child: req['Status'] == 'pending'
                                      //       ? CircularProgressIndicator(
                                      //           color: Colors.white,
                                      //         )
                                      //       : Container(),
                                      // ),
                                      // GestureDetector(
                                      //   onTap: () {
                                      //     Navigator.push(
                                      //         context,
                                      //         MaterialPageRoute(
                                      //             builder: (context) => Ap_RJ(
                                      //                   titlepage: 'Accept',
                                      //                   idsql: req.id,
                                      //                   tyepActivecheck: 'accept',
                                      //                   nametecher: widget.name,
                                      //                   namestudent: req['Student'],
                                      //                   time: formattedTime,
                                      //                   dates: formattedDate,
                                      //                 )));
                                      //     // Ap_RJ(idsql: req.id);
                                      //   },
                                      //   child: Container(
                                      //     width: 20,
                                      //     height: 20,
                                      //     child: Icon(
                                      //       Icons.check,
                                      //       color: Colors.white,
                                      //     ),
                                      //   ),
                                      // ),
                                      // GestureDetector(
                                      //   onTap: () {
                                      //     Navigator.push(
                                      //         context,
                                      //         MaterialPageRoute(
                                      //             builder: (context) => Ap_RJ(
                                      //                   titlepage: 'Reject',
                                      //                   idsql: req.id,
                                      //                   tyepActivecheck: 'reject',
                                      //                   nametecher: widget.name,
                                      //                   namestudent: req['Student'],
                                      //                   time: formattedTime,
                                      //                   dates: formattedDate,
                                      //                 )));
                                      //   },
                                      //   child: Container(
                                      //     width: 20,
                                      //     height: 20,
                                      //     child: Icon(
                                      //       Icons.close,
                                      //       color: Colors.white,
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                )),
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
