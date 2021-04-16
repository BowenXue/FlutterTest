import 'package:flutter/material.dart';

import 'IndexPage.dart';
import 'SettingsPage.dart';
import 'UserCenterPage.dart';

class Tabs extends StatefulWidget {
  Tabs({Key key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  List _pageList = [
    IndexPage(),
    SettingsPage(),
    UserCenterPage(),
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this._pageList[this._currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: this._currentIndex,
        onTap: (int index) {
          setState(() {
            this._currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("首页"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            // ignore: deprecated_member_use
            title: Text("设置"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            title: Text("我的"),
          ),
        ],
      ),
      // body: MySpp(),
    );
  }
}
