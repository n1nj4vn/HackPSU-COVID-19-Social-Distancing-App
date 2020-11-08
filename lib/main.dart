import 'package:flutter/material.dart';
import 'package:flutter_unity/flutter_unity.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'echoAR Unity demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'echoAR Demo Home Page'),
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
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COVID-19 Social Distancing Visualization App'),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    'Welcome to the COVID-19 Social Distancing \nVisualization App!\n',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UnityViewPage()));
                  },
                  child: Text('Launch AR'),
                )
              ]
          )
      ),
    );
  }
}

class UnityViewPage extends StatefulWidget {
  @override
  _UnityViewPageState createState() => _UnityViewPageState();
}

class _UnityViewPageState extends State<UnityViewPage> {
  UnityViewController unityViewController;

  double _sliderValue = 1.0;
  String _projectKey = 'young-paper-6121';
  String _entryID = '761d5b0b-8e8a-4fdb-83bb-d68935d02880';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COVID-19 Social Distancing Visualization App'),
      ),
      body: Stack(
        children: <Widget>[
          UnityView(
            onCreated: onUnityViewCreated,
            onReattached: onUnityViewReattached,
            onMessage: onUnityViewMessage,
          )
          // Positioned(
          //   bottom: 20,
          //   left: 20,
          //   right: 20,
          //   child: Card(
          //     elevation: 10,
          //     child: Column(
          //       children: <Widget>[
          //         Padding(
          //           padding: const EdgeInsets.only(top: 20),
          //           child: Text("Model Scale:"),
          //         ),
          //         Slider(
          //           onChanged: (value) {
          //             setState(() {
          //               _sliderValue = value;
          //             });
          //             setScale(value.toString());
          //           },
          //           value: _sliderValue,
          //           min: 0.1,
          //           max: 10,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  void onUnityViewCreated(UnityViewController controller) {
    print('onUnityViewCreated');

    unityViewController = controller;
  }

  void onUnityViewReattached(UnityViewController controller) {
    print('onUnityViewReattached');
  }

  void onUnityViewMessage(UnityViewController controller, String message) {
    print('onUnityViewMessage');

    print(message);
  }

  void setScale(String scale) {
    String url = 'https://console.echoar.xyz/post';
    print(scale);
    http.post(url, body: {
      'key': _projectKey,
      'entry': _entryID,
      'data': 'scale',
      'value': scale
    }).then((value) => print(value.body));
  }
}
