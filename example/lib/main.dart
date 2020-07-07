import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_acpuserprofile/flutter_acpuserprofile.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _extensionVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String extensionVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      extensionVersion = await FlutterACPUserProfile.extensionVersion;
    } on PlatformException {
      extensionVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _extensionVersion = extensionVersion;
    });
  }

  // UTIL
  RichText getRichText(String label, String value) {
    return new RichText(
      text: new TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: new TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          new TextSpan(
              text: label, style: new TextStyle(fontWeight: FontWeight.bold)),
          new TextSpan(text: value),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: ListView(shrinkWrap: true, children: <Widget>[
            getRichText('ACPUserProfile extension version: ',
                '$_extensionVersion\n'),
            RaisedButton(
              child: Text("FlutterACPUserrofile.removeUserAttribute"),
              onPressed: () =>
                  FlutterACPUserProfile.removeUserAttribute("attrNameTest"),
            ),
            RaisedButton(
              child: Text("FlutterACPUserrofile.updateUserAttribute"),
              onPressed: () =>
                  FlutterACPUserProfile.updateUserAttribute("attrNameTest", "attrValueTest"),
            ),
            RaisedButton(
              child: Text("FlutterACPUserrofile.updateUserAttributes"),
              onPressed: () =>
                  FlutterACPUserProfile.updateUserAttributes({"mapKey": "mapValue", "mapKey1": "mapValue1"}),
            ),
          ]),
        )
      ),
    );
  }
}