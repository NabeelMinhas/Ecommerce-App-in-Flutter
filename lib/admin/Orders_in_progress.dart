import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pro/admin/Admin_drawer.dart';
import 'package:pro/admin/Complete_Order.dart';

class Orders_in_progress extends StatefulWidget {
  Orders_in_progress({Key? key}) : super(key: key);

  @override
  _Orders_in_progressState createState() => _Orders_in_progressState();
}

class _Orders_in_progressState extends State<Orders_in_progress> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('proceed_orders').snapshots();
  // uploading order  to firebase proceed collection
  CollectionReference complete_orders =
      FirebaseFirestore.instance.collection('complete_orders');

  Future<void> Add_to_complete_order(Map<String, dynamic> data) async {
    final String name = data['name'];
    final String phone = data['phone'];
    final String address = data['address'];
    final String product_title = data['product_title'];
    final String price_per_piece = data['price_per_piece'];
    final String salequantity = data['salequantity'];
    final String order_date = data['order_date'];

    final String order_month = data['order_month'];
    final String order_year = data['order_year'];
    // Call the user's CollectionReference to add a new user
    return await complete_orders
        .add({
          'name': name,
          'phone': phone,
          'address': address,
          'product_title': product_title,
          'price_per_piece': price_per_piece,
          'salequantity': salequantity,
          'order_date': order_date,
          'order_month': order_month,
          'order_year': order_year
        })
        .then((value) => print("order Added to complete order"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  //uploading order to firebase in spam collection

  CollectionReference spam_order =
      FirebaseFirestore.instance.collection('spam_orders');

  Future<void> add_order_to_spam(Map<String, dynamic> data) async {
    final String name = data['name'];
    final String phone = data['phone'];
    final String address = data['address'];
    final String product_title = data['product_title'];
    final String price_per_piece = data['price_per_piece'];
    final String salequantity = data['salequantity'];
    final String order_date = data['order_date'];

    final String order_month = data['order_month'];
    final String order_year = data['order_year'];
    // Call the user's CollectionReference to add a new user
    return await spam_order
        .add({
          'name': name,
          'phone': phone,
          'address': address,
          'product_title': product_title,
          'price_per_piece': price_per_piece,
          'salequantity': salequantity,
          'order_date': order_date,
          'order_month': order_month,
          'order_year': order_year
        })
        .then((value) => print("order Added to spam"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  //delete a document feom firebase
  CollectionReference order_delete =
      FirebaseFirestore.instance.collection('proceed_orders');

  Future<void> deleteUser(String doc_id) {
    return order_delete
        .doc(doc_id)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders in progress'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              // return Text('data');

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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Product Details',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Product name:',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      data['product_title'],
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
                                      data['price_per_piece'],
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
                                      data['salequantity'],
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
                                      "Rs ${int.parse(data['price_per_piece']) * int.parse(data['salequantity'])}",
                                      style: TextStyle(fontSize: 20),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'User Details',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'User Name:',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      data['name'],
                                      style: TextStyle(fontSize: 20),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'User Address:',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      data['address'],
                                      style: TextStyle(fontSize: 20),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'User Phone Number:',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      data['phone'],
                                      style: TextStyle(fontSize: 20),
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
                                      ElevatedButton(
                                        onPressed: () {
                                          Add_to_complete_order(data);
                                          deleteUser(document.id);
                                        },
                                        child: Text(
                                          'Send to complete',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            shape: StadiumBorder()),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          add_order_to_spam(data);
                                          deleteUser(document.id);
                                          // print(document.id);
                                        },
                                        child: Text(
                                          'Send to Spam',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            shape: StadiumBorder()),
                                      ),
                                    ])
                              ],
                            ))))
              ]));
            }).toList());
          }),
      drawer: MyAdminDrawer(),
    );
  }
}
