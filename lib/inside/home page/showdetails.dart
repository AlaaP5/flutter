import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:plp/constants.dart';
import 'package:plp/inside/cart%20page/current.dart';

// ignore: must_be_immutable
class ShowDetails extends StatefulWidget {
  ShowDetails({
    required this.appbarcolor,
    required this.cardcolor,
    required this.id,
  });
  final id;

  final appbarcolor;
  final cardcolor;

  @override
  State<ShowDetails> createState() => _ShowDetailsState(id: id);
}

class _ShowDetailsState extends State<ShowDetails> {
  _ShowDetailsState({required this.id}) {}
  final id;
  List? roben;
  final url = constantsValues().baseUrl + "/api/drug/show/";

  void fetchPosts() async {
    try {
      final response =
          await http.get(Uri.parse(url + "$id"), headers: <String, String>{
        'Authorization': 'Bearer ' + constantsValues.token,
      });
      final jsonData = jsonDecode(response.body);
      setState(() {
        roben = jsonData;
      });
    } catch (err) {}
  }

  Future favourite(String id) async {
    // ignore: unused_local_variable
    var response = await http.post(
        Uri.parse(constantsValues().baseUrl + "/api/favorite/add"),
        headers: <String, String>{
          'Authorization': 'Bearer ' + constantsValues.token,
        },
        body: <String, String>{
          "drug_id": id,
        });
  }

  Future deleteFavourite(String id) async {
    // ignore: unused_local_variable
    var response = await http.post(
        Uri.parse(constantsValues().baseUrl + "/api/favorite/delete"),
        headers: <String, String>{
          'Authorization': 'Bearer ' + constantsValues.token,
        },
        body: <String, String>{
          "drug_id": id,
        });
  }

  @override
  void initState() {
    fetchPosts();
    super.initState();
  }

  var favorite = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: widget.appbarcolor,
        onPressed: () {
          // ignore: unused_local_variable
          int price = int.parse("${roben?[0]["price"]}");
          constantsValues.total = constantsValues.total + price;
          int i = 1;
          late List a = [
            "${roben?[0]["commercial_name"]}",
            "${roben?[0]["company"]["nameEN"]}",
            "${roben?[0]["price"]}",
            "${roben?[0]["id"]}",
            "${roben?[0]["company"]["nameAR"]}"
          ];
          order.add([roben?[0]["id"], i]);
          cart.add(a);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              action: SnackBarAction(
                label: constantsValues.lang == true ? "Ok" : "تم",
                onPressed: () {},
                textColor: Color.fromARGB(255, 62, 103, 206),
              ),
              duration: Duration(seconds: 2),
              content: Text(
                constantsValues.lang == true
                    ? "Added to cart"
                    : "اضافة الى السلة",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              )));
        },
        child: Icon(Icons.add_shopping_cart),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                if (favorite) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      action: SnackBarAction(
                        label: constantsValues.lang == true ? "Ok" : "تم",
                        onPressed: () {},
                        textColor: Color.fromARGB(255, 62, 103, 206),
                      ),
                      duration: Duration(seconds: 2),
                      content: Text(
                        constantsValues.lang == true
                            ? "Added to favorite"
                            : "اضيف الى المفضلة",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      )));
                  favourite(id.toString());
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      action: SnackBarAction(
                        label: constantsValues.lang == true ? "Ok" : "تم",
                        onPressed: () {},
                        textColor: Color.fromARGB(255, 62, 103, 206),
                      ),
                      duration: Duration(seconds: 2),
                      content: Text(
                        constantsValues.lang == true
                            ? "Removed from favorite"
                            : "ازالة من المفضلة",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      )));
                  deleteFavourite(id.toString());
                }
                ;
                setState(() {
                  favorite = !favorite;
                });
              },
              icon: favorite
                  ? Icon(
                      Icons.favorite_border,
                      size: 40,
                      color: Color.fromARGB(255, 255, 0, 0),
                    )
                  : Icon(
                      Icons.favorite,
                      size: 40,
                      color: Color.fromARGB(255, 255, 0, 0),
                    ))
        ],
        backgroundColor: widget.appbarcolor,
        title: Text(
          "${roben?[0]["commercial_name"]}",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: widget.appbarcolor,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
            width: 380,
            height: 380,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                image: DecorationImage(
                    image: AssetImage("assets/default.jpg"), fit: BoxFit.fill)),
          ),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Color.fromARGB(132, 255, 255, 255),
              ),
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              width: 410,
              height: 333,
              child: Padding(
                  padding: EdgeInsets.all(0),
                  child: Container(
                    margin: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                        border: Border.all(color: widget.cardcolor, width: 3),
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(132, 255, 255, 255)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        constantsValues.lang == true
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Sci. name : ",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${roben?[0]["scientific_name"]}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${roben?[0]["scientific_name"]}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "   : الاسم العلمي",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                        SizedBox(
                          height: 25,
                        ),
                        constantsValues.lang == true
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Company name : ",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${roben?[0]["company"]["nameEN"]}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${roben?[0]["company"]["nameAR"]}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "    : اسم الشركة",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                        SizedBox(
                          height: 25,
                        ),
                        constantsValues.lang == true
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Expiry date: ",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    width: 100,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: widget.appbarcolor,
                                            width: 3),
                                        color:
                                            Color.fromARGB(132, 255, 255, 255)),
                                    child: Text("${roben?[0]["expiry_date"]}"),
                                  )
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    width: 100,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: widget.appbarcolor,
                                            width: 3),
                                        color:
                                            Color.fromARGB(132, 255, 255, 255)),
                                    child: Text("${roben?[0]["expiry_date"]}"),
                                  ),
                                  Text(
                                    "  : انتهاء الصلاحية",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                        SizedBox(
                          height: 25,
                        ),
                        constantsValues.lang == true
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Price : ",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      "${roben?[0]["price"]}", // roben[1]["price"],
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Color.fromARGB(255, 64, 149, 41)))
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      "${roben?[0]["price"]}", // roben[1]["price"],
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromARGB(
                                              255, 64, 149, 41))),
                                  Text(
                                    "   : السعر",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  )))
        ],
      ),
    );
  }
}
