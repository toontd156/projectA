import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Ap_RJ extends StatefulWidget {
  final String idsql;
  final String nametecher;
  final String namestudent;
  final String time;
  final String dates;
  const Ap_RJ({
    super.key,
    required this.idsql,
    required this.nametecher,
    required this.namestudent,
    required this.time,
    required this.dates,
  });

  @override
  State<Ap_RJ> createState() => _Ap_RJState();
}

class _Ap_RJState extends State<Ap_RJ> {
  final recommand = TextEditingController();
  bool? _isCheckedAccept = false;
  bool? _isCheckedReject = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Accpet Or Reject'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    width: 450,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 131, 9, 0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Student : ${widget.namestudent}',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Time : ${widget.time}',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Date : ${widget.dates}',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    maxLines: 5,
                    controller: recommand,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'บอกอะไรสักอย่างกับนักศึกษา',
                      labelStyle: TextStyle(color: Colors.red),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon:
                          Icon(Icons.person, color: Colors.red, size: 30),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CheckboxListTile(
                    title: Text('Accept'),
                    value: _isCheckedAccept,
                    onChanged: (bool? value) {
                      setState(() {
                        _isCheckedAccept = value!;
                      });
                    },
                    activeColor: Colors.red,
                    checkColor: Colors.white,
                  ),
                  CheckboxListTile(
                    title: Text('Reject'),
                    value: _isCheckedReject,
                    onChanged: (bool? value) {
                      setState(() {
                        _isCheckedReject = value!;
                      });
                    },
                    activeColor: Colors.red,
                    checkColor: Colors.white,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      onPressed: () {
                        if (_isCheckedReject == true &&
                            _isCheckedAccept == true) {
                          return;
                        }

                        if (_isCheckedAccept == true &&
                            _isCheckedReject == false) {
                          FirebaseFirestore.instance
                              .collection('req')
                              .doc(widget.idsql)
                              .update({
                            'Status': 'accept',
                            'Recommand': recommand.text
                          });

                          FirebaseFirestore.instance.collection('history').add({
                            'Student': widget.namestudent,
                            'Teacher': widget.nametecher,
                            'Status': 'accept',
                            'Recommand': recommand.text,
                            'Time': DateTime.now()
                          }).then((value) => {print('success')});
                          Navigator.pop(context);
                        } else if (_isCheckedReject == true &&
                            _isCheckedAccept == false) {
                          if (recommand.text == '') {
                            return;
                          }
                          FirebaseFirestore.instance
                              .collection('req')
                              .doc(widget.idsql)
                              .update({
                            'Status': 'reject',
                            'Recommand': recommand.text
                          });
                          // FirebaseFirestore.instance
                          //     .collection('history')
                          //     .doc(widget.idsql)
                          //     .set({
                          //   'Student': widget.namestudent,
                          //   'Teacher': widget.nametecher,
                          //   'Status': 'reject',
                          //   'Recommand': recommand.text,
                          //   'Time': DateTime.now()
                          // });
                          FirebaseFirestore.instance.collection('history').add({
                            'Student': widget.namestudent,
                            'Teacher': widget.nametecher,
                            'Status': 'reject',
                            'Recommand': recommand.text,
                            'Time': DateTime.now()
                          }).then((value) => {print('reject')});
                          Navigator.pop(context);
                        } else {
                          return;
                        }
                      },
                      child: Text('Submit'),
                    ),
                  )
                  // ElevatedButton(
                  //   style: ButtonStyle(
                  //     backgroundColor: MaterialStateProperty.all(Colors.red),
                  //   ),
                  //   onPressed: () {
                  //     if (widget.tyepActivecheck == 'reject') {
                  //       FirebaseFirestore.instance
                  //           .collection('req')
                  //           .doc(widget.idsql)
                  //           .update({
                  //         'Status': widget.tyepActivecheck,
                  //         'Recommand': recommand.text
                  //       });
                  //       FirebaseFirestore.instance
                  //           .collection('history')
                  //           .doc(widget.idsql)
                  //           .set({
                  //         'Student': widget.namestudent,
                  //         'Teacher': widget.nametecher,
                  //         'Status': widget.tyepActivecheck,
                  //         'Recommand': recommand.text,
                  //         'Time': DateTime.now()
                  //       });
                  //       Navigator.pop(context);
                  //     } else if (widget.tyepActivecheck == 'accept') {
                  //       FirebaseFirestore.instance
                  //           .collection('req')
                  //           .doc(widget.idsql)
                  //           .update({
                  //         'Status': widget.tyepActivecheck,
                  //         'Recommand': recommand.text
                  //       });
                  //       FirebaseFirestore.instance
                  //           .collection('history')
                  //           .doc(widget.idsql)
                  //           .set({
                  //         'Student': widget.namestudent,
                  //         'Teacher': widget.nametecher,
                  //         'Status': widget.tyepActivecheck,
                  //         'Recommand': recommand.text,
                  //         'Time': DateTime.now()
                  //       });

                  //       Navigator.pop(context);
                  //     }
                  //   },
                  //   child: null,
                  //   // child: Text(widget.tyepActivecheck.toUpperCase()),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
