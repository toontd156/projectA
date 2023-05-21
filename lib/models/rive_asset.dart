import 'package:rive/rive.dart';

class RiveAsset {
  final String artboard, stateMachineName, title, src;
  late SMIBool? input;

  RiveAsset(this.src,
      {required this.artboard,
      required this.stateMachineName,
      required this.title,
      this.input});

  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAsset> sideMenus = [
  RiveAsset("assets/animation/icons.riv",
      artboard: "HOME", stateMachineName: "HOME_Interactivity", title: "Home"),
  RiveAsset("assets/animation/icons.riv",
      artboard: "BELL",
      stateMachineName: "BELL_Interactivity",
      title: "Notifications"),
  RiveAsset("assets/animation/icons.riv",
      artboard: "USER",
      stateMachineName: "USER_Interactivity",
      title: "Profile"),
  RiveAsset("assets/animation/icons.riv",
      artboard: "RELOAD",
      stateMachineName: "RELOAD_Interactivity",
      title: "Back"),
];
