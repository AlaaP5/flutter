import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:plp/constants.dart';
import 'package:http/http.dart' as http;
import 'package:plp/inside/cart%20page/showorder.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<dynamic> list = [];

  Future searchHistory(String date1, String date2) async {
    var url = constantsValues().baseUrl + "/api/order/history";
    var response = await http.post(Uri.parse(url), headers: <String, String>{
      'Authorization': 'Bearer ' + constantsValues.token,
    }, body: <String, String>{
      'from': date1,
      'to': date2,
    });
    final body = jsonDecode(response.body);
    list.clear();
    for (int i = 0; i < body.length; i++) {
      list.add(body[i]);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  var fromexpire;
  var toexpire;
  DateTime dateTime2 = DateTime(2030, 1, 1, 10, 20);
  DateTime dateTime1 = DateTime(2020, 1, 1, 10, 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 151, 212, 246),
      appBar: AppBar(
        title: Text(
          constantsValues.lang == true ? "History" : "السجل",
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 64, 188, 255),
      ),
      body: Column(
        children: [
          constantsValues.lang == true
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 410,
                          height: 160,
                          color: Color.fromARGB(255, 151, 212, 246),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "                 date 1:                    date 2:                     ",
                                style: TextStyle(fontSize: 20),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black26, width: 3)),
                                    width: 130,
                                    height: 60,
                                    child: CupertinoButton(
                                        child: Text(
                                          '${dateTime1.day}/${dateTime1.month}/${dateTime1.year}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 86, 86, 86)),
                                        ),
                                        onPressed: () {
                                          setState(() {});
                                          showCupertinoModalPopup(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  SizedBox(
                                                    height: 250,
                                                    child: CupertinoDatePicker(
                                                      backgroundColor:
                                                          Color.fromARGB(255,
                                                              255, 255, 255),
                                                      initialDateTime:
                                                          dateTime1,
                                                      onDateTimeChanged:
                                                          (DateTime newTime) {
                                                        setState(() =>
                                                            dateTime1 =
                                                                newTime);
                                                        fromexpire =
                                                            '${dateTime1.year}-${dateTime1.month}-${dateTime1.day}';
                                                      },
                                                      use24hFormat: true,
                                                      mode:
                                                          CupertinoDatePickerMode
                                                              .date,
                                                    ),
                                                  ));
                                          setState(() {});
                                        }),
                                  ),
                                  SizedBox(
                                    width: 40,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black26, width: 3)),
                                    width: 130,
                                    height: 60,
                                    child: CupertinoButton(
                                        child: Text(
                                          '${dateTime2.day}/${dateTime2.month}/${dateTime2.year}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 86, 86, 86)),
                                        ),
                                        onPressed: () {
                                          setState(() {});
                                          showCupertinoModalPopup(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  SizedBox(
                                                    height: 250,
                                                    child: CupertinoDatePicker(
                                                      backgroundColor:
                                                          Color.fromARGB(255,
                                                              255, 255, 255),
                                                      initialDateTime:
                                                          dateTime2,
                                                      onDateTimeChanged:
                                                          (DateTime newTime) {
                                                        setState(() =>
                                                            dateTime2 =
                                                                newTime);
                                                        toexpire =
                                                            '${dateTime2.year}-${dateTime2.month}-${dateTime2.day}';
                                                      },
                                                      use24hFormat: true,
                                                      mode:
                                                          CupertinoDatePickerMode
                                                              .date,
                                                    ),
                                                  ));
                                          setState(() {});
                                        }),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                  width: 80,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {});
                                      searchHistory(fromexpire, toexpire);
                                      setState(() {});
                                    },
                                    child: Text(
                                      "send",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255)),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromARGB(255, 64, 188, 255),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 410,
                          height: 160,
                          color: Color.fromARGB(255, 151, 212, 246),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "           :تاريخ 2:                      تاريخ 1           ",
                                style: TextStyle(fontSize: 20),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black26, width: 3)),
                                    width: 130,
                                    height: 60,
                                    child: CupertinoButton(
                                        child: Text(
                                          '${dateTime1.day}/${dateTime1.month}/${dateTime1.year}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 86, 86, 86)),
                                        ),
                                        onPressed: () {
                                          setState(() {});
                                          showCupertinoModalPopup(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  SizedBox(
                                                    height: 250,
                                                    child: CupertinoDatePicker(
                                                      backgroundColor:
                                                          Color.fromARGB(255,
                                                              255, 255, 255),
                                                      initialDateTime:
                                                          dateTime1,
                                                      onDateTimeChanged:
                                                          (DateTime newTime) {
                                                        setState(() =>
                                                            dateTime1 =
                                                                newTime);
                                                        fromexpire =
                                                            '${dateTime1.year}-${dateTime1.month}-${dateTime1.day}';
                                                      },
                                                      use24hFormat: true,
                                                      mode:
                                                          CupertinoDatePickerMode
                                                              .date,
                                                    ),
                                                  ));
                                          setState(() {});
                                        }),
                                  ),
                                  SizedBox(
                                    width: 40,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black26, width: 3)),
                                    width: 130,
                                    height: 60,
                                    child: CupertinoButton(
                                        child: Text(
                                          '${dateTime2.day}/${dateTime2.month}/${dateTime2.year}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 86, 86, 86)),
                                        ),
                                        onPressed: () {
                                          setState(() {});
                                          showCupertinoModalPopup(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  SizedBox(
                                                    height: 250,
                                                    child: CupertinoDatePicker(
                                                      backgroundColor:
                                                          Color.fromARGB(255,
                                                              255, 255, 255),
                                                      initialDateTime:
                                                          dateTime2,
                                                      onDateTimeChanged:
                                                          (DateTime newTime) {
                                                        setState(() =>
                                                            dateTime2 =
                                                                newTime);
                                                        toexpire =
                                                            '${dateTime2.year}-${dateTime2.month}-${dateTime2.day}';
                                                      },
                                                      use24hFormat: true,
                                                      mode:
                                                          CupertinoDatePickerMode
                                                              .date,
                                                    ),
                                                  ));
                                          setState(() {});
                                        }),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                  width: 80,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {});
                                      searchHistory(fromexpire, toexpire);
                                      setState(() {});
                                    },
                                    child: Text(
                                      "ارسال",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255)),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromARGB(255, 64, 188, 255),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            width: 500,
            height: 593,
            child: list.length == 0
                ? Center(
                    child: Text(
                      constantsValues.lang == true
                          ? "choose time with\n  date limit first"
                          : "  اختر توقيت مع\nتاريخ زمني محدود",
                      style: TextStyle(
                          color: Color.fromARGB(255, 189, 189, 189),
                          fontSize: 20),
                    ),
                  )
                : ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, i) {
                      final post = list[i];
                      return constantsValues.lang == true
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                    onTap: () {
                                      var color =
                                          Color.fromARGB(255, 223, 244, 255);
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
                                      width: 350,
                                      height: 170,
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 223, 244, 255),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Row(
                                        children: [
                                          Text(
                                            "    " +
                                                (i + 1).toString() +
                                                "    ",
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
                                                "Yes",
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
                              ],
                            )
                          : Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                    onTap: () {
                                      var color =
                                          Color.fromARGB(255, 223, 244, 255);
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
                                      width: 350,
                                      height: 170,
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 223, 244, 255),
                                          borderRadius:
                                              BorderRadius.circular(20)),
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
                                                "   نعم",
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
                                            "    " +
                                                (i + 1).toString() +
                                                "    ",
                                            style: TextStyle(fontSize: 30),
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            );
                    }),
          )
        ],
      ),
    );
  }
}
