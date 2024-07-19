import 'dart:convert';
import 'dart:ui';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart';
import 'package:plp/constants.dart';
import 'package:plp/enter/log_in.dart';
import 'package:plp/inside/cart%20page/Orders.dart';
import 'package:plp/inside/cart%20page/current.dart';
import 'package:plp/inside/cart%20page/history.dart';
import 'package:plp/inside/home%20page/categories.dart';
import 'package:plp/inside/home%20page/setting.dart';
import 'package:plp/inside/home%20page/show.dart';
import 'package:plp/inside/home%20page/search.dart';
import 'package:plp/inside/home%20page/showdetails.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  Home();

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _HomeState() {
    fetchuser();
    fetchfav();
  }

  ///////////for search data////////////////

  var listsearch = [];
  Future searchData() async {
    var url = constantsValues().baseUrl + "/api/drug/search";
    var response = await http.get(Uri.parse(url), headers: <String, String>{
      'Authorization': 'Bearer ' + constantsValues.token,
    });
    var body = jsonDecode(response.body);
    for (int i = 0; i < body.length; i++) {
      listsearch.add(body[i]);
    }
  }
  //////////for search category/////////////////

  ///////////for logout////////////////
  void fetchLogOut() async {
    try {
      await get(Uri.parse(constantsValues().baseUrl + "/api/logoutUser"),
          headers: <String, String>{
            'Authorization': 'Bearer ' + constantsValues.token,
          });
    } catch (err) {}
  }

  ///////////user info in drawer/////////
  var info;
  void fetchuser() async {
    var url = constantsValues().baseUrl + "/api/userinfo";
    var response = await http.get(Uri.parse(url), headers: <String, String>{
      'Authorization': 'Bearer ' + constantsValues.token,
    });
    var body = jsonDecode(response.body);
    info = body;
  }

/////////for ads section/////////////////
  int activeindex = 0;
  final urlimage = [
    'assets/brufin.jpg',
    'assets/baby.jpg',
    'assets/ginsana.jpg',
    'assets/meronem.jpg',
  ];
//////////for bottomnavigationbar///////////
  int currentindex = 1;
  late PageController _pageController;
/////////for favorite page/////////////////
  var fav;
  void fetchfav() async {
    final response = await http.get(
        Uri.parse(constantsValues().baseUrl + "/api/favorite/index"),
        headers: <String, String>{
          'Authorization': 'Bearer ' + constantsValues.token,
        });
    final jsonData = jsonDecode(response.body);
    setState(() {
      fav = jsonData["drugs"];
    });
  }

