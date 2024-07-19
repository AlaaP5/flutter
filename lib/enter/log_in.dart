import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:indexed/indexed.dart';
import 'package:plp/inside/home%20page/home.dart';
import 'package:plp/enter/sign_up.dart';
import 'package:http/http.dart' as http;
import 'package:plp/constants.dart';

class Sign_In extends StatefulWidget {
  const Sign_In({super.key});

  @override
  State<Sign_In> createState() => _Sign_InState();
}

class _Sign_InState extends State<Sign_In> {
  Future login(String phone, String password) async {
    var response = await http.post(
        Uri.parse(constantsValues().baseUrl + '/api/loginUser'),
        body: <String, String>{
          'phone': phone,
          'password': password,
        });
    if (response.statusCode == 200) {
      var js = jsonDecode(response.body);
      constantsValues.token = js['data']['token'];
      print(constantsValues.token);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      print("sorry wrong enter");
    }
  }

  final userPhoneController = TextEditingController();
  final userpasswordController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();
  var obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Container(
        child: Indexer(
          children: [
            Indexed(
              index: 1,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/table2blur.png"),
                        fit: BoxFit.cover)),
              ),
            ),
            Indexed(
              index: 2, //less the value, below the order
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(56, 200, 33, 33),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(160, 255, 255, 255),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 255, 255, 255)
                                  .withOpacity(0.5), //color of shadow
                              spreadRadius: 5, //spread radius
                              blurRadius: 7, // blur radius
                              offset: const Offset(0, 2),
                            )
                          ],
                          border: Border.all(
                              width: 1,
                              color: const Color.fromARGB(249, 253, 253, 253)),
                          borderRadius: BorderRadius.circular(17)),
                      width: 300,
                      height: 540,
                      child: Form(
                        key: formState,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              constantsValues.lang == true
                                  ? "LOGIN"
                                  : "تسجيل دخول",
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Color.fromARGB(255, 0, 49, 98),
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              width: 170,
                              height: 170,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/applogo.png"),
                                      fit: BoxFit.cover)),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 6),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return constantsValues.lang == true
                                        ? "required!!"
                                        : "مطلوب";
                                  }
                                  if (value.length > 10 || value.length < 10) {
                                    return constantsValues.lang == true
                                        ? "can't put more or less than 10 numbers"
                                        : "لا يمكنك ادخال ارقام اكثر او اقل من 10";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.phone,
                                controller: userPhoneController,
                                cursorColor:
                                    const Color.fromARGB(255, 0, 49, 98),
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 49, 98)),
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.phone_in_talk,
                                    color: Color.fromARGB(255, 0, 49, 98),
                                  ),
                                  labelText: constantsValues.lang == true
                                      ? "Phone"
                                      : "الهاتف",
                                  labelStyle: const TextStyle(
                                      color: Color.fromARGB(255, 0, 49, 98)),
                                  hintText: '0 9 - - - - - - - -',
                                  hintStyle: const TextStyle(
                                      color: Color.fromARGB(105, 0, 49, 98)),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3,
                                        color: Color.fromARGB(255, 0, 49, 98)),
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3, color: Colors.redAccent),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 3,
                                        color: Color.fromARGB(255, 0, 49, 98)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 5, 15, 6),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return constantsValues.lang == true
                                        ? "required!!"
                                        : "مطلوب";
                                  }
                                  if (value.length < 8) {
                                    return constantsValues.lang == true
                                        ? "must be more than 8 character"
                                        : "يجب ان تكون اكثر من 8 رموز";
                                  }
                                  return null;
                                },
                                controller: userpasswordController,
                                obscureText: obscureText,
                                cursorColor:
                                    const Color.fromARGB(255, 0, 49, 98),
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 49, 98)),
                                decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        obscureText = !obscureText;
                                      });
                                    },
                                    child: obscureText
                                        ? Icon(
                                            Icons.visibility_off,
                                            color: Colors.grey,
                                          )
                                        : Icon(
                                            Icons.visibility,
                                            color:
                                                Color.fromARGB(255, 0, 49, 98),
                                          ),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: Color.fromARGB(255, 0, 49, 98),
                                  ),
                                  labelText: constantsValues.lang == true
                                      ? "Password"
                                      : "كلمة السر",
                                  labelStyle: const TextStyle(
                                      color: Color.fromARGB(255, 0, 49, 98)),
                                  hintText: '*********',
                                  hintStyle: const TextStyle(
                                      color: Color.fromARGB(105, 0, 49, 98)),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3,
                                        color: Color.fromARGB(255, 0, 49, 98)),
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3, color: Colors.redAccent),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 3,
                                        color: Color.fromARGB(255, 0, 49, 98)),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: 270,
                              height: 50,
                              child: ElevatedButton.icon(
                                icon: Icon(
                                  Icons.login,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                label: Text(
                                  constantsValues.lang == true
                                      ? "LOGIN"
                                      : "تسجيل دخول",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ),
                                onPressed: () async {
                                  setState(() {});
                                  if (formState.currentState!.validate()) {
                                    login(userPhoneController.text,
                                        userpasswordController.text);
                                  } else {
                                    print("not valid");
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 17, 156, 73),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                            ),
                            constantsValues.lang == true
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "\ndon't have account? ",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                139, 105, 104, 104)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 18, 0, 0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Sign_up()));
                                          },
                                          child: Text(
                                            "Sign-up",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 27, 102, 176)),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 18, 0, 0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Sign_up()));
                                          },
                                          child: Text(
                                            constantsValues.lang == true
                                                ? "Sign-up"
                                                : "...انشاء",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 27, 102, 176)),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "\n  لا تملك حساب؟",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                139, 105, 104, 104)),
                                      ),
                                    ],
                                  )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
