// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pro/drawer.dart';
import 'package:pro/pages/catagories.dart';
import 'package:pro/pages/product_detail.dart';
import 'package:pro/pages/product_page.dart';

class home_page extends StatelessWidget {
  home_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: home_page_section(),
      drawer: MyDrawer(),
    );
  }
}

class home_page_section extends StatefulWidget {
  home_page_section({Key? key}) : super(key: key);

  @override
  _home_page_sectionState createState() => _home_page_sectionState();
}

class _home_page_sectionState extends State<home_page_section> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // height: MediaQuery.of(context).size.height,
        color: Colors.grey[100],
        child: Expanded(
          child: Column(
            children: [
              Stack(children: <Widget>[
                // Background with gradient
                Container(
                    decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(0),
                            bottomRight: Radius.circular(150.0),
                            topLeft: Radius.circular(0),
                            bottomLeft: Radius.circular(150.0))),
                    height: MediaQuery.of(context).size.height * 0.3),
                //Above card
                Container(
                  height: 300,
                  child: Card(
                      elevation: 20.0,
                      margin:
                          EdgeInsets.only(left: 20.0, right: 20.0, top: 90.0),
                      child: Container(
                        child: Expanded(
                            child: Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Product Categories',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      catagory(
                                                        received: 'Makeup',
                                                      )));
                                        },
                                        icon: Image.asset(
                                            'assets/icons/cosmetics.png'),
                                        iconSize: 100,
                                      ),
                                      Text(
                                        'Cosmetics',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      catagory(
                                                        received: 'Perfumes',
                                                      )));
                                        },
                                        icon: Image.asset(
                                            'assets/icons/perfume.png'),
                                        iconSize: 100,
                                      ),
                                      Text(
                                        'Perfumes',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      catagory(
                                                        received:
                                                            "Soaps & Shampo",
                                                      )));
                                        },
                                        icon: Image.asset(
                                            'assets/icons/soap.png'),
                                        iconSize: 100,
                                      ),
                                      Text(
                                        'Soap',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                      )),
                ),
                // Positioned to take only AppBar size

                Positioned(
                  top: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: AppBar(
                    // Add AppBar here only
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    title: Center(
                      child: Text(
                        "Cosmetic Shop",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                ),
              ]),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 4.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(150.0),
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(150.0))),
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 8.0, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // SizedBox(height: 20),
                              Text('Some Products',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30)),
                            ],
                          ),
                        ),
                        Container(

                            // color: Colors.pink[300],
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                              child: new_product(),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 10),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => product_page()));
                              },
                              child: Text('See More',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class new_product extends StatefulWidget {
  new_product({Key? key}) : super(key: key);

  @override
  _new_productState createState() => _new_productState();
}

class _new_productState extends State<new_product> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('products').limit(4).snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
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
                    builder: (context) => product_detail(
                      receivedMap: data,
                      doc_id: document.id,
                    ),
                  ),
                );
              },
              child: Container(
                child: Card(
                  elevation: 10,
                  child: ListTile(
                    leading:
                        //  ConstrainedBox(
                        //   constraints: BoxConstraints(
                        //     minWidth: 150,
                        //     minHeight: 100,
                        //     maxWidth: 154,
                        //     maxHeight: 104,
                        //   ),
                        //   child:
                        Image.network(
                      data['image_name'],
                      fit: BoxFit.fill,
                    ),
                    // ),
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
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
