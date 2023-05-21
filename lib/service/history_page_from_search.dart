import 'package:projectA/service/Add_Requtes_Teacher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class HisTory_Page_From_Search extends StatefulWidget {
  final String Fname;
  final String Lname;
  final String emailS;
  final String emailT;
  final String nameS;
  const HisTory_Page_From_Search({
    super.key,
    required this.Fname,
    required this.Lname,
    required this.emailS,
    required this.emailT,
    required this.nameS,
  });

  @override
  State<HisTory_Page_From_Search> createState() =>
      _HisTory_Page_From_SearchState();
}

class _HisTory_Page_From_SearchState extends State<HisTory_Page_From_Search> {
  @override
  var setcolors;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('History Techers'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 131, 9, 0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('history')
                              .where('EmailT', isEqualTo: widget.emailT)
                              .snapshots(), // get data in sql
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final now = DateTime.now().toLocal();
                              final dayOfWeek = now.weekday;
                              final startOfWeek =
                                  now.subtract(Duration(days: dayOfWeek - 1));
                              final endOfWeek =
                                  now.add(Duration(days: 7 - dayOfWeek));
                              final filteredData =
                                  snapshot.data!.docs.where((doc) {
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
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
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
                                      final timestamp =
                                          data['Time'] as Timestamp;
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
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        )
                      ],
                    )),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Add_Requtes_Teacher(
                              Fname: widget.Fname,
                              Lname: widget.Lname,
                              emailS: widget.emailS,
                              emailT: widget.emailT,
                              nameS: widget.nameS,
                            )));
              },
              child: Text('ADD REQUTES'),
            )
          ],
        ),
      ),
    );
  }
}
