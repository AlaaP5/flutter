import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plp/inside/home%20page/catsearch.dart';
import 'package:plp/inside/home%20page/show.dart';
import 'package:plp/constants.dart';
import 'package:http/http.dart' as http;

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  var listsearch = [];
  Future searchData() async {
    var url = constantsValues().baseUrl + "/api/category/search";
    var response = await http.get(Uri.parse(url), headers: <String, String>{
      'Authorization': 'Bearer ' + constantsValues.token,
    });
    var body = jsonDecode(response.body);
    for (int i = 0; i < body.length; i++) {
      listsearch.add(body[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 219, 255, 233),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                    context: context, delegate: CatCSearch(list: listsearch));
              },
              icon: Icon(
                Icons.search,
                size: 30,
              ))
        ],
        title: Text(
          constantsValues.lang == true ? "Categories" : "التصنيفات",
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 26, 239, 113),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      var c = Color.fromARGB(255, 246, 224, 84);
                      var cc = Color.fromARGB(255, 247, 233, 138);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Show(
                                    cardcolor: cc,
                                    title: constantsValues.lang == true
                                        ? 'Digestive'
                                        : "الهضمية",
                                    appbarcolor: c,
                                    man_id: 1,
                                  )));
                    },
                    child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 246, 224, 84),
                            borderRadius: BorderRadius.circular(120)),
                        child: Center(
                            child: Text(
                          constantsValues.lang == true
                              ? "Digestive"
                              : "الهضمية",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ))),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      var c = Color.fromARGB(255, 89, 218, 236);
                      var cc = Color.fromARGB(255, 151, 227, 237);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Show(
                                    cardcolor: cc,
                                    title: constantsValues.lang == true
                                        ? 'Allergy'
                                        : "الحساسية",
                                    appbarcolor: c,
                                    man_id: 2,
                                  )));
                    },
                    child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 89, 218, 236),
                            borderRadius: BorderRadius.circular(120)),
                        child: Center(
                            child: Text(
                          constantsValues.lang == true ? "Allergy" : "الحساسية",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ))),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      var c = Color.fromARGB(255, 175, 109, 238);
                      var cc = Color.fromARGB(255, 200, 166, 233);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Show(
                                    cardcolor: cc,
                                    title: constantsValues.lang == true
                                        ? 'Painkiller'
                                        : "مسكن ألم",
                                    appbarcolor: c,
                                    man_id: 3,
                                  )));
                    },
                    child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 175, 109, 238),
                            borderRadius: BorderRadius.circular(120)),
                        child: Center(
                            child: Text(
                          constantsValues.lang == true
                              ? "Painkiller"
                              : "مسكن ألم",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ))),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      var c = Color.fromARGB(255, 244, 112, 163);
                      var cc = Color.fromARGB(255, 245, 177, 203);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Show(
                                    cardcolor: cc,
                                    title: constantsValues.lang == true
                                        ? 'Diabetes'
                                        : "السكري",
                                    appbarcolor: c,
                                    man_id: 4,
                                  )));
                    },
                    child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 244, 112, 163),
                            borderRadius: BorderRadius.circular(120)),
                        child: Center(
                            child: Text(
                          constantsValues.lang == true ? "Diabetes" : "السكري",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ))),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      var c = Color.fromARGB(255, 180, 228, 187);
                      var cc = Color.fromARGB(255, 195, 225, 199);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Show(
                                    cardcolor: cc,
                                    title: constantsValues.lang == true
                                        ? 'Pressure'
                                        : "خافض ضغط",
                                    appbarcolor: c,
                                    man_id: 5,
                                  )));
                    },
                    child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 180, 228, 187),
                            borderRadius: BorderRadius.circular(120)),
                        child: Center(
                            child: Text(
                          constantsValues.lang == true
                              ? "Pressure"
                              : "خافض ضغط",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ))),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      var c = Color.fromARGB(255, 93, 88, 240);
                      var cc = Color.fromARGB(255, 163, 161, 240);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Show(
                                    cardcolor: cc,
                                    title: constantsValues.lang == true
                                        ? 'Nerv&Psy'
                                        : "عصبي و نفسي",
                                    appbarcolor: c,
                                    man_id: 6,
                                  )));
                    },
                    child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 93, 88, 240),
                            borderRadius: BorderRadius.circular(120)),
                        child: Center(
                            child: Text(
                          constantsValues.lang == true
                              ? "Nerv&Psy"
                              : "نفسي و عصبي",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ))),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      var c = Color.fromARGB(255, 245, 59, 59);
                      var cc = Color.fromARGB(255, 251, 158, 158);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Show(
                                    cardcolor: cc,
                                    title: constantsValues.lang == true
                                        ? 'Heart'
                                        : "قلبية",
                                    appbarcolor: c,
                                    man_id: 7,
                                  )));
                    },
                    child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 245, 59, 59),
                            borderRadius: BorderRadius.circular(120)),
                        child: Center(
                            child: Text(
                          constantsValues.lang == true ? "Heart" : "قلبية",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ))),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
