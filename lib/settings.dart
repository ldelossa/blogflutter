import 'package:flutter/material.dart';
import './navbar.dart';
import './main.dart';
import 'package:path/path.dart' as path;

String origin = "";

String getOrigin() {
  if (origin != "") {
    return origin;
  }
  var loc = path.current;
  var uri = Uri.parse(loc);
  return uri.origin;
}

class SettingsScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNavBar(context, ""),
      body: Settings(),
    );
  }
}

class Settings extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 400, right: 400),
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: origin,
          ),
          onSubmitted: (string) {
            try {
              Uri.parse(string);
            } catch (e) {
              print("clould not parse server $e");
            }
            origin = string;
            router.navigateTo(context, "home");
          },
        ));
  }
}
