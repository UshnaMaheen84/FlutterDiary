import 'package:diary/screens/login.dart';
import 'package:diary/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'splash',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
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
  Widget build(BuildContext context) {
    getVisitingFlag() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool alreadyVisit = prefs.getBool('alreadyVisit') ?? false;
      return alreadyVisit;
    }

    checkVisitingFlag() async {
      bool visitingFlag = await getVisitingFlag();

      if (visitingFlag == true) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return Login();
        }));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return SignUp();
        }));
      }
    };
    checkVisitingFlag();

    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          color: Color(0xffffe2bb),
        ),
      ),
    );
  }
}
