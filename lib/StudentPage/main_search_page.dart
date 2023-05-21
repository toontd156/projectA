import 'dart:math';

import 'package:projectA/StudentPage/main_student_page.dart';
import 'package:projectA/service/Show_page_after_search.dart';
import 'package:projectA/service/history_page_from_search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class searchpage extends StatefulWidget {
  final String name;
  final String email;
  const searchpage({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  State<searchpage> createState() => _searchpageState();
}

class _searchpageState extends State<searchpage> {
  final NameTeacher = TextEditingController();
  String name = "";
  List<Map<String, dynamic>> data = [];
  addData() async {
    for (var element in data) {
      FirebaseFirestore.instance.collection('users').add(element);
    }
    print('success add data');
  }

  @override
  void initState() {
    super.initState();
    addData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Search Page'),
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: SizedBox(
                  width: 360,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter a search Teacher',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                  ),
                ),
              ),
              //  FirebaseFirestore.instance
              //         .collection('users')
              //         .where('name', isEqualTo: NameTeacher.text.toUpperCase())
              //         .where('role', isEqualTo: 'Teacher')
              //         .get()
              //         .then((QuerySnapshot querySnapshot) {

              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .where('role', isEqualTo: 'Teacher')
                    .snapshots(),
                builder: (context, snapshot) {
                  return (snapshot.connectionState == ConnectionState.waiting)
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data!.docs[index].data()
                                as Map<String, dynamic>;

                            if (data['name']
                                .toString()
                                .toUpperCase()
                                .contains(name.toUpperCase())) {
                              return GestureDetector(
                                onTap: () {
                                  print(data['name']);
                                  print(data['lastname']);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HisTory_Page_From_Search(
                                              Fname: data['name'].toUpperCase(),
                                              Lname: data['lastname']
                                                  .toUpperCase(),
                                              emailS: widget.email,
                                              emailT: data['email'],
                                              nameS: widget.name,
                                            )),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Container(
                                          width: 350,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Icon(
                                                      Icons.search,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      data['name']
                                                          .toString()
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      data['lastname']
                                                          .toString()
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        );
                },
              )),
            ],
          ),
        ));
  }
}
