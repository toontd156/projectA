import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:time_interval_picker/time_interval_picker.dart';

class Add_Requtes_Teacher extends StatefulWidget {
  final String Fname;
  final String Lname;
  final String emailS;
  final String emailT;
  final String nameS;
  const Add_Requtes_Teacher({
    super.key,
    required this.Fname,
    required this.Lname,
    required this.emailS,
    required this.emailT,
    required this.nameS,
  });

  @override
  State<Add_Requtes_Teacher> createState() => _Add_Requtes_TeacherState();
}

class _Add_Requtes_TeacherState extends State<Add_Requtes_Teacher> {
  DateTime dateTime = DateTime(2023, 12, 24, 5, 30);
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _timeControllerTwo = TextEditingController();
  var SelectDay;
  var SelectMonth;
  var SelectYear;
  var SelectStartTime;
  var SelectEndTime;
  Timestamp? selectedStartTime; // เพิ่มตัวแปรในส่วนด้านบน
  Timestamp? selectedEndTime; // เพิ่มตัวแปรในส่วนด้านบน
  @override
  Widget build(BuildContext context) {
    final hours = dateTime.hour.toString().padLeft(2);
    final minutes = dateTime.minute.toString().padLeft(2);
    print(widget.emailS);
    print(widget.emailT);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Add Requtes Teacher'),
      ),
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 420,
              height: 325,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 400,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: Column(
                        children: [
                          Text(
                            'Date',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          DropdownDatePicker(
                            inputDecoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 0.5),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ), // optional
                            isDropdownHideUnderline: true, // optional
                            isFormValidator: true, // optional
                            startYear: 2023, // optional
                            endYear: 2025, // optional
                            width: 5, // optional
                            // selectedDay: 14, // optional
                            selectedMonth: 05, // optional
                            selectedYear: 2023, // optional
                            onChangedDay: (value) =>
                                SelectDay = value.toString(),
                            onChangedMonth: (value) =>
                                SelectMonth = value.toString(),
                            onChangedYear: (value) =>
                                SelectYear = value.toString(),
                            //boxDecoration: BoxDecoration(
                            // border: Border.all(color: Colors.grey, width: 1.0)), // optional
                            // showDay: false,// optional
                            dayFlex: 2, // optional
                            // locale: "zh_CN",// optional
                            // hintDay: 'Day', // optional
                            // hintMonth: 'Month', // optional
                            // hintYear: 'Year', // optional
                            // hintTextStyle: TextStyle(color: Colors.grey), // optional
                          ),
                        ],
                      )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 400,
                      height: 140,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: Column(
                        children: [
                          Text(
                            'Time',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TimeIntervalPicker(
                            endLimit: null,
                            startLimit: null,
                            onChanged: (DateTime? startTime, DateTime? endTime,
                                bool isAllDay) {
                              if (startTime != null) {
                                final selectedDate = DateTime(
                                  int.tryParse(SelectYear ?? '') ?? 0,
                                  int.tryParse(SelectMonth ?? '') ?? 0,
                                  int.tryParse(SelectDay ?? '') ?? 0,
                                );
                                final newStartTime = DateTime(
                                  selectedDate.year,
                                  selectedDate.month,
                                  selectedDate.day,
                                  startTime.hour,
                                  startTime.minute,
                                );
                                setState(() {
                                  selectedStartTime =
                                      Timestamp.fromDate(newStartTime);
                                });
                              }
                              if (endTime != null) {
                                final selectedDate = DateTime(
                                  int.tryParse(SelectYear ?? '') ?? 0,
                                  int.tryParse(SelectMonth ?? '') ?? 0,
                                  int.tryParse(SelectDay ?? '') ?? 0,
                                );
                                final newEndTime = DateTime(
                                  selectedDate.year,
                                  selectedDate.month,
                                  selectedDate.day,
                                  endTime.hour,
                                  endTime.minute,
                                );
                                setState(() {
                                  selectedEndTime =
                                      Timestamp.fromDate(newEndTime);
                                });
                              }
                            },
                          ),
                        ],
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              onPressed: () {
                setState(() {
                  FirebaseFirestore.instance
                      .collection('req')
                      .add({
                        'Student': widget.nameS.toString(),
                        'Teacher': widget.Fname.toString(),
                        'Time': selectedStartTime,
                        'EndTime': selectedEndTime,
                        'Status': 'pending',
                        'EmailS': widget.emailS.toString(),
                        'EmailT': widget.emailT.toString(),
                      }) // <-- Doc ID where data should be updated.
                      .then((_) => print('Updated'))
                      .catchError((error) => print('Update failed: $error'));
                  Navigator.pop(context);
                });
              },
              child: Text('Add')),
        ]),
      ),
    );
  }
}
