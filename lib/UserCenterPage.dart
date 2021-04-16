import 'package:flutter/material.dart';

class UserCenterPage extends StatefulWidget {
  UserCenterPage({Key key}) : super(key: key);

  @override
  _UserCenterPageState createState() => _UserCenterPageState();
}

class _UserCenterPageState extends State<UserCenterPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('this is usercenter page'),
    );
  }
}
