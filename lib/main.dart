import 'package:flutter/material.dart';
import 'KMRoutes.dart';
// import 'Tabs.dart';
// import 'res/PersonModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: Tabs(),
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List list = [];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: this.list.map((value) {
            return ListTile(
              title: Text(value),
            );
          }).toList(),
        ),
        SizedBox(height: 20),
        // ignore: deprecated_member_use
        RaisedButton(
          child: Text('Button'),
          onPressed: () {
            setState(() {
              this.list.add('23333');
            });
          },
        ),
      ],
    );
  }
}

// // ignore: must_be_immutable
// class HomeContent extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       // ignore: deprecated_member_use
//       child: FlatButton(
//         child: Text('去新页面'),
//         textColor: Colors.blue,
//         onPressed: () async {
//           Navigator.pushNamed(context, "newPage");
//           // // ignore: unused_local_variable
//           // var result = await Navigator.push(
//           //   context,
//           //   MaterialPageRoute(builder: (context) {
//           //     return NewPage(text: '去了一个新页面????');
//           //   }),
//           // );
//           // print('返回了一个:$result');
//         },
//       ),
//     );
//   }
// }
