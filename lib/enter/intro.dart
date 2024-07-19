import 'package:flutter/material.dart';
import 'package:indexed/indexed.dart';
import 'package:page_transition/page_transition.dart';
import 'package:plp/enter/log_in.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Indexer(
          children: [
            Indexed(
              index: 1,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/table2.png"),
                        fit: BoxFit.cover)),
              ),
            ),
            Indexed(
                index: 2,
                child: Positioned(
                  top: 220,
                  left: -120,
                  child: Container(
                    width: 400,
                    height: 400,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(172, 255, 255, 255),
                        borderRadius: BorderRadius.circular(150)),
                  ),
                )),
            Indexed(
                index: 3,
                child: Positioned(
                  top: 300,
                  left: 10,
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          "THE BEST",
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 1, 50, 100)),
                        ),
                        Text(
                          "     medicines deal\n     in all country \n     with a lovely service.\n     on your mark...",
                          style: TextStyle(fontSize: 23),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: 120,
                          height: 50,
                          child: ElevatedButton.icon(
                            icon: Icon(
                              Icons.arrow_forward_sharp,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            label: Text(
                              "Start",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  PageTransition(
                                      duration: Duration(milliseconds: 900),
                                      child: Sign_In(),
                                      type: PageTransitionType.rightToLeft));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 17, 156, 73),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
