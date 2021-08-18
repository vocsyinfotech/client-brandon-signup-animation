import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController phone = new TextEditingController();

  TextEditingController name = new TextEditingController();

  TextEditingController email = new TextEditingController();

  TextEditingController password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                onChanged: (value) async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  setState(() {
                    prefs.setString('phone', value);
                  });
                },
                enabled: true,
                controller: phone,
                autofocus: false,
                decoration: new InputDecoration(
                  hintText: 'Phone No',
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  hintStyle: TextStyle(
                      color: Colors.white54,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w700),
                  fillColor: Colors.white54,
                  border: OutlineInputBorder(
                    gapPadding: 5,
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Color(0xffffffff), width: 3),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide:
                        BorderSide(color: Color(0xffF4ADB3), width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Color(0xffffffff), width: 3),
                  ),
                ),
                style: TextStyle(
                  fontFamily: "Poppins",
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.none,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                onChanged: (value) async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  setState(() {
                    prefs.setString('name', value);
                  });
                },
                enabled: true,
                controller: name,
                autofocus: false,
                decoration: new InputDecoration(
                  hintText: 'Name',
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  hintStyle: TextStyle(
                      color: Colors.white54,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w700),
                  fillColor: Colors.white54,
                  border: OutlineInputBorder(
                    gapPadding: 5,
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Color(0xffffffff), width: 3),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide:
                        BorderSide(color: Color(0xffF4ADB3), width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Color(0xffffffff), width: 3),
                  ),
                ),
                style: TextStyle(
                  fontFamily: "Poppins",
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.none,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                onChanged: (value) async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString('email', value);
                },
                enabled: true,
                controller: email,
                autofocus: false,
                decoration: new InputDecoration(
                  hintText: 'Email',
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  hintStyle: TextStyle(
                      color: Colors.white54,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w700),
                  fillColor: Colors.white54,
                  border: OutlineInputBorder(
                    gapPadding: 5,
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Color(0xffffffff), width: 3),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide:
                        BorderSide(color: Color(0xffF4ADB3), width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Color(0xffffffff), width: 3),
                  ),
                ),
                style: TextStyle(
                  fontFamily: "Poppins",
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.none,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                onChanged: (value) async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString('password', value);
                },
                enabled: true,
                controller: password,
                autofocus: false,
                decoration: new InputDecoration(
                  hintText: 'Password',
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  hintStyle: TextStyle(
                      color: Colors.white54,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w700),
                  fillColor: Colors.white54,
                  border: OutlineInputBorder(
                    gapPadding: 5,
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Color(0xffffffff), width: 3),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide:
                        BorderSide(color: Color(0xffF4ADB3), width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Color(0xffffffff), width: 3),
                  ),
                ),
                style: TextStyle(
                  fontFamily: "Poppins",
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
