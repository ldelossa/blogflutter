import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart' as path;

import './navbar.dart';
import './settings.dart' as settings;

class PostScreen extends StatefulWidget {
  final List<String> postPath;

  PostScreen(this.postPath);

  @override
  PostScreenState createState() => PostScreenState();
}

class PostScreenState extends State<PostScreen> {
  Widget mdWidget;
  double width;

  launchURL(String url) async {
    // if this is a relative path
    // add our origin
    var uri = Uri.parse(url);
    if (!uri.isAbsolute) {
      url = path.join(settings.getOrigin(), url);
    }

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  MarkdownStyleSheet buildTheme() {
    return MarkdownStyleSheet(
        code: GoogleFonts.firaMono(),
        blockSpacing: 30,
        textScaleFactor: 1.5,
        codeblockPadding: EdgeInsets.all(13),
        codeblockDecoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1,
              style: BorderStyle.solid,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(2))));
  }

  displayPost(String markdown) {
    try {
      mdWidget = Markdown(
        data: markdown,
        imageBuilder: (url, a, b) {
          return Image.network(settings.getOrigin() + "/" + url.toString());
        },
        onTapLink: (a, b, c) => {launchURL(b)},
        shrinkWrap: true,
        selectable: true,
        styleSheetTheme: MarkdownStyleSheetBaseTheme.material,
        styleSheet: buildTheme(),
        padding: EdgeInsets.all(30),
      );
    } catch (e) {
      print("failed to reneder markdown: $e");
      mdWidget = Text("Failed to get post");
    }
    setState(() {});
  }

  Future<String> fetchPost() async {
    var response =
        await http.get(settings.getOrigin() + "/posts/" + widget.postPath[0]);
    if (widget.postPath[0] == "test.post") {
      response = await http.get(
          'https://raw.githubusercontent.com/ldelossa/ldelossa-blog/master/src/routes/blog/_posts/allocation_optimization_in_go.md');
    }
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to fetch markdown');
    }
  }

  @override
  initState() {
    super.initState();
    fetchPost().then(displayPost).onError((error, stackTrace) {
      print("failed to fetch post $error");
      mdWidget = Text("Failed to get post");
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildNavBar(context, ""),
      body: Container(
          child: Center(
              child: FractionallySizedBox(
                  widthFactor: (width <= 1000) ? 1 : .5, child: mdWidget))),
    );
  }
}
