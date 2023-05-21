import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class add_image extends StatefulWidget {
  final name;
  final role;
  final email;
  const add_image({super.key, this.name, this.role, this.email});

  @override
  State<add_image> createState() => _add_imageState();
}

class _add_imageState extends State<add_image> {
  final LinkImg = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Image'),
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LinkImg.text != null && _isValidImageUrl(LinkImg.text)
                  ? Container(
                      width: 200,
                      height: 200,
                      child: Image.network(LinkImg.text),
                    )
                  : Placeholder(
                      fallbackHeight: 200,
                      fallbackWidth: 200,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: LinkImg,
                onChanged: (value) {
                  setState(() {
                    // อัปเดตสถานะและแสดงรูปภาพใน TextFormField หลังจากใส่ข้อมูล
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Link Image',
                  labelStyle: TextStyle(
                    color: Colors.red,
                  ),
                  prefixIcon: Icon(
                    Icons.image,
                    color: Colors.red,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                    borderRadius:
                        BorderRadius.circular(8.0), // ปรับความโค้งของกรอบ
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                onPressed: () {
                  setState(() {
                    FirebaseFirestore.instance.collection('linkimg').add({
                      'link': LinkImg.text,
                    });
                    print('success add data');
                  });
                  Navigator.pop(context);
                },
                child: Text('Add Image'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

bool _isValidImageUrl(String url) {
  final RegExp urlRegExp = RegExp(
    r'^(http(s?):\/\/)([^\s\/]+)(\/\S+)*(\.(?:jpg|jpeg|gif|png))$',
    caseSensitive: false,
    multiLine: false,
  );
  return urlRegExp.hasMatch(url);
}
