import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'خانه هوشمند'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _switchState = false;

  void _changeState() {
    setState(() {
      _switchState = !_switchState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),*/
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage(_switchState
                          ? "assets/images/night.jpg"
                          : "assets/images/day.jpg"))),
            ),
            Positioned(
              bottom: 100,
              left: MediaQuery.of(context).size.width / 2 - 20,
              child: CupertinoSwitch(
                value: _switchState,
                thumbColor: Colors.lightGreenAccent,
                trackColor: Colors.white,
                activeColor: Colors.lightBlue,
                onChanged: (value) async {
                  try {
                    String status = value ? "on" : "off";
                    String uri = "http://endpointAddress/api/lights/$status";
                    Dio dio = Dio();
                    final response = await dio.get(uri);
                    print(response);
                    _switchState = value;
                  }
                  catch(ex) {
                    print(ex.toString());
                  }
                  setState(() {});
                },
              ),
            ),
          ],
        ));
  }
}
