import 'package:flutter/material.dart';
import './avatarcolumn.dart';
import './about.dart';
import './recent.dart';
import './navbar.dart';

class HomeScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width <= 1000) {
      return buildMobileScaffold(context);
    } else {
      return buildDesktopScaffold(context);
    }
  }
}

Scaffold buildDesktopScaffold(BuildContext context) {
  return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildNavBar(context, "home"),
      body: SingleChildScrollView(
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
            // avatar column layout
            Container(
              padding: EdgeInsets.only(left: 50),
              color: Colors.white,
              child: AvatarColumn(),
            ),
            Container(
              padding: EdgeInsets.only(right: 50),
            ),
            Expanded(
                // main contents layout
                child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 50),
                ),
                // about section
                AboutWidget(),
                Container(
                  padding: EdgeInsets.only(top: 20),
                ),
                // recent blog posts section
                RecentWidget(),
              ],
            ))
          ])));
}

Scaffold buildMobileScaffold(BuildContext context) {
  return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildNavBar(context, "home"),
      body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
            // avatar column layout
            Container(
              alignment: Alignment.center,
              color: Colors.white,
              child: AvatarColumn(),
              padding: EdgeInsets.only(bottom: 40),
            ),
            Divider(
              color: Colors.grey[300],
              thickness: 3,
            ),
            Container(
                padding: EdgeInsets.only(top: 40),
                // main contents layout
                child: Column(
                  children: [
                    // about section
                    AboutWidget(),
                    Container(
                      padding: EdgeInsets.only(top: 30),
                    ),
                    // recent blog posts section
                    RecentWidget(),
                  ],
                ))
          ])));
}
