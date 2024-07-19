import 'package:flutter/material.dart';
import 'package:indexed/indexed.dart';
import 'package:page_transition/page_transition.dart';
import 'package:plp/constants.dart';
import 'package:plp/inside/cart%20page/checkpay.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'package:http/http.dart' as http;

List cart = [];
List order = [];

///add to cart

class Current extends StatefulWidget {
  const Current({super.key});

  @override
  State<Current> createState() => CurrentState();
}

class CurrentState extends State<Current> {
  Future oorder(String drug) async {
    // ignore: unused_local_variable
    var response = await http.post(
        Uri.parse(constantsValues().baseUrl + '/api/order/add'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + constantsValues.token,
        },
        body: <String, String>{
          'drug': drug,
        });
    if (response.statusCode == 200) {
      print(order);
      print("===========");
    } else {
      print(response.statusCode);
    }
  }

  bool isFinished = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 165, 46),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 254, 176, 75),
        title: Text(
          constantsValues.lang == true ? "Current Order" : "الطلب الحالي",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Indexer(
        children: [
          Indexed(
            index: 4,
            child: Positioned(
              top: 680,
              left: 55,
              child: SizedBox(
                width: 300,
                height: 60,
                child: SwipeableButtonView(
                  buttonText: constantsValues.lang == true
                      ? 'Slide To Order'
                      : "اسحب للطلب",
                  buttontextstyle: TextStyle(fontSize: 25, color: Colors.white),
                  buttonWidget: Icon(
                    Icons.keyboard_double_arrow_right_sharp,
                    color: Colors.grey,
                  ),
                  activeColor: Color.fromARGB(255, 26, 239, 113),
                  onWaitingProcess: () {
                    oorder(order.toString());
                    Future.delayed(Duration(seconds: 2),
                        () => setState(() => isFinished = true));
                  },
                  isFinished: isFinished,
                  onFinish: () async {
                    await Navigator.push(
                        context,
                        PageTransition(
                            child: Confirm(),
                            type: PageTransitionType.fade,
                            duration: Duration(milliseconds: 500)));
                    setState(() {
                      isFinished = false;
                    });
                  },
                ),
              ),
            ),
          ),
          Indexed(
            index: 2,
            child: cart.length == 0
                ? Center(
                    child: Text(
                    constantsValues.lang == true
                        ? "      you haven't \nadded anything yet"
                        : "لم تضف أي دواء\nالى الطلب الحالي",
                    style: TextStyle(
                        fontSize: 30, color: Color.fromARGB(90, 0, 0, 0)),
                  ))
                : Column(
                    children: [
                      Container(
                        color: Color.fromARGB(255, 255, 165, 46),
                        height: 620,
                        width: 411,
                        child: ListView.builder(
                          itemCount: cart.length,
                          itemBuilder: (context, i) {
                            int price = 0;
                            return Container(
                              padding: EdgeInsets.all(9),
                              margin: EdgeInsets.all(8),
                              width: 100,
                              height: 130,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 242, 242, 242),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CircleAvatar(
                                        backgroundImage:
                                            AssetImage("assets/default.jpg"),
                                        radius: 40,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${cart[i][0]}",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            constantsValues.lang == true
                                                ? "${cart[i][1]}   "
                                                : "${cart[i][4]}   ",
                                          ),
                                          Text(
                                            "${cart[i][2]}" + "\$",
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 45, 208, 30),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              SizedBox(
                                                height: 6,
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      if (order[i][1] == 50) {
                                                        order[i][1] = 50;
                                                      } else {
                                                        setState(() {
                                                          order[i][1]++;
                                                          price = 0;
                                                          price = (int.parse(
                                                                  "${cart[i][2]}") *
                                                              (int.parse(
                                                                  "${order[i][1]}")));
                                                          constantsValues
                                                              .total = constantsValues
                                                                  .total +
                                                              (price -
                                                                  (int.parse(
                                                                          "${cart[i][2]}") *
                                                                      (int.parse(
                                                                              "${order[i][1]}") -
                                                                          1)));
                                                        });
                                                      }
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.add,
                                                    size: 30,
                                                  )),
                                              Text(
                                                "${order[i][1]}",
                                                style: TextStyle(fontSize: 30),
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      if (order[i][1] == 1) {
                                                        order[i][1] = 1;
                                                      } else {
                                                        setState(() {
                                                          order[i][1]--;
                                                          price = 0;
                                                          price = (int.parse(
                                                                  "${cart[i][2]}") *
                                                              (int.parse(
                                                                  "${order[i][1]}")));
                                                          constantsValues
                                                              .total = constantsValues
                                                                  .total -
                                                              (price -
                                                                  (int.parse(
                                                                          "${cart[i][2]}") *
                                                                      (int.parse(
                                                                              "${order[i][1]}") -
                                                                          1)));
                                                        });
                                                      }
                                                    });
                                                  },
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Icon(
                                                        Icons.maximize_outlined,
                                                        size: 25,
                                                      ),
                                                    ],
                                                  )),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              constantsValues
                                                  .total = constantsValues
                                                      .total -
                                                  (int.parse("${cart[i][2]}") *
                                                      (int.parse(
                                                          "${order[i][1]}")));
                                              setState(() {
                                                cart.removeAt(i);
                                                order.removeAt(i);
                                              });
                                            },
                                            child: Icon(
                                              Icons.highlight_remove_outlined,
                                              size: 30,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          ),
          Indexed(
              index: 3,
              child: Positioned(
                top: 610,
                child: SizedBox(
                  width: 411,
                  height: 180,
                  child: Container(
                    width: 411,
                    height: 180,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              constantsValues.lang == true
                                  ? "\n                Total:                         "
                                  : "\n                الإجمالي:                         ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "\n${constantsValues.total}  " + "\$",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 45, 208, 30),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
