import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pro/drawer.dart';
import 'package:pro/pages/product_detail.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class product_page extends StatefulWidget {
  product_page({Key? key}) : super(key: key);

  @override
  _product_pageState createState() => _product_pageState();
}

class _product_pageState extends State<product_page> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('products').snapshots();

  @override
  // late final Choice choice;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Products',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => product_detail(receivedMap: data),
                    ),
                  );
                },
                child: Card(
                  elevation: 10,
                  child: ListTile(
                    leading: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 100,
                        minHeight: 300,
                        maxWidth: 104,
                        maxHeight: 304,
                      ),
                      child: Image.network(
                        data['image_name'],
                        fit: BoxFit.fill,
                      ),
                    ),
                    title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${data['title']}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            'Rs ${data['price']}',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          )
                        ]),
                    subtitle: Text(
                      data['description'],
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
      drawer: MyDrawer(),
    );
  }
}
