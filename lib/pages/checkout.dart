// import 'dart:html';
import 'package:date_format/date_format.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pro/drawer.dart';
import 'package:pro/pages/home.dart';

class check_out extends StatefulWidget {
  check_out({Key? key, required this.checkout_receivedMap}) : super(key: key);
  Map<String, dynamic> checkout_receivedMap;
  // String salequantity;
  @override
  _check_outState createState() => _check_outState();
}

class _check_outState extends State<check_out> {
  bool is_form = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller_name = TextEditingController();
  TextEditingController _controller_phone = TextEditingController();
  TextEditingController _controller_address = TextEditingController();

  // uploading order to firebase
  CollectionReference order = FirebaseFirestore.instance.collection('orders');
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Future<void> update_product() async {
  //   return order
  //       .doc('ABC123')
  //       .update({'company': 'Stokes and Sons'})
  //       .then((value) => print("User Updated"))
  //       .catchError((error) => print("Failed to update user: $error"));
  // }

  Future<void> add_order() async {
    final String name = _controller_name.text;
    final String phone = _controller_phone.text;
    final String address = _controller_address.text;
    // DateTime date = new DateTime.now();
    // DateTime justdate = new DateTime(date.year, date.month, date.day);
    // image_url = url;
    // DateFormat.yMMMd().format(DateTime.now());
    final formattedStr = formatDate(DateTime.now(), [
      dd,
      '/',
      mm,
      '/',
      yyyy,
    ]);
    final order_month = formatDate(DateTime.now(), [
      // dd,
      // '/',
      mm,
      // '/',
      // yyyy,
    ]);
    final order_year = formatDate(DateTime.now(), [
      // dd,
      // '/',
      // mm,
      // '/',
      yyyy,
    ]);
    // Call the user's CollectionReference to add a new user
    return await order
        .add({
          'name': name,
          'phone': phone,
          'address': address,
          'product_title': widget.checkout_receivedMap['title'],
          'price_per_piece': widget.checkout_receivedMap['price'],
          'salequantity': widget.checkout_receivedMap['salequantity'],
          'order_date': formattedStr,
          'order_month': order_month,
          'order_year': order_year
        })
        .then((value) => print("order Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  //function to check that a string contains only numberic or not
  bool _isNumeric(String result) {
    if (result == null) {
      return false;
    }
    return double.tryParse(result) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Checkout'),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              //order detail container
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        topLeft: Radius.circular(30)),
                  ),
                  elevation: 10,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Order Details',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Product name:',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              widget.checkout_receivedMap['title'],
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'price per piece:',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              widget.checkout_receivedMap['price'],
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Quantity:',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              widget.checkout_receivedMap['salequantity'],
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Total Price:',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "Rs ${int.parse(widget.checkout_receivedMap['price']) * int.parse(widget.checkout_receivedMap['salequantity'])}",
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    is_form = true;
                                  });
                                },
                                child: Text(
                                  'Proceed Order',
                                  style: TextStyle(fontSize: 20),
                                ),
                                style: ElevatedButton.styleFrom(
                                    shape: StadiumBorder()),
                              ),
                            ])
                      ],
                    ),
                  ),
                ),
              ),
              // order form container
              Container(
                  child: (is_form)
                      ? Card(
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Fill the order form',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.red),
                                      ),
                                    ],
                                  ),
                                  //name
                                  TextFormField(
                                    controller: _controller_name,
                                    decoration: const InputDecoration(
                                      icon: const Icon(
                                        Icons.person,
                                        color: Color(0xFFeb51b7),
                                      ),
                                      hintText: 'Enter the your name',
                                      focusColor: Color(0xFFeb51b7),
                                      labelText: 'Name',
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your name';
                                      }
                                      return null;
                                    },
                                  ),
                                  //phone number
                                  TextFormField(
                                      controller: _controller_phone,
                                      decoration: const InputDecoration(
                                        icon: const Icon(
                                          Icons.phone,
                                          color: Color(0xFFeb51b7),
                                        ),
                                        hintText: 'Enter the phone number',
                                        labelText: 'Phone number',
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter the phone number';
                                        } else if (_isNumeric(value) == false) {
                                          return 'Please enter only numbers space is not allowed';
                                        } else if (value.length != 11) {
                                          return 'enter 11 digit phone number like 03*********';
                                        }
                                        // }
                                        return null;
                                      }),
                                  //address
                                  TextFormField(
                                      controller: _controller_address,
                                      decoration: const InputDecoration(
                                        icon: const Icon(
                                          Icons.home,
                                          color: Color(0xFFeb51b7),
                                        ),
                                        hintText: 'Enter the address',
                                        labelText: 'Adress',
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter the address';
                                        }
                                        return null;
                                      }),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        new Container(
                                          child: new RaisedButton(
                                              color: Color(0xFFeb51b7),
                                              child: const Text(
                                                'Submit Order',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                // It returns true if the form is valid, otherwise returns false
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  add_order();
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              home_page()));
                                                }
                                              }),
                                        ),
                                        new Container(
                                          child: new RaisedButton(
                                              color: Color(0xFFeb51b7),
                                              child: const Text(
                                                'cancel',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  is_form = !is_form;
                                                });
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : null),
            ],
          ),
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}
