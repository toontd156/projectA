import 'package:projectA/service/History_page_from_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class List_History extends StatefulWidget {
  final String nametecher;
  final String role;
  final String email;
  const List_History(
      {super.key,
      required this.nametecher,
      required this.role,
      required this.email});

  @override
  State<List_History> createState() => _List_HistoryState();
}

class _List_HistoryState extends State<List_History> {
  var setcolors;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 400,
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [],
          ),
          if (widget.role == 'Teacher') ...[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 360,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Student',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'Time',
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    Text(
                      'Date',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('history')
                  .where('EmailT', isEqualTo: widget.email)
                  .snapshots(), // get data in sql
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final now = DateTime.now().toLocal();
                  final dayOfWeek = now.weekday;
                  final startOfWeek =
                      now.subtract(Duration(days: dayOfWeek - 1));
                  final endOfWeek = now.add(Duration(days: 7 - dayOfWeek));
                  final filteredData = snapshot.data!.docs.where((doc) {
                    final timestamp =
                        doc['Time'] as Timestamp; // get data in sql
                    final data = timestamp.toDate().toLocal();
                    return data.isAfter(startOfWeek) &&
                        data.isBefore(endOfWeek);
                  }).toList();
                  filteredData.sort((a, b) {
                    final aTime = (a['Time'] as Timestamp).toDate();
                    final bTime = (b['Time'] as Timestamp).toDate();
                    return bTime.compareTo(aTime);
                  });
                  if (filteredData.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          SizedBox(height: 100),
                          CircularProgressIndicator(
                            color: Colors.white,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'No History',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: filteredData.length,
                        itemBuilder: (context, index) {
                          final data = filteredData[index];
                          final timestamp = data['Time'] as Timestamp;
                          final time = timestamp.toDate();
                          final formattedTime =
                              DateFormat('HH:mm').format(time);
                          if (data['Status'] == 'accept') {
                            setcolors = Colors.green;
                          } else if (data['Status'] == 'reject') {
                            setcolors = Colors.red;
                          } else {
                            setcolors = Colors.yellow;
                          }
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 350,
                              height: 40,
                              decoration: BoxDecoration(
                                color: setcolors,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: 110,
                                    child: Expanded(
                                      child: Text(
                                        '${data['Student']}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 50,
                                    child: Expanded(
                                      child: Text(
                                        '${formattedTime}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 85,
                                    child: Expanded(
                                      child: Text(
                                        '${DateFormat('dd/MM/yyyy').format(time)}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                } else {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(height: 100),
                        CircularProgressIndicator(),
                        SizedBox(height: 10),
                        Text(
                          'Loading...',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  );
                }
              },
            )
          ] else if (widget.role == 'student') ...[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 360,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Teacher',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'Time',
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    Text(
                      'Date',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('history')
                  .where('EmailS', isEqualTo: widget.email)
                  .snapshots(), // get data in sql
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final now = DateTime.now().toLocal();
                  final dayOfWeek = now.weekday;
                  final startOfWeek =
                      now.subtract(Duration(days: dayOfWeek - 1));
                  final endOfWeek = now.add(Duration(days: 7 - dayOfWeek));
                  final filteredData = snapshot.data!.docs.where((doc) {
                    final timestamp =
                        doc['Time'] as Timestamp; // get data in sql
                    final data = timestamp.toDate().toLocal();
                    return data.isAfter(startOfWeek) &&
                        data.isBefore(endOfWeek);
                  }).toList();
                  filteredData.sort((a, b) {
                    final aTime = (a['Time'] as Timestamp).toDate();
                    final bTime = (b['Time'] as Timestamp).toDate();
                    return bTime.compareTo(aTime);
                  });
                  if (filteredData.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          SizedBox(height: 100),
                          CircularProgressIndicator(
                            color: Colors.white,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'No History',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: filteredData.length,
                        itemBuilder: (context, index) {
                          final data = filteredData[index];
                          final timestamp = data['Time'] as Timestamp;
                          final time = timestamp.toDate();
                          final formattedTime =
                              DateFormat('HH:mm').format(time);
                          if (data['Status'] == 'accept') {
                            setcolors = Colors.green;
                          } else if (data['Status'] == 'reject') {
                            setcolors = Colors.red;
                          } else {
                            setcolors = Colors.yellow;
                          }
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                FirebaseFirestore.instance
                                    .collection('history')
                                    .where('EmailT', isEqualTo: data['EmailT'])
                                    .where('EmailS', isEqualTo: data['EmailS'])
                                    .get()
                                    .then((value) {
                                  value.docs.forEach((element) {
                                    print(element['Teacher']);
                                    print(element['Student']);
                                    print(element['Recommand']);
                                    print(element['Status']);
                                    print(element['Time']);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            history_pafe_from_page(
                                                Tname: element['Teacher'],
                                                Sname: element['Student'],
                                                Recommand: element['Recommand'],
                                                SStaus: element['Status'],
                                                Tdate: formattedTime,
                                                Tday: DateFormat('dd/MM/yyyy')
                                                    .format(time)),
                                      ),
                                    );
                                  });
                                });
                              },
                              child: Container(
                                width: 350,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: setcolors,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      width: 110,
                                      child: Expanded(
                                        child: Text(
                                          '${data['Teacher']}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                      child: Expanded(
                                        child: Text(
                                          '${formattedTime}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 85,
                                      child: Expanded(
                                        child: Text(
                                          '${DateFormat('dd/MM/yyyy').format(time)}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                } else {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(height: 100),
                        CircularProgressIndicator(),
                        SizedBox(height: 10),
                        Text(
                          'Loading...',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  );
                }
              },
            )
          ] else if (widget.role == 'admin') ...[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 360,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Code',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'Use',
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    Text(
                      'Date',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('secretCode')
                  .snapshots(), // get data in sql
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final now = DateTime.now().toLocal();
                  final dayOfWeek = now.weekday;
                  final startOfWeek =
                      now.subtract(Duration(days: dayOfWeek - 1));
                  final endOfWeek = now.add(Duration(days: 7 - dayOfWeek));
                  final filteredData = snapshot.data!.docs.where((doc) {
                    final timestamp =
                        doc['Time'] as Timestamp; // get data in sql
                    final data = timestamp.toDate().toLocal();
                    return data.isAfter(startOfWeek) &&
                        data.isBefore(endOfWeek);
                  }).toList();
                  filteredData.sort((a, b) {
                    final aTime = (a['Time'] as Timestamp).toDate();
                    final bTime = (b['Time'] as Timestamp).toDate();
                    return bTime.compareTo(aTime);
                  });
                  if (filteredData.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          SizedBox(height: 100),
                          CircularProgressIndicator(
                            color: Colors.white,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'No History',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: filteredData.length,
                        itemBuilder: (context, index) {
                          final data = filteredData[index];
                          final timestamp = data['Time'] as Timestamp;
                          final time = timestamp.toDate();
                          final formattedTime =
                              DateFormat('HH:mm').format(time);
                          if (data['use'] == true) {
                            setcolors = Colors.red;
                          } else if (data['use'] == false) {
                            setcolors = Colors.green;
                          }
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 350,
                              height: 40,
                              decoration: BoxDecoration(
                                color: setcolors,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: 110,
                                    child: Expanded(
                                      child: Text(
                                        '${data['code']}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 50,
                                    child: Expanded(
                                      child: Text(
                                        '${data['use']}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 85,
                                    child: Expanded(
                                      child: Text(
                                        '${DateFormat('dd/MM/yyyy').format(time)}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                } else {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(height: 100),
                        CircularProgressIndicator(),
                        SizedBox(height: 10),
                        Text(
                          'Loading...',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  );
                }
              },
            )
          ]
        ],
      ),
    );
  }
}
