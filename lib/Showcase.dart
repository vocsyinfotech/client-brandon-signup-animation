import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Showcase extends StatefulWidget {
  @override
  _ShowcaseState createState() => _ShowcaseState();
}

class _ShowcaseState extends State<Showcase> {
  var name;
  var email;
  var phone;
  var password;
  var image;
  var location;
  var information;
  pref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name');
    email = prefs.getString('email');
    phone = prefs.getString('phone');
    password = prefs.getString('password');
    image = prefs.getString('image');
    location = prefs.getString('location');
    information = prefs.getString('information');
    setState(() {});
  }

  @override
  void initState() {
    pref();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: name != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Name -> $name'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Phone -> $phone'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('password -> $password'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Email -> $email'),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Image Path -> $image',
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Information -> $information'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Location -> $location'),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )
              : Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
