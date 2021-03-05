import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AvatarColumn extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          padding: EdgeInsets.only(bottom: 15, left: 15, right: 15, top: 50),
          child: CircleAvatar(radius: 65, child: Text("LD"))),
      Container(
          padding: EdgeInsets.all(10),
          child: Text("ldelossa.is",
              style: GoogleFonts.dancingScript(
                fontSize: 40,
                letterSpacing: 2,
              ))),
      Container(
          padding: EdgeInsets.only(top: 20, left: 10, right: 10),
          child: Text("A.\n\nProgramming.\n\nBlog.",
              style: GoogleFonts.pressStart2p(
                  fontSize: 18, letterSpacing: 2, wordSpacing: 2))),
    ]);
  }
}
