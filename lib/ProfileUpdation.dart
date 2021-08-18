import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileUpdation extends StatefulWidget {
  File image;
  @override
  _ProfileUpdationState createState() => _ProfileUpdationState();
}

class _ProfileUpdationState extends State<ProfileUpdation> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: Theme.of(context).focusColor,
                    child: widget.image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: widget.image != null
                                ? Image.file(
                                    widget.image,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    'https://img.freepik.com/free-photo/pleasant-looking-serious-man-stands-profile-has-confident-expression-wears-casual-white-t-shirt_273609-16959.jpg?size=626&ext=jpg',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(50)),
                            width: 100,
                            height: 100,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.grey[800],
                            ),
                          ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            backgroundColor: Colors.white,
                            context: context,
                            builder: (BuildContext bc) {
                              return SafeArea(
                                child: Container(
                                  child: new Wrap(
                                    children: <Widget>[
                                      new ListTile(
                                        leading: new Icon(
                                          Icons.photo_library,
                                          color: Colors.black87,
                                        ),
                                        title: new Text('Photo Library',
                                            style: TextStyle(
                                                color: Colors.black87)),
                                        onTap: () {
                                          _imgFromGallery();
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      new ListTile(
                                        leading: new Icon(
                                          Icons.photo_camera,
                                          color: Colors.black87,
                                        ),
                                        title: new Text(
                                          'Camera',
                                          style:
                                              TextStyle(color: Colors.black87),
                                        ),
                                        onTap: () {
                                          _imgFromCamera();
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          color: Colors.green,
                        ),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  _imgFromCamera() async {
    var image = await ImagePicker.platform
        .pickImage(source: ImageSource.camera, imageQuality: 50);
    //  print('sdkhgfdsokjh${File(image.path).toString()}');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('image', File(image.path).toString());
    setState(() {
      widget.image = File(image.path);
    });
  }

  _imgFromGallery() async {
    var image = await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('image', File(image.path).toString());
    setState(() {
      widget.image = File(image.path);
    });
  }
}
