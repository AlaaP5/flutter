import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:plp/constants.dart';
import 'package:plp/enter/intro.dart';
import 'package:plp/firebase_options.dart';
import 'package:plp/methods.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();
  print(constantsValues.fcm);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Intro(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(PageTransition(
          duration: Duration(milliseconds: 1300),
          child: Intro(),
          type: PageTransitionType.rotate,
          alignment: Alignment.topLeft));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 234, 233, 233),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 200, 20, 20),
              width: 500,
              height: 500,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage("assets/applogo.png"),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: CircularProgressIndicator(
              strokeWidth: 9,
              color: Color.fromARGB(255, 17, 156, 73),
            ),
          ),
        ],
      ),
    );
  }
}
