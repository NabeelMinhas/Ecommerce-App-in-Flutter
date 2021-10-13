import 'package:flutter/material.dart';
import 'package:pro/admin/Admin_drawer.dart';
import 'package:pro/admin/Complete_Order.dart';
import 'package:pro/admin/New_orders.dart';
import 'package:pro/admin/Orders_in_progress.dart';
import 'package:pro/admin/Spam_order.dart';
import 'package:pro/admin/Some_Statistics.dart';
// import 'package:pro/admin/add_products.dart';
import 'package:pro/admin/add_products.dart';
import 'package:pro/authentication/register.dart';
import 'package:pro/drawer.dart';

class dashboard extends StatefulWidget {
  dashboard({Key? key}) : super(key: key);

  @override
  _dashboardState createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // app bar code is here
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Center(
            child: Row(
          children: [
            Text(
              " Welcome",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              " Admin",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ],
        )),
      ),
      // body widget is define below
      body: _body(),
      // drawer widget is define on drawer file
      drawer: MyAdminDrawer(),
    );
  }
}

// body widget
class _body extends StatefulWidget {
  _body({Key? key}) : super(key: key);

  @override
  __bodyState createState() => __bodyState();
}

class Choice {
  final String title;
  final IconData icon;
  const Choice({required this.title, required this.icon});
}

// list to use as data in grid element
const List<Choice> choices = const <Choice>[
  const Choice(title: 'New Orders', icon: Icons.new_releases_outlined),
  const Choice(title: 'Orders in progress', icon: Icons.work_outline_outlined),
  const Choice(title: 'Complete Order', icon: Icons.star_outline_sharp),
  const Choice(title: 'Spam Orders', icon: Icons.dangerous_outlined),
  const Choice(title: 'Add product', icon: Icons.add),
  const Choice(title: 'Statistics', icon: Icons.message_outlined)
];

class __bodyState extends State<_body> {
  late final Choice choice;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // color: Colors.grey.withOpacity(0.1),
        color: Colors.blue,
        // color: Color(0xffFDD9E0),
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 8.0,
              children: List.generate(choices.length, (index) {
                return Center(
                  // selectCard widget is define below
                  child: SelectCard(choice: choices[index]),
                );
              })),
        ));
  }
}

class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, required this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    final TextStyle? textStyle = Theme.of(context).textTheme.display1;
    return GestureDetector(
      onTap: () {
        if (choice.title == 'New Orders') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => New_orders()),
          );
        } else if (choice.title == 'Orders in progress') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Orders_in_progress()),
          );
        } else if (choice.title == 'Complete Order') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Complete_order()),
          );
        } else if (choice.title == 'Spam Orders') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Spam_order()),
          );
        } else if (choice.title == 'Add product') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => add_products()),
          );
        } else if (choice.title == 'Statistics') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Statistics()),
          );
        }
      },
      child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(100))),
          elevation: 15,
          color: Colors.white,
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Icon(choice.icon, size: 50.0, color: Colors.pink)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      choice.title,
                      style: TextStyle(color: Colors.black, fontSize: 30),
                    ),
                  ),
                ]),
          )),
    );
  }
}
