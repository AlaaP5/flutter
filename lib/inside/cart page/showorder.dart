import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:plp/constants.dart';

class ShowOrder extends StatefulWidget {
  ShowOrder({required this.id, required this.appbar, required this.color});
  final id;
  final appbar;
  final color;
  @override
  State<ShowOrder> createState() =>
      ShowOrderState(id: '$id', appbar: '$appbar', color: '$color');
}

class ShowOrderState extends State<ShowOrder> {
  ShowOrderState(
      {required this.id, required this.appbar, required this.color}) {}
  late final color;
  late final String? id;
  late final String? appbar;

  var roben;

  final url = constantsValues().baseUrl + "/api/order/show/";

  void fetchShow() async {
    try {
      final response =
          await get(Uri.parse(url + "$id"), headers: <String, String>{
        'Authorization': 'Bearer ' + constantsValues.token,
      });
      final jsonData = jsonDecode(response.body);
      setState(() {
        roben = jsonData;
      });
    } catch (err) {}
  }

  @override
  void initState() {
    super.initState();
    fetchShow();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.color,
      appBar: AppBar(
        backgroundColor: widget.color,
        title: Text(
          constantsValues.lang == true ? "Order: $appbar" : "الطلب: $appbar",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      body: ListView.builder(
          itemCount: roben?["drugs"].length,
          itemBuilder: (context, i) {
            final post = roben?["drugs"][i];
            return Container(
              padding: EdgeInsets.all(9),
              margin: EdgeInsets.all(8),
              width: 100,
              height: 130,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 247, 247, 247),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      CircleAvatar(
                        backgroundImage: AssetImage("assets/default.jpg"),
                        radius: 40,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${post?["commercial_name"]}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            post?["company_id"] == 1
                                ? "Tramedica"
                                : post?["company_id"] == 2
                                    ? "Al-Fares"
                                    : "Unipharma",
                          ),
                          Text(
                            "  ${post?["price"]}",
                            style: TextStyle(
                              color: Color.fromARGB(255, 45, 208, 30),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "${post?["pivot"]["quantity_require"]}",
                                style: TextStyle(fontSize: 30),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
