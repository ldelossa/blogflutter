import 'package:flutter/material.dart';
import 'package:ant_icons/ant_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

import './main.dart';

AppBar buildNavBar(BuildContext context, String selected) {
  if (MediaQuery.of(context).size.width <= 1000) {
    return buildMobileAppBar(context, selected);
  } else {
    return buildDesktopAppBar(context, selected);
  }
}

AppBar buildDesktopAppBar(BuildContext context, String selected) {
  return AppBar(
    title: buildButtonBar(context, selected),
    leadingWidth: 200,
    automaticallyImplyLeading: false,
    leading: (selected == "home")
        ? Container()
        : Center(
            child: Text("ldelossa.is",
                style: GoogleFonts.dancingScript(
                  fontSize: 30,
                  letterSpacing: 2,
                  color: Colors.black,
                ))),
    actions: [
      buildOverlayButton("https://github.com/ldelossa",
          Icon(AntIcons.github, color: Colors.black)),
      buildOverlayButton("https://www.linkedin.com/in/louisdelossantos",
          Icon(AntIcons.linkedin, color: Colors.black)),
      buildOverlayButton("https://twitter.com/ldelossa_ld",
          Icon(AntIcons.twitter_circle, color: Colors.black))
    ],
    backgroundColor: Colors.white,
  );
}

AppBar buildMobileAppBar(BuildContext context, String selected) {
  return AppBar(
    // makes sure no back button is present.
    leading: null,
    automaticallyImplyLeading: false,
    title: buildButtonBar(context, selected),
    backgroundColor: Colors.white,
  );
}

ButtonBar buildButtonBar(BuildContext context, String selected) {
  var buttons = [
    TextButton(
        onPressed: () => router.navigateTo(context, "/home"),
        child: Text("Home",
            textAlign: TextAlign.end,
            style: GoogleFonts.raleway(
                color: Colors.black,
                fontSize: 25,
                letterSpacing: 4,
                decorationThickness: 1,
                decoration: (selected == "home")
                    ? TextDecoration.underline
                    : TextDecoration.none))),
    Container(
        width: 15,
    ),
    TextButton(
        onPressed: () => router.navigateTo(context, "/archive"),
        child: Text("Archive",
            textAlign: TextAlign.end,
            style: GoogleFonts.raleway(
                color: Colors.black,
                fontSize: 25,
                letterSpacing: 4,
                decorationThickness: 1,
                decoration: (selected == "archive")
                    ? TextDecoration.underline
                    : TextDecoration.none)))
  ];

  return ButtonBar(
    alignment: (MediaQuery.of(context).size.width <= 1000)
        ? MainAxisAlignment.center
        : MainAxisAlignment.end,
    children: buttons,
  );
}

Widget buildOverlayButton(String url, Icon icon) {
  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          launchURL(url);
        },
        child: Container(
            padding: EdgeInsets.only(bottom: 15, top: 12, left: 12, right: 12),
            child: FittedBox(
              child: icon,
            )),
      ));
}
