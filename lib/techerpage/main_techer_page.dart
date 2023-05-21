import 'dart:async';

import 'package:ass1/service/Button_service.dart';
import 'package:ass1/service/List_history_service.dart';
import 'package:ass1/service/historyalldata_service.dart';
import 'package:ass1/service/threeline_service.dart';
import 'package:ass1/service/notification_teacher_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TecherPage extends StatefulWidget {
  final String name;
  final String role;
  final String email;
  const TecherPage(
      {super.key, required this.name, required this.role, required this.email});

  @override
  State<TecherPage> createState() => _TecherPageState();
}

class _TecherPageState extends State<TecherPage> {
  int _changeimg = 0;
  List<String> _imgUrlList = [];

  @override
  void initState() {
    super.initState();
    fetchData().then((imgUrls) {
      setState(() {
        _imgUrlList = imgUrls;
      });
    });

    Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _changeimg = (_changeimg + 1) % _imgUrlList.length;
      });
    });
  }

  Future<List<String>> fetchData() async {
    var value = await FirebaseFirestore.instance.collection('linkimg').get();
    List<String> imgUrlList = [];
    value.docs.forEach((element) {
      String link = element.data()['link'];
      imgUrlList.add(link);
    });
    return imgUrlList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.name}',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 131, 9, 0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => three_Line(
                              name: widget.name,
                              role: widget.role,
                              email: widget.email,
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.menu, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: 380,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 131, 9, 0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 300,
                        height: 200,
                        child: Image.network(
                          _imgUrlList[_changeimg],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButton(
                  imageurl:
                      'https://cdn.discordapp.com/attachments/697404744460795936/1082258543907962960/notification.png',
                  buttontext: 'PENDING APPROVE',
                  namepage: Noti_Techer(
                    name: widget.name,
                    role: widget.role,
                    email: widget.email,
                  ),
                ),
                MyButton(
                  imageurl:
                      'https://cdn.discordapp.com/attachments/697404744460795936/1082259632363417650/payment.png',
                  buttontext: 'HISTORY',
                  namepage: HistoryAllData(
                    name: widget.name,
                    email: widget.email,
                    role: widget.role,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            List_History(
              nametecher: widget.name,
              role: widget.role,
              email: widget.email,
            ),
          ],
        ),
      ),
    );
  }
}