/////////////////////////////////////////
  @override
  void initState() {
    setState(() {});
    super.initState();
    _pageController = PageController(initialPage: currentindex, keepPage: true);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  //////////////////////////////////////////

  final cartlist = [
    Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 254, 176, 75),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(255, 255, 152, 18),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: Offset(4, 4)),
              BoxShadow(
                  color: Color.fromARGB(255, 124, 193, 151),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: Offset(-4, -4))
            ]),
        child: Column(
          children: [
            Text(
              constantsValues.lang == true
                  ? "\nCurrent Order\n"
                  : "\nالطلب الحالي\n",
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Color.fromARGB(255, 43, 43, 43)),
            ),
            Icon(
              Icons.add_shopping_cart,
              size: 80,
              color: Color.fromARGB(255, 43, 43, 43),
            )
          ],
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 64, 188, 255),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(255, 18, 126, 184),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: Offset(4, 4)),
              BoxShadow(
                  color: Color.fromARGB(255, 130, 181, 150),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: Offset(-4, -4))
            ]),
        child: Column(
          children: [
            Text(
              constantsValues.lang == true ? "\nHistory\n" : "\nالسجل\n",
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Color.fromARGB(255, 43, 43, 43)),
            ),
            Icon(Icons.history,
                size: 80, color: Color.fromARGB(255, 43, 43, 43))
          ],
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 64, 64),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(255, 255, 24, 24),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: Offset(4, 4)),
              BoxShadow(
                  color: Color.fromARGB(255, 109, 158, 129),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: Offset(-4, -4))
            ]),
        child: Column(
          children: [
            Text(
              constantsValues.lang == true ? "\nMy Orders\n" : "\nطلبياتي\n",
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Color.fromARGB(255, 43, 43, 43)),
            ),
            Icon(Icons.receipt_long,
                size: 80, color: Color.fromARGB(255, 43, 43, 43))
          ],
        ),
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
      drawer: Drawer(
        width: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(30, 40, 0, 0),
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    color: const Color(0xff7c94b6),
                    image: const DecorationImage(
                      image: AssetImage("assets/p.default.png"),
                    ),
                    border: Border.all(
                        width: 8,
                        color: const Color.fromARGB(255, 26, 239, 113)),
                    borderRadius: BorderRadius.circular(120),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "\n\n\n ${info?[0]["name"]} ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${info?[0]["phone"]}",
                      style: TextStyle(color: Color.fromARGB(138, 81, 81, 81)),
                    )
                  ],
                )
              ],
            ),
            Text("\n        ____________________________________________"),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Setting()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.settings,
                    size: 35,
                    color: Color.fromARGB(255, 26, 239, 113),
                  ),
                  Text(
                    constantsValues.lang == true
                        ? "     Settings"
                        : "      الاعدادات",
                    style: TextStyle(
                        fontSize: 20, color: Color.fromARGB(205, 81, 81, 81)),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.info,
                    size: 35,
                    color: Color.fromARGB(255, 26, 239, 113),
                  ),
                  Text(
                    constantsValues.lang == true
                        ? "     About Us"
                        : "     عن التطبيق",
                    style: TextStyle(
                        fontSize: 20, color: Color.fromARGB(205, 81, 81, 81)),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                fetchLogOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Sign_In()));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    action: SnackBarAction(
                      label: "",
                      onPressed: () {},
                      textColor: Color.fromARGB(255, 62, 103, 206),
                    ),
                    duration: Duration(seconds: 2),
                    content: Text(
                      constantsValues.lang == true
                          ? "logged out"
                          : "تم تسجيل خروجك",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    )));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.logout,
                    size: 35,
                    color: Color.fromARGB(255, 26, 239, 113),
                  ),
                  Text(
                    constantsValues.lang == true
                        ? "     Log Out"
                        : "     تسجيل خروج",
                    style: TextStyle(
                        fontSize: 20, color: Color.fromARGB(205, 81, 81, 81)),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 350,
            ),
            Text(
              constantsValues.lang == true
                  ? "       Damascus University Projects"
                  : "                 مشروع جامعة دمشق",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color.fromARGB(61, 19, 104, 54)),
            )
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 219, 255, 233),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        shadowColor: Color.fromARGB(255, 255, 255, 255),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 26, 239, 113),
        title: Text(
          constantsValues.lang == true ? "Medical" : "الصيدلية",
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: PageView(
          physics: ScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              currentindex = index;
            });
          },
          children: [
            //////   Cart page////////////
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      constantsValues.lang == true
                          ? "   Cart"
                          : "                                السلة",
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(125, 8, 8, 8))),
                  CarouselSlider.builder(
                      itemCount: cartlist.length,
                      itemBuilder: (context, index, realindex) {
                        final cartbox = cartlist[index];
                        return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => index == 0
                                          ? Current()
                                          : index == 1
                                              ? History()
                                              : Orders()));
                            },
                            child: buildcart(cartbox, index));
                      },
                      options: CarouselOptions(height: 300)),
                  Row(
                    children: [
                      Text(
                        constantsValues.lang == true
                            ? "          Tips:"
                            : "                                                           :نصائح",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 96, 96, 96)),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    width: 400,
                    height: 270,
                    child: constantsValues.lang == true
                        ? ListView(
                            children: [
                              Text(
                                "-   make sure that every thing is right before\n    ordering .",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 190, 190, 190)),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                  "-   don't give your account to anybody,\n    because any thing you order its \n     gonna be on you we are not responsible\n     of any mistake .",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color:
                                          Color.fromARGB(255, 190, 190, 190))),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                  "-   when you pass the 30th order you will get \n    a 10% discount on every order \n    after that for 2 months ahead .",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color:
                                          Color.fromARGB(255, 190, 190, 190))),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                  "-   ask our team for help at any time , send \n    a mail to (Medical@gmail.com) , or call us \n    on 2131456792324 .",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color:
                                          Color.fromARGB(255, 190, 190, 190))),
                            ],
                          )
                        : ListView(
                            children: [
                              Text(
                                "                             تأكد من صحة كل شيء قبل   -\n                                            .    ارسال الطلب   ",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 190, 190, 190)),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                  "           لا تسلم معلومات تسجيل دخولك الى احد   -\n       لأن اي شيء ستطلبه سيكون على مسؤوليتك     \n                      .  نحن لسنا مسؤولين عن اي خطأ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color:
                                          Color.fromARGB(255, 190, 190, 190))),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                  "              عندما تتجاوز ال 30 طلبية سوف تحصل  -  \n                  على خصم 10% على كل طلبية تطلبها  \n                                    . لمدة شهرين من تاريخه   ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color:
                                          Color.fromARGB(255, 190, 190, 190))),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                  "                            , اسأل فريقنا على أي مساعدة   -   \n                        يمكنك ارسال بريد الكتروني على  \n              او الاتصال , (Medical@gmail.com)   \n                        . على الرقم 2131456792324",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color:
                                          Color.fromARGB(255, 190, 190, 190))),
                            ],
                          ),
                  )
                ],
              ),
            ),
            //////  Home page/////////////
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Form(
                          child: InkWell(
                            onTap: () {
                              showSearch(
                                  context: context,
                                  delegate: CustomSearch(list: listsearch));
                            },
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 228, 228, 228),
                                  border: Border.all(
                                    width: 3,
                                    color: Color.fromARGB(255, 26, 239, 113),
                                  ),
                                  borderRadius: BorderRadius.circular(25)),
                              child: constantsValues.lang == true
                                  ? Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(Icons.search),
                                        Text(
                                          "   Search",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Color.fromARGB(
                                                  255, 134, 134, 134)),
                                        )
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "البحث    ",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Color.fromARGB(
                                                  255, 134, 134, 134)),
                                        ),
                                        Icon(Icons.search),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Categories()));
                      },
                      child: Text(
                        constantsValues.lang == true
                            ? "   Categories"
                            : "                                                  التصنيفات",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 85,
                      child:
                          ListView(scrollDirection: Axis.horizontal, children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    var c = Color.fromARGB(255, 246, 224, 84);
                                    var cc = Color.fromARGB(255, 247, 233, 138);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Show(
                                                  cardcolor: cc,
                                                  title: constantsValues.lang ==
                                                          true
                                                      ? 'Digestive'
                                                      : "الهضمية",
                                                  appbarcolor: c,
                                                  man_id: 1,
                                                )));
                                  },
                                  child: Container(
                                      width: 90,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 246, 224, 84),
                                          borderRadius:
                                              BorderRadius.circular(120)),
                                      child: Center(
                                          child: constantsValues.lang == true
                                              ? Text("Dig")
                                              : Text("هضم"))),
                                ),
                                Text(constantsValues.lang == true
                                    ? "Digestive"
                                    : "الهضمية")
                              ],
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    var c = Color.fromARGB(255, 89, 218, 236);
                                    var cc = Color.fromARGB(255, 151, 227, 237);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Show(
                                                  cardcolor: cc,
                                                  title: constantsValues.lang ==
                                                          true
                                                      ? 'Allergy'
                                                      : "الحساسية",
                                                  appbarcolor: c,
                                                  man_id: 2,
                                                )));
                                  },
                                  child: Container(
                                      width: 90,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 89, 218, 236),
                                          borderRadius:
                                              BorderRadius.circular(120)),
                                      child: Center(
                                          child: Text(
                                              constantsValues.lang == true
                                                  ? "All"
                                                  : "ح"))),
                                ),
                                Text(constantsValues.lang == true
                                    ? "Allergy"
                                    : "الحساسية")
                              ],
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    var c = Color.fromARGB(255, 175, 109, 238);
                                    var cc = Color.fromARGB(255, 200, 166, 233);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Show(
                                                  cardcolor: cc,
                                                  title: constantsValues.lang ==
                                                          true
                                                      ? 'Painkiller'
                                                      : "مسكن ألم",
                                                  appbarcolor: c,
                                                  man_id: 3,
                                                )));
                                  },
                                  child: Container(
                                      width: 90,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 175, 109, 238),
                                          borderRadius:
                                              BorderRadius.circular(120)),
                                      child: Center(
                                          child: Text(
                                              constantsValues.lang == true
                                                  ? "P"
                                                  : "م"))),
                                ),
                                Text(constantsValues.lang == true
                                    ? "Painkiller"
                                    : "مسكن ألم")
                              ],
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    var c = Color.fromARGB(255, 244, 112, 163);
                                    var cc = Color.fromARGB(255, 245, 177, 203);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Show(
                                                  cardcolor: cc,
                                                  title: constantsValues.lang ==
                                                          true
                                                      ? 'Diabetes'
                                                      : "السكري",
                                                  appbarcolor: c,
                                                  man_id: 4,
                                                )));
                                  },
                                  child: Container(
                                      width: 90,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 244, 112, 163),
                                          borderRadius:
                                              BorderRadius.circular(120)),
                                      child: Center(
                                          child: Text(
                                              constantsValues.lang == true
                                                  ? "Dia"
                                                  : "س"))),
                                ),
                                Text(constantsValues.lang == true
                                    ? "Diabetes"
                                    : "السكري")
                              ],
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    var c = Color.fromARGB(255, 180, 228, 187);
                                    var cc = Color.fromARGB(255, 195, 225, 199);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Show(
                                                  cardcolor: cc,
                                                  title: constantsValues.lang ==
                                                          true
                                                      ? 'Pressure'
                                                      : "خافص ضغط",
                                                  appbarcolor: c,
                                                  man_id: 5,
                                                )));
                                  },
                                  child: Container(
                                      width: 90,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 180, 228, 187),
                                          borderRadius:
                                              BorderRadius.circular(120)),
                                      child: Center(
                                          child: Text(
                                              constantsValues.lang == true
                                                  ? "Pre"
                                                  : "خ ض"))),
                                ),
                                Text(constantsValues.lang == true
                                    ? "Pressure"
                                    : "خافض ضغط")
                              ],
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    var c = Color.fromARGB(255, 93, 88, 240);
                                    var cc = Color.fromARGB(255, 163, 161, 240);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Show(
                                                  cardcolor: cc,
                                                  title: constantsValues.lang ==
                                                          true
                                                      ? 'Nerv&Psy'
                                                      : "عصبي و نفسي",
                                                  appbarcolor: c,
                                                  man_id: 6,
                                                )));
                                  },
                                  child: Container(
                                      width: 90,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 93, 88, 240),
                                          borderRadius:
                                              BorderRadius.circular(120)),
                                      child: Center(
                                          child: Text(
                                              constantsValues.lang == true
                                                  ? "N&P"
                                                  : "ن&ع"))),
                                ),
                                Text(constantsValues.lang == true
                                    ? "Nerv&Psy"
                                    : "عصبي و نفسي")
                              ],
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    var c = Color.fromARGB(255, 245, 59, 59);
                                    var cc = Color.fromARGB(255, 251, 158, 158);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Show(
                                                  cardcolor: cc,
                                                  title: constantsValues.lang ==
                                                          true
                                                      ? 'Heart'
                                                      : "قلبية",
                                                  appbarcolor: c,
                                                  man_id: 7,
                                                )));
                                  },
                                  child: Container(
                                      width: 90,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 245, 59, 59),
                                          borderRadius:
                                              BorderRadius.circular(120)),
                                      child: Center(
                                          child: Text(
                                              constantsValues.lang == true
                                                  ? "H"
                                                  : "ق"))),
                                ),
                                Text(constantsValues.lang == true
                                    ? "Heart"
                                    : "قلبية")
                              ],
                            ),
                          ],
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      constantsValues.lang == true
                          ? "  Ads\n"
                          : "                                                    الاعلانات\n",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(0, 233, 233, 233),
                          boxShadow: []),
                      width: 360,
                      height: 380,
                      child: Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CarouselSlider.builder(
                                  itemCount: urlimage.length,
                                  itemBuilder: (context, index, realIndex) {
                                    final urlImage = urlimage[index];
                                    return buildImage(urlImage, index);
                                  },
                                  options: CarouselOptions(
                                    autoPlay: true,
                                    enlargeCenterPage: true,
                                    height: 340,
                                    onPageChanged: (index, reason) =>
                                        setState(() => activeindex = index),
                                  )),
                              SizedBox(
                                height: 12,
                              ),
                              buildIndicator(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            ////// Favourite Page////////////
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: fav?.length == 0
                    ? Center(
                        child: Text(
                        constantsValues.lang == true
                            ? "      you haven't \nadded anything yet"
                            : "لم تضف أي دواء\nالى المفضلة بعد",
                        style: TextStyle(
                            fontSize: 30, color: Color.fromARGB(90, 0, 0, 0)),
                      ))
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 10.0,
                                        crossAxisSpacing: 10.0),
                                itemCount: fav?.length,
                                itemBuilder: (context, i) {
                                  final post = fav?[i];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ShowDetails(
                                                    appbarcolor: post[
                                                                "manufacture_id"] ==
                                                            1
                                                        ? Color.fromARGB(
                                                            255, 246, 224, 84)
                                                        : post["manufacture_id"] ==
                                                                2
                                                            ? Color.fromARGB(
                                                                255, 89, 218, 236)
                                                            : post["manufacture_id"] ==
                                                                    3
                                                                ? Color.fromARGB(
                                                                    255,
                                                                    175,
                                                                    109,
                                                                    238)
                                                                : post["manufacture_id"] ==
                                                                        4
                                                                    ? Color.fromARGB(
                                                                        255,
                                                                        244,
                                                                        112,
                                                                        163)
                                                                    : post["manufacture_id"] ==
                                                                            5
                                                                        ? Color.fromARGB(
                                                                            255,
                                                                            180,
                                                                            228,
                                                                            187)
                                                                        : post["manufacture_id"] == 6
                                                                            ? Color.fromARGB(255, 93, 88, 240)
                                                                            : post["manufacture_id"] == 7
                                                                                ? Color.fromARGB(255, 245, 59, 59)
                                                                                : Color.fromARGB(0, 0, 0, 0),
                                                    cardcolor: post["manufacture_id"] ==
                                                            1
                                                        ? Color.fromARGB(
                                                            255, 247, 233, 138)
                                                        : post["manufacture_id"] ==
                                                                2
                                                            ? Color.fromARGB(
                                                                255,
                                                                151,
                                                                227,
                                                                237)
                                                            : post["manufacture_id"] ==
                                                                    3
                                                                ? Color.fromARGB(
                                                                    255,
                                                                    200,
                                                                    166,
                                                                    233)
                                                                : post["manufacture_id"] ==
                                                                        4
                                                                    ? Color.fromARGB(
                                                                        255,
                                                                        245,
                                                                        177,
                                                                        203)
                                                                    : post["manufacture_id"] ==
                                                                            5
                                                                        ? Color.fromARGB(
                                                                            255,
                                                                            195,
                                                                            225,
                                                                            199)
                                                                        : post["manufacture_id"] ==
                                                                                6
                                                                            ? Color.fromARGB(255, 163, 161, 240)
                                                                            : post["manufacture_id"] == 7
                                                                                ? Color.fromARGB(255, 251, 158, 158)
                                                                                : Color.fromARGB(255, 234, 14, 14),
                                                    id: post["id"],
                                                  )));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: post["manufacture_id"] == 1
                                              ? Color.fromARGB(
                                                  255, 246, 224, 84)
                                              : post["manufacture_id"] == 2
                                                  ? Color.fromARGB(
                                                      255, 89, 218, 236)
                                                  : post["manufacture_id"] == 3
                                                      ? Color.fromARGB(
                                                          255, 175, 109, 238)
                                                      : post["manufacture_id"] ==
                                                              4
                                                          ? Color.fromARGB(
                                                              255, 244, 112, 163)
                                                          : post["manufacture_id"] ==
                                                                  5
                                                              ? Color.fromARGB(
                                                                  255,
                                                                  180,
                                                                  228,
                                                                  187)
                                                              : post["manufacture_id"] ==
                                                                      6
                                                                  ? Color.fromARGB(
                                                                      255,
                                                                      93,
                                                                      88,
                                                                      240)
                                                                  : post["manufacture_id"] ==
                                                                          7
                                                                      ? Color.fromARGB(
                                                                          255,
                                                                          245,
                                                                          59,
                                                                          59)
                                                                      : Color.fromARGB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      width: 40,
                                      height: 40,
                                      child: Center(
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  "assets/default.jpg"),
                                              radius: 40,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              "${post["commercial_name"]}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          )
                        ],
                      )),
          ]),
      bottomNavigationBar: CurvedNavigationBar(
          index: currentindex,
          onTap: (index) {
            setState(() {
              _pageController.jumpToPage(index);
            });
          },
          height: 60,
          backgroundColor: Color.fromARGB(255, 219, 255, 233),
          color: Color.fromARGB(255, 26, 239, 113),
          animationDuration: Duration(milliseconds: 300),
          items: [
            Icon(Icons.shopping_bag),
            Icon(Icons.home),
            Icon(Icons.favorite),
          ]),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
      effect: ExpandingDotsEffect(
          dotWidth: 15, activeDotColor: Color.fromARGB(255, 26, 239, 113)),
      activeIndex: activeindex,
      count: urlimage.length);
}

Widget buildImage(String urlImage, int index) => Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Image.asset(
        urlImage,
        fit: BoxFit.cover,
      ),
    );

Widget buildcart(Widget cartlist, int index) => Container(
      margin: EdgeInsets.symmetric(horizontal: 1),
      child: cartlist,
    );
