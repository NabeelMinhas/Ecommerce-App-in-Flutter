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
                  print(document.id);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => product_detail(
                        receivedMap: data,
                        doc_id: document.id,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => product_detail(
                                receivedMap: data,
                                doc_id: document.id,
                              ),
                            ));
                      },
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.stretch, // add this
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0),
                            ),
                            child: Image.network(data['image_name'],
                                // width: 300,
                                height: 350,
                                fit: BoxFit.fill),
                          ),
                          ListTile(
                            title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${data['title']}',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    'Rs ${data['price']}',
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                            //  Text('${data['title']}',
                            //     style: TextStyle(
                            //         color: Colors.red,
                            //         fontSize: 30,
                            //         fontWeight: FontWeight.bold)),
                            subtitle: Text(
                              data['description'],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // child: Container(
                //   height: 100,
                //   child: Card(
                //     elevation: 10,
                //     child: ListTile(
                //       leading: ConstrainedBox(
                //         constraints: BoxConstraints(
                //           minWidth: 150,
                //           minHeight: 500,
                //           maxWidth: 154,
                //           maxHeight: 504,
                //         ),
                //         child: Image.network(
                //           data['image_name'],
                //           fit: BoxFit.fill,
                //         ),
                //       ),
                //       title: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Expanded(
                // child: Text(
                //   '${data['title']}',
                //   style: TextStyle(fontWeight: FontWeight.bold),
                //               ),
                //             ),
                //             Text(
                //               'Rs ${data['price']}',
                //               style: TextStyle(
                //                   color: Colors.red,
                //                   fontWeight: FontWeight.bold),
                //             )
                //           ]),
                // subtitle: Text(
                //   data['description'],
                //   overflow: TextOverflow.ellipsis,
                // ),
                //     ),
                //   ),
                // ),
              );
            }).toList(),
          );
        },
      ),
      drawer: MyDrawer(),
    );
  }
}
