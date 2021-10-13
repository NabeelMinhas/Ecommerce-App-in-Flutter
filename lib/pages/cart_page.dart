import 'package:flutter/material.dart';
import 'package:pro/drawer.dart';
import 'package:pro/pages/checkout.dart';

class cart_page extends StatefulWidget {
  cart_page({Key? key, required this.lst_cart}) : super(key: key);
  List<Map<String, dynamic>> lst_cart;
  @override
  _cart_pageState createState() => _cart_pageState();
}

class _cart_pageState extends State<cart_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your cart'),
      ),
      body: Container(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.lst_cart.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                child: Column(children: [
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
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Product name:',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    widget.lst_cart[index]['title'],
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'price per piece:',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    widget.lst_cart[index]['price'],
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Quantity:',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    widget.lst_cart[index]['salequantity'],
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Total Price:',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    "Rs ${int.parse(widget.lst_cart[index]['price']) * int.parse(widget.lst_cart[index]['salequantity'])}",
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) => check_out(
                                        //             checkout_receivedMap: widget
                                        //                 .lst_cart[index])));
                                      },
                                      child: Text(
                                        'choose Order',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          shape: StadiumBorder()),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          widget.lst_cart
                                              .remove(widget.lst_cart[index]);
                                          print(widget.lst_cart.length);
                                        });
                                      },
                                      child: Text(
                                        'Cancel Order',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          shape: StadiumBorder()),
                                    ),
                                  ])
                            ],
                          ))))
            ]));
          },
        ),
      ),
      drawer: MyDrawer(),
    );
    // Text(widget.lst_cart.length.toString());
  }
}
