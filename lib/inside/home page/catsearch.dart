import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:plp/constants.dart';
import 'package:plp/inside/home%20page/show.dart';

class CatSearch extends StatefulWidget {
  @override
  State<CatSearch> createState() => SearchState();
}

class SearchState extends State<CatSearch> {
  var listsearch = [];
  final url = constantsValues().baseUrl + "/api/category/search";

  void searchData() async {
    var response = await http.get(Uri.parse(url), headers: <String, String>{
      'Authorization': 'Bearer ' + constantsValues.token,
    });
    final body = jsonDecode(response.body);
    setState(() {
      listsearch = body;
    });
    print(body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class CatCSearch extends SearchDelegate<String> {
  CatCSearch({required this.list}) {
    searchData();
  }
  List<dynamic> list = [];

  Future searchData({searchTerm = ''}) async {
    var url = constantsValues().baseUrl + "/api/category/search/" + searchTerm;
    var response = await http.get(Uri.parse(url), headers: <String, String>{
      'Authorization': 'Bearer ' + constantsValues.token,
    });
    final body = jsonDecode(response.body);
    list.clear();
    for (int i = 0; i < body.length; i++) {
      list.add(body[i]);
    }
  }

  ///////////////////////////////////////////////////////////
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, "");
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<dynamic> matched = [];
    for (var item in list) {
      if (item["nameEN"]
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase())) {
        matched.add(item);
      }
    }
    return matched.length == 0
        ? Center(
            child: Text(
              constantsValues.lang == true
                  ? "$query \ncategorie not found"
                  : "$query \nلم يعثر عليه",
              style: TextStyle(),
            ),
          )
        : ListView.builder(
            itemCount: matched.length,
            itemBuilder: (context, i) {
              final post = matched[i];
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      print(post["id"]);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Show(
                                    appbarcolor: post["id"] == 1
                                        ? Color.fromARGB(255, 246, 224, 84)
                                        : post["id"] == 2
                                            ? Color.fromARGB(255, 89, 218, 236)
                                            : post["id"] == 3
                                                ? Color.fromARGB(
                                                    255, 175, 109, 238)
                                                : post["id"] == 4
                                                    ? Color.fromARGB(
                                                        255, 244, 112, 163)
                                                    : post["id"] == 5
                                                        ? Color.fromARGB(
                                                            255, 180, 228, 187)
                                                        : post["id"] == 6
                                                            ? Color.fromARGB(
                                                                255,
                                                                93,
                                                                88,
                                                                240)
                                                            : post["id"] == 7
                                                                ? Color
                                                                    .fromARGB(
                                                                        255,
                                                                        245,
                                                                        59,
                                                                        59)
                                                                : Color
                                                                    .fromARGB(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        0),
                                    title: constantsValues.lang == true
                                        ? post["nameEN"]
                                        : post["nameAR"],
                                    cardcolor: post["id"] == 1
                                        ? Color.fromARGB(255, 247, 233, 138)
                                        : post["id"] == 2
                                            ? Color.fromARGB(255, 151, 227, 237)
                                            : post["id"] == 3
                                                ? Color.fromARGB(
                                                    255, 200, 166, 233)
                                                : post["id"] == 4
                                                    ? Color.fromARGB(
                                                        255, 245, 177, 203)
                                                    : post["id"] == 5
                                                        ? Color.fromARGB(
                                                            255, 195, 225, 199)
                                                        : post["id"] == 6
                                                            ? Color.fromARGB(
                                                                255,
                                                                163,
                                                                161,
                                                                240)
                                                            : post["id"] == 7
                                                                ? Color
                                                                    .fromARGB(
                                                                        255,
                                                                        251,
                                                                        158,
                                                                        158)
                                                                : Color
                                                                    .fromARGB(
                                                                        255,
                                                                        234,
                                                                        14,
                                                                        14),
                                    man_id: post["id"],
                                  )));
                    },
                    child: Container(
                      height: 90,
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(180),
                        color: post["id"] == 1
                            ? Color.fromARGB(255, 246, 224, 84)
                            : post["id"] == 2
                                ? Color.fromARGB(255, 89, 218, 236)
                                : post["id"] == 3
                                    ? Color.fromARGB(255, 244, 112, 163)
                                    : post["id"] == 4
                                        ? Color.fromARGB(255, 180, 228, 187)
                                        : post["id"] == 5
                                            ? Color.fromARGB(255, 93, 88, 240)
                                            : post["id"] == 6
                                                ? Color.fromARGB(
                                                    255, 245, 59, 59)
                                                : post["id"] == 7
                                                    ? Color.fromARGB(
                                                        255, 175, 109, 238)
                                                    : Color.fromARGB(
                                                        0, 0, 0, 0),
                      ),
                      child: Center(
                        child: Text(
                          constantsValues.lang == true
                              ? post["nameEN"]
                              : post["nameAR"],
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              );
            });
  }
}
