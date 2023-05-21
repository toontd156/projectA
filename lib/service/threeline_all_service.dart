import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../models/rive_asset.dart';

class infoCardPerson extends StatelessWidget {
  final String name, role;
  const infoCardPerson({
    super.key,
    required this.name,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(
          CupertinoIcons.person,
          color: Colors.red,
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        role,
        style: const TextStyle(
          color: Color.fromARGB(255, 131, 9, 0),
        ),
      ),
    );
  }
}

class CardLogout extends StatelessWidget {
  final String name;

  const CardLogout({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(
          CupertinoIcons.back,
          color: Colors.red,
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

class CardBack extends StatelessWidget {
  final String name;

  const CardBack({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(
          CupertinoIcons.backward_end,
          color: Colors.red,
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

class SideMenu extends StatelessWidget {
  const SideMenu({
    super.key,
    required this.menu,
    required this.press,
    required this.riveonInit,
    required this.isActived,
  });

  final RiveAsset menu;
  final VoidCallback press;
  final ValueChanged<Artboard> riveonInit;
  final bool isActived;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24),
          child: Divider(
            color: Colors.white24,
            height: 1,
          ),
        ),
        ListTile(
          onTap: () {},
          title: Text(
            menu.title,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
