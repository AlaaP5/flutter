import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:indexed/indexed.dart';
import 'package:plp/inside/home%20page/home.dart';
import 'package:http/http.dart' as http;
import 'package:plp/constants.dart';

class Sign_up extends StatefulWidget {
  Sign_up({super.key});

  @override
  State<Sign_up> createState() => Sign_upState();
}

class Sign_upState extends State<Sign_up> {
  Future sign_up(
      String name, String phone, String password, String vpassword) async {
    var response = await http.post(
        Uri.parse(constantsValues().baseUrl + '/api/RegisterUser'),
        body: <String, String>{
          'name': name,
          'phone': phone,
          'password': password,
          'C_password': vpassword,
          'fcmtoken': constantsValues.fcm,
        });
    if (response.statusCode == 200) {
      var js = jsonDecode(response.body);
      constantsValues.token = js['data']['token'];
      print("the token is : " + constantsValues.token);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      print("sorry wrong sign_up");
    }
  }

  final newUserNameController = TextEditingController();
  final newPhoneController = TextEditingController();
  final newPasswordController = TextEditingController();
  final newPasswordCheckController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();
  var obscureText1 = true;
  var obscureText2 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              child: Padding(
                padding: const EdgeInsets.fromLTRB(56, 160, 33, 33),
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
                  height: 570,
                  child: Form(
                    key: formState,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          constantsValues.lang == true
                              ? " Create  Account"
                              : " انشاء  حساب",
                          style: TextStyle(
                              fontSize: 30,
                              color: Color.fromARGB(255, 0, 49, 98),
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 6),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return constantsValues.lang == true
                                    ? "Required!!"
                                    : "مطلوب";
                              }
                              if (value.length < 3) {
                                return constantsValues.lang == true
                                    ? "Must be more than 3 character"
                                    : "يجب ان يكون اكثر من 3 حروف";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            controller: newUserNameController,
                            cursorColor: const Color.fromARGB(255, 0, 49, 98),
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 49, 98)),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Color.fromARGB(255, 0, 49, 98),
                              ),
                              labelText: constantsValues.lang == true
                                  ? "Username"
                                  : "اسم المستخدم",
                              labelStyle: const TextStyle(
                                  color: Color.fromARGB(255, 0, 49, 98)),
                              hintText: constantsValues.lang == true
                                  ? 'username'
                                  : "مستخدم",
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
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 6),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return constantsValues.lang == true
                                    ? "Required!!"
                                    : "مطلوب";
                              }
                              if (value.length > 10 || value.length < 10) {
                                return constantsValues.lang == true
                                    ? "Can't put more or less than 10 numbers"
                                    : "لا يمكنك ادخال ارقام اكثر او اقل من 10";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.phone,
                            controller: newPhoneController,
                            cursorColor: const Color.fromARGB(255, 0, 49, 98),
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
                                    ? "Please enter password"
                                    : "ادخل كلمة سر رجاء";
                              }
                              if (value.length < 8) {
                                return constantsValues.lang == true
                                    ? "Must be more than 8 character"
                                    : "يجب ان تكون اكثر من 8 رموز";
                              }
                              return null;
                            },
                            obscureText: obscureText1,
                            controller: newPasswordController,
                            cursorColor: const Color.fromARGB(255, 0, 49, 98),
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 49, 98)),
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    obscureText1 = !obscureText1;
                                  });
                                },
                                child: obscureText1
                                    ? Icon(
                                        Icons.visibility_off,
                                        color: Colors.grey,
                                      )
                                    : Icon(
                                        Icons.visibility,
                                        color: Color.fromARGB(255, 0, 49, 98),
                                      ),
                              ),
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Color.fromARGB(255, 0, 49, 98),
                              ),
                              labelText: constantsValues.lang == true
                                  ? "Password"
                                  : "كلمة سر",
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
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 6),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return constantsValues.lang == true
                                    ? "Rewrite the password"
                                    : "اعد كلمة السر";
                              }
                              if (newPasswordController.text !=
                                  newPasswordCheckController.text) {
                                return constantsValues.lang == true
                                    ? "Password aren't the same!"
                                    : "كلمة السر غير مطابقة";
                              }
                              return null;
                            },
                            obscureText: obscureText2,
                            controller: newPasswordCheckController,
                            cursorColor: const Color.fromARGB(255, 0, 49, 98),
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 49, 98)),
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    obscureText2 = !obscureText2;
                                  });
                                },
                                child: obscureText2
                                    ? Icon(
                                        Icons.visibility_off,
                                        color: Colors.grey,
                                      )
                                    : Icon(
                                        Icons.visibility,
                                        color: Color.fromARGB(255, 0, 49, 98),
                                      ),
                              ),
                              prefixIcon: const Icon(
                                Icons.verified_user,
                                color: Color.fromARGB(255, 0, 49, 98),
                              ),
                              labelText: constantsValues.lang == true
                                  ? "Verify Password"
                                  : "تأكيد كلمة سر",
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
                          height: 10,
                        ),
                        SizedBox(
                          width: 270,
                          height: 70,
                          child: ElevatedButton.icon(
                            icon: Icon(
                              Icons.check,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            label: Text(
                              constantsValues.lang == true ? "Create" : "انشاء",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                            onPressed: () {
                              if (formState.currentState!.validate()) {
                                sign_up(
                                    newUserNameController.text,
                                    newPhoneController.text,
                                    newPasswordController.text,
                                    newPasswordCheckController.text);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        action: SnackBarAction(
                                          label: constantsValues.lang == true
                                              ? "Ok"
                                              : "تم",
                                          onPressed: () {},
                                          textColor:
                                              Color.fromARGB(255, 62, 103, 206),
                                        ),
                                        duration: Duration(seconds: 2),
                                        content: Text(
                                          constantsValues.lang == true
                                              ? "signed-up"
                                              : "تم انشاء حسابك",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400),
                                        )));
                              } else {
                                print("not valid");
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 17, 156, 73),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
