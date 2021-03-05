import 'dart:core';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import './blogcard.dart';
import './settings.dart' as settings;

class RecentWidget extends StatelessWidget {
// Widget buildRecentPosts() {
  Widget build(BuildContext context) {
    return Column(
      children: [
        // recent header
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
          color: Colors.white,
          child: Text("Recent Posts",
              style: GoogleFonts.pressStart2p(fontSize: 20, letterSpacing: 2)),
        ),
        // recent contents
        RecentListWidget(),
      ],
    );
  }
}

class RecentListWidget extends StatefulWidget {
  @override
  _RecentListWidgetState createState() => _RecentListWidgetState();
}

class _RecentListWidgetState extends State<RecentListWidget> {
  List<BlogCard> _cards = [];

  displaySummaries(List<BlogCard> cards) {
    _cards = cards;
    if (cards.length == 0) {
      _cards.add(BlogCard("", "Sample Post",
          "A sample post when no others are avaiable.", "1-Jan-21", ""));
    }
    setState(() {});
  }

  Future<List<BlogCard>> fetchSummaries() async {
    var response = await http.get(settings.getOrigin() + "/summaries?limit=4");

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

  @override
  initState() {
    super.initState();
    fetchSummaries().then(displaySummaries).onError((error, stackTrace) {
      displaySummaries([]);
    });
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: 200, right: 200),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: _cards,
        ));
  }
}
