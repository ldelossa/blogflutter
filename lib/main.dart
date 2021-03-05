import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './homescreen.dart';
import './postscreen.dart';
import './settings.dart';
import './archive.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(App());
}

final router = FluroRouter();

// routes
var homeHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return HomeScreen();
});

var postHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return PostScreen(params["path"]);
});

var archiveHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return ArchiveScreen();
});

var settingsHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return SettingsScreen();
});

class App extends StatefulWidget {
  @override
  State createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  AppState() {
    router.define("/",
        handler: homeHandler, transitionDuration: Duration(milliseconds: 300));
    router.define("/home",
        handler: homeHandler, transitionDuration: Duration(milliseconds: 300));
    router.define("/blog/posts/:path",
        handler: postHandler, transitionDuration: Duration(milliseconds: 300));
    router.define("/settings",
        handler: settingsHandler,
        transitionDuration: Duration(milliseconds: 300));
    router.define("/archive",
        handler: archiveHandler,
        transitionDuration: Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ldelossa.is',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: router.generator,
    );
  }
}
