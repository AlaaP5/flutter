import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:plp/constants.dart';
import 'package:plp/inside/home%20page/showdetails.dart';

class Search extends StatefulWidget {
  @override
  State<Search> createState() => SearchState();
}

class SearchState extends State<Search> {
  var listsearch = [];
  final url = constantsValues().baseUrl + "/api/drug/search";

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

class CustomSearch extends SearchDelegate<String> {
  CustomSearch({required this.list}) {
    searchData();
  }
  List<dynamic> list = [];

  Future searchData({searchTerm = ''}) async {
    var url = constantsValues().baseUrl + "/api/drug/search/" + searchTerm;
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
      if (item['commercial_name']
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
                  ? "$query \ndrug not found"
                  : "$query \nلم يعثر عليه",
              style: TextStyle(),
            ),
          )
        : ListView.builder(
            itemCount: matched.length,
            itemBuilder: (context, i) {
              final post = matched[i];
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                shadowColor: Color.fromARGB(0, 0, 0, 0),
                child: ListTile(
                  tileColor: post["manufacture_id"] == 1
                      ? Color.fromARGB(255, 247, 233, 138)
                      : post["manufacture_id"] == 2
                          ? Color.fromARGB(255, 151, 227, 237)
                          : post["manufacture_id"] == 3
                              ? Color.fromARGB(255, 200, 166, 233)
                              : post["manufacture_id"] == 4
                                  ? Color.fromARGB(255, 245, 177, 203)
                                  : post["manufacture_id"] == 5
                                      ? Color.fromARGB(255, 195, 225, 199)
                                      : post["manufacture_id"] == 6
                                          ? Color.fromARGB(255, 163, 161, 240)
                                          : post["manufacture_id"] == 7
                                              ? Color.fromARGB(
                                                  255, 251, 158, 158)
                                              : Color.fromARGB(
                                                  255, 228, 228, 228),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/default.jpg"),
                    radius: 30,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShowDetails(
                                  appbarcolor: post["manufacture_id"] == 1
                                      ? Color.fromARGB(255, 246, 224, 84)
                                      : post["manufacture_id"] == 2
                                          ? Color.fromARGB(255, 89, 218, 236)
                                          : post["manufacture_id"] == 3
                                              ? Color.fromARGB(
                                                  255, 175, 109, 238)
                                              : post["manufacture_id"] == 4
                                                  ? Color.fromARGB(
                                                      255, 244, 112, 163)
                                                  : post["manufacture_id"] == 5
                                                      ? Color.fromARGB(
                                                          255, 180, 228, 187)
                                                      : post["manufacture_id"] ==
                                                              6
                                                          ? Color.fromARGB(
                                                              255, 93, 88, 240)
                                                          : post["manufacture_id"] ==
                                                                  7
                                                              ? Color.fromARGB(
                                                                  255,
                                                                  245,
                                                                  59,
                                                                  59)
                                                              : Color.fromARGB(
                                                                  0, 0, 0, 0),
                                  cardcolor: post["manufacture_id"] == 1
                                      ? Color.fromARGB(255, 247, 233, 138)
                                      : post["manufacture_id"] == 2
                                          ? Color.fromARGB(255, 151, 227, 237)
                                          : post["manufacture_id"] == 3
                                              ? Color.fromARGB(
                                                  255, 200, 166, 233)
                                              : post["manufacture_id"] == 4
                                                  ? Color.fromARGB(
                                                      255, 245, 177, 203)
                                                  : post["manufacture_id"] == 5
                                                      ? Color.fromARGB(
                                                          255, 195, 225, 199)
                                                      : post["manufacture_id"] ==
                                                              6
                                                          ? Color.fromARGB(255,
                                                              163, 161, 240)
                                                          : post["manufacture_id"] ==
                                                                  7
                                                              ? Color.fromARGB(
                                                                  255,
                                                                  251,
                                                                  158,
                                                                  158)
                                                              : Color.fromARGB(
                                                                  255,
                                                                  234,
                                                                  14,
                                                                  14),
                                  id: post["id"],
                                )));
                  },
                  title: Text(
                    " ${post['commercial_name']}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    constantsValues.lang == true
                        ? "${post["company"]["nameEN"]}"
                        : "${post["company"]["nameAR"]}",
                    style: TextStyle(color: Color.fromARGB(255, 81, 81, 81)),
                  ),
                  trailing: Text(
                    "${post['price']}",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 97, 133, 87)),
                  ),
                ),
              );
            });
  }
}
