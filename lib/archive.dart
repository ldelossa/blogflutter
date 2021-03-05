import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:timelines/timelines.dart';
import './blogcard.dart';
import './settings.dart' as settings;
import 'package:google_fonts/google_fonts.dart';
import './navbar.dart';
import './main.dart';

class ArchiveScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildNavBar(context, "archive"),
      body: Archive(),
    );
  }
}

class Archive extends StatefulWidget {
  @override
  State<Archive> createState() => ArchiveState();
}

class ArchiveState extends State<Archive> {
  List<BlogCard> _cards = [];

  @override
  initState() {
    super.initState();
    fetchSummaries().then(displaySummaries).onError((error, stackTrace) {
      displaySummaries([]);
    });
  }

  displaySummaries(List<BlogCard> cards) {
    _cards = cards;
    if (cards.length == 0) {
      _cards.add(BlogCard("", "Sample Post",
          "A sample post when no others are avaiable.", "1-Jan-21", ""));
    }
    setState(() {});
  }

  Future<List<BlogCard>> fetchSummaries() async {
    var response = await http.get(settings.getOrigin() + "/summaries");
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<BlogCard> cards =
          l.map((model) => BlogCard.fromJson(model)).toList();
      return cards;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load posts');
    }
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: FixedTimeline.tileBuilder(
            builder: TimelineTileBuilder.connectedFromStyle(
                contentsAlign: ContentsAlign.basic,
                // date ListTiles on left
                oppositeContentsBuilder: (context, index) => ListTile(
                    visualDensity: VisualDensity.comfortable,
                    title: Text(_cards[index].date,
                        textAlign: TextAlign.end,
                        style: GoogleFonts.raleway(
                          color: Colors.black,
                          fontSize: 25,
                          letterSpacing: 2,
                        ))),
                // blog title and summary ListTiles on right
                contentsBuilder: (context, index) => ListTile(
                      contentPadding: EdgeInsets.all(5),
                      visualDensity: VisualDensity.comfortable,
                      title: Text(
                        _cards[index].title,
                        style: GoogleFonts.raleway(
                            color: Colors.black,
                            fontSize: 25,
                            letterSpacing: 1),
                      ),
                      subtitle: Text(
                        _cards[index].summary,
                        style: GoogleFonts.raleway(
                            color: Colors.black,
                            fontSize: 15,
                            letterSpacing: 1),
                      ),
                      onTap: () => {
                        router.navigateTo(
                            context, "/blog/" + _cards[index].postURL)
                      },
                    ),
                connectorStyleBuilder: (context, index) =>
                    ConnectorStyle.solidLine,
                indicatorStyleBuilder: (context, index) => IndicatorStyle.dot,
                itemCount: _cards.length)));
  }
}
