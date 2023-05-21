import 'package:flutter/material.dart';

class history_pafe_from_page extends StatefulWidget {
  final String Tname;
  final String Sname;
  final String Tdate;
  final String SStaus;
  final String Recommand;
  final String Tday;
  const history_pafe_from_page(
      {super.key,
      required this.Tname,
      required this.Sname,
      required this.Tdate,
      required this.SStaus,
      required this.Recommand,
      required this.Tday});

  @override
  State<history_pafe_from_page> createState() => _history_pafe_from_pageState();
}

class _history_pafe_from_pageState extends State<history_pafe_from_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('History Page'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  width: 400,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'DATE : ${widget.Tday}',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'TIME : ${widget.Tdate}',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                'STATUS : ${widget.SStaus}',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                'RECOMMENT : ${widget.Recommand}',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'TEACHER : ${widget.Tname}',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
