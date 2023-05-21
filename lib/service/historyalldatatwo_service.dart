import 'package:ass1/service/History_page_from_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

class HistoryAllData2 extends StatefulWidget {
  final String name;
  final String email;
  final String role;
  const HistoryAllData2(
      {super.key, required this.name, required this.email, required this.role});

  @override
  State<HistoryAllData2> createState() => _HistoryAllData2State();
}

class _HistoryAllData2State extends State<HistoryAllData2> {
  var setcolors;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('History All Data In 7 Day Last'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
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
                            'No History Today',
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
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    FirebaseFirestore.instance
                                        .collection('history')
                                        .where('EmailT',
                                            isEqualTo: data['EmailT'])
                                        .where('EmailS',
                                            isEqualTo: data['EmailS'])
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
                                                    Recommand:
                                                        element['Recommand'],
                                                    SStaus: element['Status'],
                                                    Tdate: formattedTime,
                                                    Tday:
                                                        DateFormat('dd/MM/yyyy')
                                                            .format(time)),
                                          ),
                                        );
                                      });
                                    });
                                  },
                                  child: Container(
                                    width: 410,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: setcolors,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 100,
                                            child: Expanded(
                                              child: Text(
                                                'T. ${data['Teacher']}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 90,
                                            child: Expanded(
                                              child: Text(
                                                'S. ${data['Student']}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 100,
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
                                            width: 100,
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
                                ),
                              ),
                            ],
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
          ],
        ),
      ),
    );
  }
}
