import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plp/constants.dart';
import 'package:plp/inside/home%20page/home.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool status = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
            icon: Icon(Icons.arrow_back)),
        backgroundColor: Color.fromARGB(255, 194, 194, 194),
        title: Text(
          constantsValues.lang == true ? "Setting" : "الاعدادات",
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Row(
          children: [
            Text(
              "        العربية    ",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            CupertinoSwitch(
                thumbColor: Color.fromARGB(255, 249, 249, 49),
                activeColor: Color.fromARGB(255, 152, 15, 236),
                value: constantsValues.lang,
                onChanged: (value) {
                  setState(() {
                    status = value;
                  });
                  if (status == false) {
                    setState(() {
                      constantsValues.lang = false;
                    });
                  }
                  if (status == true) {
                    setState(() {
                      constantsValues.lang = true;
                    });
                  }
                  print(constantsValues.lang);
                }),
            Text(
              "    English ",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
