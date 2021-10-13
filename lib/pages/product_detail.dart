// import 'dart:html';

// import 'dart:html';

// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:pro/admin/add_products.dart';
import 'package:pro/admin/dashboard.dart';
import 'package:pro/drawer.dart';
import 'package:pro/pages/cart_page.dart';
import 'package:pro/pages/checkout.dart';
import 'package:pro/pages/home.dart';
import 'package:pro/pages/product_page.dart';

class product_detail extends StatefulWidget {
  product_detail({Key? key, required this.receivedMap, required this.doc_id})
      : super(key: key);
  Map<String, dynamic> receivedMap;
  String doc_id;

  @override
  _product_detailState createState() => _product_detailState();
}

class _product_detailState extends State<product_detail> {
  bool show_more = false;
  Color textcolor = Colors.blue;
  TextEditingController _controllerquantity = TextEditingController();
  // List<order> orderlist = [];
  List<Map<String, dynamic>> lst = [];
  String textvalue = '1';
  User? user = FirebaseAuth.instance.currentUser;
//delete a document from firebase
  CollectionReference product_delete =
      FirebaseFirestore.instance.collection('products');
  Future<void> deleteProduct(String doc_id) {
    return product_delete
        .doc(doc_id)
        .delete()
        .then((value) => print("product Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are You Want to delete this product permenantly.'),
                // Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                deleteProduct(widget.doc_id);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => home_page()));
                // Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Expanded(child: Text(widget.receivedMap['title'])),
          actions: <Widget>[
            Stack(children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                iconSize: 30,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => cart_page(
                                lst_cart: lst,
                              )));
                },
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: new BoxDecoration(
                    color: Colors.yellow,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      lst.length.toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              )
            ])
          ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //image container
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                      color: Colors.red,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Image.network(widget.receivedMap['image_name']),
              ),
            ),
            //description, price and quantity container
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Description',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                    Container(
                      height: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: new BoxDecoration(
                                color: Colors.yellow,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  int int_textvalue = int.parse(textvalue);
                                  if (int_textvalue ==
                                      int.parse(
                                          widget.receivedMap['quantity'])) {
                                  } else {
                                    int_textvalue = int_textvalue + 1;
                                  }

                                  setState(() {
                                    textvalue = int_textvalue.toString();
                                  });
                                },
                                icon: Icon(
                                  Icons.arrow_upward_rounded,
                                ),
                              ),
                            ),
                            Text(
                              textvalue,
                              style: TextStyle(fontSize: 20),
                            ),
                            Container(
                              decoration: new BoxDecoration(
                                color: Colors.yellow,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                  onPressed: () {
                                    int int_textvalue = int.parse(textvalue);
                                    if (int_textvalue == 1) {
                                    } else {
                                      int_textvalue = int_textvalue - 1;
                                      setState(() {
                                        textvalue = int_textvalue.toString();
                                      });
                                    }
                                  },
                                  icon: Icon(Icons.arrow_downward)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      "Rs ${int.parse(widget.receivedMap['price']) * int.parse(textvalue)}",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 28),
                    ),
                  ],
                ),
              ),
            ),

            //description box content box
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.red,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        'data lor  data lor  data lor  data lor data lor  data lor  data lor  data lor data lor  data lor  data lor  data lor data lor  data lor  data lor  data lor data lor  data lor  data lor  data lor data lor  data lor  data lor  data lor',
                        maxLines: show_more ? 100 : 2,
                        textAlign: TextAlign.start,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            show_more = !show_more;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              show_more ? 'show less' : 'show more',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 20),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            // for some spacing
            SizedBox(
              height: 15,
            ),
            //add to cart
            FlatButton(
                onPressed: () {
                  lst.add(widget.receivedMap);
                  setState(() {
                    lst.length.toString();
                  });
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => home_page()));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.pink,
                      border: Border.all(
                        color: Colors.red,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                          size: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Add To Cart',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                )),
            // for spacing
            SizedBox(
              height: 15,
            ),
            // check out
            FlatButton(
                onPressed: () {
                  widget.receivedMap['salequantity'] = textvalue;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => check_out(
                              checkout_receivedMap: widget.receivedMap)));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.pink,
                      border: Border.all(
                        color: Colors.red,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                          size: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Check Out',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                )),
            SizedBox(
              height: 10,
            ),

            //edit product section
            Container(
              child: ((user != null) &&
                      (user!.email == 'nabeelshafiq223@gmail.com'))
                  ? FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => product_form(
                                      receivedMapEdit: widget.receivedMap,
                                      doc: widget.doc_id,
                                    )));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.pink,
                            border: Border.all(
                              color: Colors.red,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 30,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Edit Product',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ))
                  : Container(),
              // for spacing
            ),
            SizedBox(
              height: 10,
            ),
            //edit product section
            Container(
              child: ((user != null) &&
                      (user!.email == 'nabeelshafiq223@gmail.com'))
                  ? FlatButton(
                      onPressed: () {
                        _showMyDialog();
                        // deleteProduct(widget.doc_id);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => home_page()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.pink,
                            border: Border.all(
                              color: Colors.red,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 30,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Delete Product',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ))
                  : Container(),
              // for spacing
            )
          ],
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}
