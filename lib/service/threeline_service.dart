import 'package:projectA/mainPage/login_main_page.dart';
import 'package:projectA/models/rive_asset.dart';
import 'package:projectA/service/threeline_all_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class three_Line extends StatefulWidget {
  final String email;
  final String name;
  final String role;
  const three_Line(
      {super.key, required this.email, required this.name, required this.role});

  @override
  State<three_Line> createState() => _three_LineState();
}

class _three_LineState extends State<three_Line> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.red,
        child: SafeArea(
          child: Column(
            children: [
              infoCardPerson(
                name: widget.name,
                role: widget.role,
              ),
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 32, bottom: 16),
                    child: Divider(
                      color: Colors.white,
                      height: 1,
                    ),
                  ),
                  Text(
                    "option".toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white70),
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CardBack(
                      name: 'Back',
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 32, bottom: 16),
                    child: Divider(
                      color: Colors.white,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) =>
                            false, // ปิดหน้าจอปัจจุบันและกลับไปยังหน้าแรก
                      );
                    },
                    child: CardLogout(
                      name: 'Logout',
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
