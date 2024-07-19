import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:plp/constants.dart';
import 'package:plp/inside/cart%20page/showorder.dart';

// ignore: must_be_immutable
class Orders extends StatefulWidget {
  Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  var roben = [];

  void fetchOrder() async {
    try {
      final response = await get(
          Uri.parse(constantsValues().baseUrl + "/api/order/my_order"),
          headers: <String, String>{
            'Authorization': 'Bearer ' + constantsValues.token,
          });
      final jsonData = jsonDecode(response.body) as List;
      setState(() {
        roben = jsonData;
      });
    } catch (err) {}
  }

  @override
  void initState() {
    super.initState();
    fetchOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            constantsValues.lang == true ? "My Orders" : "طلبياتي",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          backgroundColor: Color.fromARGB(255, 255, 64, 64),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ListView.builder(
            itemCount: roben.length,
            itemBuilder: (context, i) {
              final post = roben[i];
              return constantsValues.lang == true
                  ? Column(
                      children: [
                        InkWell(
                            onTap: () {
                              var color = Color.fromARGB(255, 255, 219, 219);
                              print(post["payment_status"]);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ShowOrder(
                                            id: "${post["id"]}",
                                            appbar: i + 1,
                                            color: color,
                                          )));
                            },
                            child: Container(
                              width: 500,
                              height: 170,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 219, 219),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                children: [
                                  Text(
                                    "    " + (i + 1).toString() + "    ",
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  Column(
                                    children: [
                                      Text("|"),
                                      Text("|"),
                                      Text("|"),
                                      Text("|"),
                                      Text("|"),
                                      Text("|"),
                                      Text("|"),
                                      Text("|"),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "   Total:",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "   Status:",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "   Payed:",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "${post["total"]} \$     ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color.fromARGB(
                                                255, 14, 154, 1)),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "${post["cases"]["nameEN"]}   ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color.fromARGB(
                                                255, 164, 164, 164)),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        post["payment_status"].toString() == "0"
                                            ? "No"
                                            : "Yes",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color.fromARGB(
                                                255, 164, 164, 164)),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    )
                  : Column(
                      children: [
                        InkWell(
                            onTap: () {
                              var color = Color.fromARGB(255, 255, 219, 219);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ShowOrder(
                                            id: "${post["id"]}",
                                            appbar: i + 1,
                                            color: color,
                                          )));
                            },
                            child: Container(
                              width: 500,
                              height: 170,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 219, 219),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "     ${post["total"]} \$",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color.fromARGB(
                                                255, 14, 154, 1)),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "     ${post["cases"]["nameAR"]}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color.fromARGB(
                                                255, 164, 164, 164)),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        post["payment_status"] == "0"
                                            ? "   لا"
                                            : "   نعم",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color.fromARGB(
                                                255, 164, 164, 164)),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        " : الإجمالي ",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        " : الحالة ",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        " : مدفوعات  ",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("|"),
                                      Text("|"),
                                      Text("|"),
                                      Text("|"),
                                      Text("|"),
                                      Text("|"),
                                      Text("|"),
                                      Text("|"),
                                    ],
                                  ),
                                  Text(
                                    "    " + (i + 1).toString() + "    ",
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    );
            },
          ),
        ));
  }
}
