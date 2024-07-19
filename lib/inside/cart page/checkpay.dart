import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:plp/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:plp/inside/cart%20page/current.dart';
import 'package:plp/inside/home%20page/home.dart';

class Confirm extends StatefulWidget {
  const Confirm({super.key});

  @override
  State<Confirm> createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 26, 239, 113),
      body: InkWell(
        onTap: () {
          constantsValues.total = 0;
          order.clear();
          cart.clear();
          Navigator.pushReplacement(
              context,
              PageTransition(
                child: Home(),
                type: PageTransitionType.size,
                duration: Duration(milliseconds: 500),
                alignment: Alignment.center,
              ));
        },
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 140,
              ),
              Lottie.asset("assets/check.json", controller: _controller,
                  onLoaded: (composition) {
                _controller
                  ..duration = composition.duration
                  ..forward();
              }),
              Text(
                constantsValues.lang == true ? "Done!!" : "!!تمت بنجاح",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                constantsValues.lang == true
                    ? "Start packaging your\n        order now...."
                    : "سنبدأ بتجهيز طلبك\n      ...على الفور   ",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
