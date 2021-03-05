import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(children: [
      // About eader
      Container(
        padding: EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
        alignment: Alignment.centerLeft,
        color: Colors.white,
        child: Text("About",
            style: GoogleFonts.pressStart2p(fontSize: 20, letterSpacing: 2)),
      ),
      // About contents
      buildAboutContents()
    ]);
  }
}

Widget buildAboutContents() {
  return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
      child: Text(
          "My name is Louis DeLosSantos and I'm currently an engineer at Red Hat.\n\nMy interests stretch across infrastructure, systems programming, networking, distributed systems and application architectures.\n\nI've worked at a lot of places, built a lot of things, and enjoy sharing my experience along the way.",
          style: GoogleFonts.raleway(
            fontSize: 25,
            letterSpacing: 2,
          )));
}
