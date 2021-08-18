import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import './main.dart';
import './settings.dart' as settings;
import 'package:intl/intl.dart';

class BlogCard extends StatelessWidget {
  final String imgURL;
  final String title;
  final String summary;
  final String date;
  final String postURL;

  final width = 375.0;
  final height = 400.0;
  final borderRadius = BorderRadius.all(Radius.circular(30));

  BlogCard(this.imgURL, this.title, this.summary, this.date, this.postURL);

  factory BlogCard.fromJson(Map<String, dynamic> json) {
    var formatter = DateFormat('dd-MMM-yyyy');
    String date;
    try {
      date = formatter.format(DateTime.parse(json['date']));
    } catch (e) {
      print("$e");
    }
    return BlogCard(json["hero"], json['title'], json['summary'],
        date.toString(), json['path']);
  }

  launchURL(String url) async {
    url = settings.getOrigin() + url;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.grey[300],
      borderRadius: BorderRadius.all(Radius.circular(20)),
      onTap: () => {router.navigateTo(context, "/blog/posts/" + postURL)},
      child: Container(width: width, height: height, child: buildCard()),
    );
  }

  Widget buildCard() {
    // set image or provide default.
    var cardImg = Image.asset("images/stock-blog-hero-2.png");
    if (imgURL != "") {
      try {
        cardImg = Image.network(path.join(settings.getOrigin(), imgURL));
      } catch (e) {
        print("failed to grab network image for BlogCard: $e");
      }
    }

    return Card(
        margin: EdgeInsets.all(10),
        elevation: 9,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        child: Stack(children: [
          // image layer
          Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
              ),
              width: width,
              height: height,
              // this fitted box's parents need to have well defined
              // w/h so the widget can figureout how to box fill it.
              child: FittedBox(
                child: ClipRRect(
                  borderRadius: borderRadius,
                  child: cardImg,
                ),
                fit: BoxFit.fill,
              )),
          // opacity overlay so text always looks OK.
          Opacity(
            opacity: .6,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black,
                  // why does border radius need to be half of all others to
                  // fit ontop correctly?
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              width: width,
              height: height,
            ),
          ),
          Column(children: [
            // date
            Expanded(
              flex: 1,
              child: Container(
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.topRight,
                  child: Text(date,
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 15,
                        letterSpacing: 1,
                      ))),
            ),
            // title
            Expanded(
              flex: 3,
              child: Container(
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.center,
                  child: Text(title,
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 20,
                        letterSpacing: 1,
                      ))),
            ),
            // summary
            Expanded(
              flex: 2,
              child: Container(
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.center,
                  child: Text(summary,
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 15,
                        letterSpacing: 1,
                      ))),
            ),
          ])
        ]));
  }
}
