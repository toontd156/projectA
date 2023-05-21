import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String imageurl;
  final String buttontext;
  final Widget namepage;
  const MyButton({
    super.key,
    required this.imageurl,
    required this.buttontext,
    required this.namepage,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return namepage;
            }));
          },
          child: Container(
            width: 100,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 131, 9, 0),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: Colors.grey, blurRadius: 5, spreadRadius: 4),
              ],
            ),
            child: Center(
                child: Image.network(
              imageurl,
              width: 50,
              height: 50,
            )),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          '$buttontext',
          style: TextStyle(fontSize: 15),
        ),
      ],
    );
  }
}
