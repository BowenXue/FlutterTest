import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/KMColors.dart';

class GoodsListPage extends StatefulWidget {
  final arguments;
  GoodsListPage({this.arguments});

  @override
  _GoodsListPageState createState() => _GoodsListPageState(this.arguments);
}

class _GoodsListPageState extends State<GoodsListPage> {
  final arguments;

  // ignore: unused_element
  _alertDialog() async {
    var result = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("alert title"),
            content: Text("alert content"),
            actions: [
              FlatButton(
                child: Text("确定"),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
              FlatButton(
                child: Text("取消"),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
            ],
          );
        });
    print(result);
  }

  _simpleDialog() async {
    var result = await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text("simpleDialog show"),
            children: [
              SimpleDialogOption(
                child: Text("取消"),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              SimpleDialogOption(
                child: Text("确定"),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              )
            ],
          );
        });
  }

  _cupertinoAlertDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("iOS 风格弹窗"),
            content: Text("this is content"),
            actions: [
              CupertinoDialogAction(
                child: Text("confirm"),
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoDialogAction(
                child: Text("cancel"),
                isDefaultAction: true,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  _GoodsListPageState(this.arguments);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('货源列表'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 100),
            Text(this.arguments['id']),
            MaterialButton(
              color: KMColors.c004af,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('go back'),
            ),
            MaterialButton(
              color: KMColors.c004af,
              onPressed: () {
                _alertDialog();
              },
              child: Text('showAlertDialog'),
            ),
            MaterialButton(
              color: KMColors.c004af,
              onPressed: () {
                _simpleDialog();
              },
              child: Text('showSimpleDialog'),
            ),
            MaterialButton(
              color: KMColors.c004af,
              onPressed: () {
                _cupertinoAlertDialog();
              },
              child: Text('showIOSAlertDialog'),
            ),
          ],
        ),
      ),
    );
  }
}
