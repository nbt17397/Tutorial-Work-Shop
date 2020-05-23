import 'dart:io';

import 'package:fashion_story/models/fashion.dart';
import 'package:fashion_story/services/database_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class AddFashion extends StatefulWidget {
  @override
  _AddFashionState createState() => _AddFashionState();
}

class _AddFashionState extends State<AddFashion> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  File selectedImage;
  FocusNode _moneyNode;
  TextEditingController _nameController;
  TextEditingController _moneyController;
  TextEditingController _descController;
  TextEditingController _numberController;
  TextEditingController _sizeController;
  String dropdownCategory = 'Áo thun';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: '');
    _moneyController = TextEditingController(text: '');
    _descController = TextEditingController(text: '');
    _numberController = TextEditingController(text: '');
    _sizeController = TextEditingController(text: '');
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          child: Image(
            height: 140,
            image: AssetImage('assets/images/logo.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.file_upload),
              onPressed: () {
                _setupAdd();
              })
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Form(
            key: _key,
            autovalidate: true,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    getImage();
                  },
                  child: Container(
                    child: selectedImage != null
                        ? Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            height: 190,
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.file(
                                selectedImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            height: 190,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(15)),
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.black45,
                            ),
                          ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      DropdownButton<String>(
                        isExpanded: true,
                        value: dropdownCategory,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold),
                        underline: Container(
                          height: 2,
                          color: Colors.blueAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownCategory = newValue;
                          });
                        },
                        items: <String>[
                          'Áo thun',
                          'Áo khoác',
                          'Áo Sơ mi',
                          'Quần short',
                          'Balo',
                          'Giày nam'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Center(child: Text(value)),
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          FocusScope.of(context).requestFocus(_moneyNode);
                        },
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.length < 5)
                            return "Name cannot be empty";
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Name', border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          FocusScope.of(context).requestFocus(_moneyNode);
                        },
                        controller: _moneyController,
                        validator: (value) {
                          if (value.length < 4) return "Money cannot be empty";
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Money', border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          FocusScope.of(context).requestFocus(_moneyNode);
                        },
                        controller: _sizeController,
                        validator: (value) {
                          if (value.length < 4) return "Size cannot be empty";
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Size', border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          FocusScope.of(context).requestFocus(_moneyNode);
                        },
                        controller: _numberController,
                        validator: (value) {
                          if (value.length < 4) return "number cannot be empty";
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Number', border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        focusNode: _moneyNode,
                        controller: _descController,
                        maxLines: 3,
                        decoration: InputDecoration(
                            labelText: 'Desc', border: OutlineInputBorder()),
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  _setupAdd() async {
    if (_key.currentState.validate()) {
      try {
        if (selectedImage != null) {
          StorageReference firebaseStorageRef = FirebaseStorage.instance
              .ref()
              .child("fashionImage")
              .child("${randomAlphaNumeric(9)}.jpg");
          final StorageUploadTask task =
              firebaseStorageRef.putFile(selectedImage);
          var downloadUrl = await (await task.onComplete).ref.getDownloadURL();
          if (dropdownCategory == 'Áo thun') {
            await FirestoreService().addAoThun(Fashion(
              categories: dropdownCategory,
              count: 1,
              description: _descController.text,
              favorite: false,
              imageUrl: downloadUrl,
              name: _nameController.text,
              screenshots: null,
              size: _sizeController.text,
              money: _moneyController.hashCode,
              number: _numberController.hashCode,
            ));
          } else if (dropdownCategory == 'Áo khoác') {
            await FirestoreService().addAoThun(Fashion(
              categories: dropdownCategory,
              count: 1,
              description: _descController.text,
              favorite: false,
              imageUrl: downloadUrl,
              name: _nameController.text,
              screenshots: null,
              size: _sizeController.text,
              money: _moneyController.hashCode,
              number: _numberController.hashCode,
            ));
          } else if (dropdownCategory == 'Áo sơ mi') {
            await FirestoreService().addAoThun(Fashion(
              categories: dropdownCategory,
              count: 1,
              description: _descController.text,
              favorite: false,
              imageUrl: downloadUrl,
              name: _nameController.text,
              screenshots: null,
              size: _sizeController.text,
              money: _moneyController.hashCode,
              number: _numberController.hashCode,
            ));
          }
        }
        Navigator.pop(context);
      } catch (e) {
        print(e);
      }
    }
  }
}
