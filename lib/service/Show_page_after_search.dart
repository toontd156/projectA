// import 'package:ass1/service/history_page_from_search.dart';
// import 'package:flutter/material.dart';

// class Show_Teacher_after_Search extends StatefulWidget {
//   final List<Map<String, dynamic>> documents;
//   const Show_Teacher_after_Search({
//     super.key,
//     required this.documents,
//   });

//   @override
//   State<Show_Teacher_after_Search> createState() =>
//       _Show_Teacher_after_SearchState();
// }

// class _Show_Teacher_after_SearchState extends State<Show_Teacher_after_Search> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.red,
//           title: Text('Teacher'),
//         ),
//         body: SafeArea(
//           child: ListView.builder(
//             itemCount: widget.documents.length,
//             itemBuilder: (BuildContext context, int index) {
//               return GestureDetector(
//                 onTap: () {
//                   print(widget.documents[index]['name']);
//                   print(widget.documents[index]['lastname']);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => HisTory_Page_From_Search(
//                         Fname: widget.documents[index]['name'].toUpperCase(),
//                         Lname:
//                             widget.documents[index]['lastname'].toUpperCase(),
//                         emailT: widget.documents[index]['email'],
//                       ),
//                     ),
//                   );
//                 },
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(top: 20),
//                       child: Container(
//                           width: 350,
//                           height: 40,
//                           decoration: BoxDecoration(
//                             color: Colors.red,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     Text(
//                                       'FirstName : ${widget.documents[index]['name']}',
//                                       style: TextStyle(
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.white),
//                                     ),
//                                     Text(
//                                       'Surname : ${widget.documents[index]['lastname']}',
//                                       style: TextStyle(
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.white),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           )),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ));
//   }
// }
