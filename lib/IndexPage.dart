import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:myapp/KMNetworking/KMNetworkingMethod.dart';
import 'KMNetworking/KMNetworkingManager.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 100),
            Text('show goods list page'),
            FlatButton(
              child: Text('gogogo'),
              onPressed: () {
                Navigator.pushNamed(context, '/goodsListPage',
                    arguments: {'id': '123'});

                // getHttp();
              },
            )
          ],
        ),
      ),
    );
  }
}

final url = "/api-user/banner/query/all";

successReuslt(data) {
  print(data);
}

errorReuslt(error) {}

void getHttp() async {
  var param = {"group": "2", "role": "1", "state": "1", "type": "0"};
  // var header = {};
  CancelToken token = CancelToken();
  // KMNetworkingManager().cancel(token);
  KMNetworkingManager().request(KMNetworkingMethod.GET, url,
      parameters: param, cancelToken: token, success: (data) {
    print("Success:$data");
  }, error: (error) {
    print(error);
  });
}
