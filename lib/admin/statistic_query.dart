import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class neworderstatistics extends StatefulWidget {
  neworderstatistics(
      {Key? key,
      required this.date,
      required this.firebase_collection,
      required this.search_attribute})
      : super(key: key);
  String date;
  String search_attribute;
  String firebase_collection;
  @override
  _neworderstatisticsState createState() => _neworderstatisticsState();
}

class _neworderstatisticsState extends State<neworderstatistics> {
  String attribute_search_selector() {
    String attribute = '';
    if (widget.search_attribute == 'Today') {
      attribute = 'order_date';
    } else if (widget.search_attribute == 'This month') {
      attribute = 'order_month';
    } else if (widget.search_attribute == 'This year') {
      attribute = 'order_year';
    }
    return attribute;
  }

  Stream<QuerySnapshot> dat() {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection(widget.firebase_collection)
        .where(attribute_search_selector(), isEqualTo: widget.date)
        .snapshots();
    return _usersStream;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: dat(),
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
            String bill = (int.parse(data['price_per_piece']) *
                    int.parse(data['salequantity']))
                .toString();
            return GestureDetector(
              // onTap: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => product_detail(receivedMap: data),
              //     ),
              //   );
              // },
              child: Container(
                child: Card(
                  elevation: 10,
                  child: ListTile(
                    // leading:
                    //     //  ConstrainedBox(
                    //     //   constraints: BoxConstraints(
                    //     //     minWidth: 150,
                    //     //     minHeight: 100,
                    //     //     maxWidth: 154,
                    //     //     maxHeight: 104,
                    //     //   ),
                    //     //   child:
                    //     Image.network(
                    //   data['image_name'],
                    //   fit: BoxFit.fill,
                    // ),
                    // // ),
                    title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${data['product_title']}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            'Rs ${data['price_per_piece']} x ${data['salequantity']} = $bill',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          )
                        ]),
                    subtitle: Text(
                      data['order_date'],
                      // overflow: TextOverflow.ellipsis,
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
