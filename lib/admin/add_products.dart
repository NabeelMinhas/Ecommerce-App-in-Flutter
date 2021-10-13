import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pro/admin/Admin_drawer.dart';
import 'package:pro/admin/dashboard.dart';

class add_products extends StatefulWidget {
  add_products({Key? key}) : super(key: key);

  @override
  _add_productsState createState() => _add_productsState();
}

class _add_productsState extends State<add_products> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: product_form(),
    );
  }
}

class product_form extends StatefulWidget {
  product_form({Key? key, this.receivedMapEdit, this.doc}) : super(key: key);
  Map<String, dynamic>? receivedMapEdit;
  String? doc;
  @override
  _product_formState createState() => _product_formState();
}

class _product_formState extends State<product_form> {
  //firebase_storage instance creation
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  // image picker code
  File? _image;
  Future<void> chooseFile() async {
    var _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(_imageFile.path);
    });
  }

  String name = '';
  // upload image to firebase storage and downloading url function call here
  Future<void> uploadFile() async {
    String filePath = 'product/images/${DateTime.now()}.png';
    name = filePath;
    await firebase_storage.FirebaseStorage.instance
        .ref(filePath)
        .putFile(_image);
    downloadURLExample(); // generate the url
  }

  // //image url download
  static String url = '';
  Future<void> downloadURLExample() async {
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref(name)
        .getDownloadURL();
    url = downloadURL;
    print(downloadURL);
    if (widget.receivedMapEdit == null) {
      addUser();
    } else {
      updateUser();
    }
  }

  //derop down button assets strat
  var _currency = ['Perfumes', 'Makeup', 'Soaps & Shampo', 'others'];
  var _currentItemSelected = 'Makeup';
  //drop down assets end

  // from assets  start
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controllerTitle = TextEditingController();
  TextEditingController _controllerPrice = TextEditingController();
  TextEditingController _controllerQuantity = TextEditingController();
  TextEditingController _controllerDescription = TextEditingController();
  TextEditingController _controllerCatagory = TextEditingController();
  TextEditingController _controllerDate = TextEditingController();
  String warning_image = '';
  // form assets end

  //function to check that a string contains only numberic or not
  bool _isNumeric(String result) {
    if (result == null) {
      return false;
    }
    return double.tryParse(result) != null;
  }

  // cloud firestore data uploading code  start from here
  CollectionReference users = FirebaseFirestore.instance.collection('products');
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final String title;
  late final String price;
  late final String description;
  late final String quantity;
  late final String catagory;
  late final String image_name;
  late final String salequantity;
  Future<void> addUser() async {
    salequantity = '0';
    title = _controllerTitle.text;
    price = _controllerPrice.text;
    description = _controllerDescription.text;
    quantity = _controllerQuantity.text;
    catagory = _currentItemSelected;
    // image_url = url;

    // Call the user's CollectionReference to add a new user
    return await users
        .add({
          'title': title,
          'price': price,
          'description': description,
          'quantity': quantity,
          'catagory': catagory,
          'image_name': url,
          'salequantity': salequantity,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

//load values for edit
  void load_values_for_edit() {
    _controllerTitle.text = widget.receivedMapEdit!['title'];
    _controllerPrice.text = widget.receivedMapEdit!['price'];
    _controllerQuantity.text = widget.receivedMapEdit!['quantity'];
    _controllerDescription.text = widget.receivedMapEdit!['description'];
    _currentItemSelected = widget.receivedMapEdit!['catagory'];
  }

  CollectionReference product_edit =
      FirebaseFirestore.instance.collection('products');

  Future<void> updateUser() {
    title = _controllerTitle.text;
    price = _controllerPrice.text;
    description = _controllerDescription.text;
    quantity = _controllerQuantity.text;
    catagory = _currentItemSelected;

    return product_edit
        .doc(widget.doc)
        .update({
          'title': title,
          'price': price,
          'description': description,
          'quantity': quantity,
          'catagory': catagory,
          'image_name': url,
          // 'salequantity': salequantity,
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  void initState() {
    if (widget.receivedMapEdit != null) {
      load_values_for_edit();
      print(widget.doc);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Products',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.pink,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    topLeft: Radius.circular(30)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //title field
                      TextFormField(
                        controller: _controllerTitle,
                        decoration: const InputDecoration(
                          icon: const Icon(
                            Icons.person,
                            color: Color(0xFFeb51b7),
                          ),
                          hintText: 'Enter the product title',
                          focusColor: Color(0xFFeb51b7),
                          labelText: 'Title',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter product title';
                          }
                          return null;
                        },
                      ),
                      //price field
                      TextFormField(
                        controller: _controllerPrice,
                        // obscureText: true,
                        decoration: const InputDecoration(
                          icon: const Icon(
                            Icons.lock,
                            color: Color(0xFFeb51b7),
                          ),
                          hintText: 'Enter the price for one item',
                          labelText: 'Price',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter price for one item';
                          } else if (_isNumeric(value) == false) {
                            return 'Please enter only numbers';
                          }
                          return null;
                        },
                      ),
                      //quatity field
                      TextFormField(
                        controller: _controllerQuantity,
                        decoration: const InputDecoration(
                          icon: const Icon(
                            Icons.person,
                            color: Color(0xFFeb51b7),
                          ),
                          hintText: 'Enter the product quantity in digits',
                          focusColor: Color(0xFFeb51b7),
                          labelText: 'Quantity',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some numbers';
                          } else if (_isNumeric(value) == false) {
                            return 'please enter some numbers';
                          }
                          return null;
                        },
                      ),
                      //description field
                      TextFormField(
                        controller: _controllerDescription,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          icon: const Icon(
                            Icons.person,
                            color: Color(0xFFeb51b7),
                          ),
                          hintText: 'Enter the product description',
                          focusColor: Color(0xFFeb51b7),
                          labelText: 'Description',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some description';
                          }
                          return null;
                        },
                      ),

                      Padding(
                        padding: EdgeInsets.fromLTRB(40.0, 0, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            DropdownButton<String>(
                              items: _currency.map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem),
                                );
                              }).toList(),
                              onChanged: (String? newValueSelected) {
                                setState(() {
                                  this._currentItemSelected = newValueSelected!;
                                });
                              },
                              value: _currentItemSelected,
                            ),
                            IconButton(
                              onPressed: () {
                                chooseFile();
                                setState(() {
                                  warning_image = '';
                                });
                              },
                              icon: Image.asset('assets/icons/img.png'),
                              iconSize: 50,
                            ),
                          ],
                        ),
                      ),
                      //image picking warning
                      Padding(
                        padding: const EdgeInsets.only(left: 150.0, top: 0),
                        child: Text(
                          warning_image,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      new Container(
                        padding: const EdgeInsets.only(left: 150.0, top: 40.0),
                        // ignore: deprecated_member_use
                        child: new RaisedButton(
                            color: Color(0xFFeb51b7),
                            child: const Text(
                              'Upload',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              if (_image == null) {
                                setState(() {
                                  warning_image = 'kindly choose an image';
                                });
                              }
                              // It returns true if the form is valid, otherwise returns false
                              if (_formKey.currentState!.validate() &&
                                  _image != null) {
                                uploadFile();
                                //upload image to firebase storage
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => dashboard()));
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      drawer: MyAdminDrawer(),
    );
  }
}
