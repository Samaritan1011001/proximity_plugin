import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proximity_plugin/proximity_plugin.dart';
import 'dart:async';


void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _proximity ;
  List<StreamSubscription<dynamic>> _streamSubscriptions =
  <StreamSubscription<dynamic>>[];
  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    _streamSubscriptions
        .add(proximityEvents.listen((ProximityEvent event) {
      setState(() {
        _proximity= event.x;
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Plugin example app'),
        ),
        body: new Center(
          child: new Text('Proximity is: ${_proximity}\n'),
        ),
      ),
    );
  }
}
