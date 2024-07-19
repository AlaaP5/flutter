import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:plp/constants.dart';
import 'package:plp/inside/home%20page/home.dart';
import 'package:plp/inside/home%20page/showdetails.dart';

class Show extends StatefulWidget {
  Show(
      {required this.title,
      this.appbarcolor,
      this.cardcolor,
      required this.man_id});
  final String title;
  final appbarcolor;
  final cardcolor;
  final man_id;

  @override
  State<Show> createState() => _ShowState(maid: man_id.toString());
}

class _ShowState extends State<Show> {
  _ShowState({required this.maid}) {}
  late final String? maid;
  var roben = [];

  final url = constantsValues().baseUrl + "/api/category/content/";

  void fetchPosts() async {
    try {
      final response =
          await get(Uri.parse(url + "$maid"), headers: <String, String>{
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
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => Home()));
                },
                icon: Icon(Icons.arrow_back)),
            backgroundColor: widget.appbarcolor,
            title: Text(
              widget.title,
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: ListView.builder(
              itemCount: roben.length,
              itemBuilder: (context, i) {
                final post = roben[i];
                return Card(
                  color: widget.cardcolor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage("assets/default.jpg"),
                      radius: 30,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShowDetails(
                                    id: post["id"],
                                    appbarcolor: widget.appbarcolor,
                                    cardcolor: widget.cardcolor,
                                  )));
                    },
                    title: Text(
                      " ${post["commercial_name"]}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      constantsValues.lang == true
                          ? " ${post["company"]["nameEN"]}"
                          : "${post["company"]["nameAR"]}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Text(
                      "${post["price"]}",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 97, 133, 87)),
                    ),
                  ),
                );
              }));
    });
  }
}
