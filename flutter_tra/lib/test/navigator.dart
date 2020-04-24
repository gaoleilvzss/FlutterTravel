import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_tra/test/home_breth.dart';

class PDANavigator extends StatefulWidget {
  @override
  _PDANavigatorState createState() => _PDANavigatorState();
}

class _PDANavigatorState extends State<PDANavigator> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: Text('test'),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(right: 5, left: 5),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.supervisor_account),
                      color: Colors.black54,
                      iconSize: 26,
                      onPressed: (){
                        _scaffoldKey.currentState.openDrawer();
                      },
                    ),

                    Expanded(
                        flex: 1,
                        child: Center(
                          child: Text(
                            '泊位信息',
                            style: TextStyle(
                                fontSize: 16, color: Color(0xff333333)),
                          ),
                        )),
                    Icon(
                      Icons.notifications,
                      color: Colors.black54,
                      size: 26,
                    )
                  ],
                ),
              )),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Baseline(
                  baseline: 50.0,
                  baselineType: TextBaseline.alphabetic,
                  child: new Text(
                    '现场车位',
                    style: new TextStyle(
                      fontSize: 20.0,
                      textBaseline: TextBaseline.alphabetic,
                    ),
                  ),
                ),
                new Baseline(
                  baseline: 50.0,
                  baselineType: TextBaseline.alphabetic,
                  child: new Container(
                    width: 2.0,
                    height: 30.0,
                    color: Colors.red,
                  ),
                ),
                new Baseline(
                  baseline: 50.0,
                  baselineType: TextBaseline.alphabetic,
                  child: new Text(
                    'RyRyRy',
                    style: new TextStyle(
                      fontSize: 35.0,
                      textBaseline: TextBaseline.alphabetic,
                    ),
                  ),
                ),
              ],
            )
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: HomeBerth(),
          )
        ],
      ),
    );
  }

}
