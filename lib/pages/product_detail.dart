// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:pro/admin/add_products.dart';
import 'package:pro/drawer.dart';
import 'package:pro/pages/cart_page.dart';
import 'package:pro/pages/checkout.dart';
import 'package:pro/pages/home.dart';
import 'package:pro/pages/product_page.dart';

class product_detail extends StatefulWidget {
  product_detail({Key? key, required this.receivedMap}) : super(key: key);
  Map<String, dynamic> receivedMap;

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
                ))
          ],
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}
