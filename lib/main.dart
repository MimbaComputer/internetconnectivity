import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Internet Connecivity by Mimba',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Internet Connecivity by Mimba'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _connectionStatus = "Unknow";
  Connectivity _connectivity;
  StreamSubscription _subscription;
  @override
  void initState() {
    super.initState();
    _connectivity = Connectivity();
    _subscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult event) {
      if (event == ConnectivityResult.wifi ||
          event == ConnectivityResult.mobile) {
        //connected to mobile or wifi
        setState(() {
          _connectionStatus = (event.index == 0 ? "wifi" : "mobile");
        });
      } else {
        //not connected
        setState(() {
          _connectionStatus = (event.index == 2 ? "none" : "je sais pas");
        });
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _connectionStatus,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
