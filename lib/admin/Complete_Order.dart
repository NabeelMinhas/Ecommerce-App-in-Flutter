import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pro/admin/Admin_drawer.dart';

class Complete_order extends StatefulWidget {
  Complete_order({Key? key}) : super(key: key);

  @override
  _Complete_orderState createState() => _Complete_orderState();
}

class _Complete_orderState extends State<Complete_order> {
  //firestore instance creation
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //getting the complete_orders collection data in complete_order_stream
  final Stream<QuerySnapshot> _complete_order_Stream =
      FirebaseFirestore.instance.collection('complete_orders').snapshots();

  //delete a document from firebase
  CollectionReference order_delete =
      FirebaseFirestore.instance.collection('complete_orders');

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
        title: Text('Complete Order'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _complete_order_Stream,
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
                                          deleteUser(document.id);
                                          // print(document.id);
                                        },
                                        child: Text(
                                          'Delete Permanentaly',
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
