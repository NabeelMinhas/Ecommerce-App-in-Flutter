import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pro/admin/Complete_Order.dart';
import 'package:pro/admin/New_orders.dart';
import 'package:pro/admin/Orders_in_progress.dart';
import 'package:pro/admin/Spam_order.dart';
import 'package:pro/admin/add_products.dart';
import 'package:pro/pages/home.dart';

class MyAdminDrawer extends StatelessWidget {
  const MyAdminDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String name = user.email;
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Container(
                child: Column(
              children: [
                Text(
                  'Hello ',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  name,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                FlatButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => home_page()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
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
                              Icons.home,
                              color: Colors.blue,
                              size: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Go to home',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            )),
          ),
          Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('New Order',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
                leading: Icon(
                  Icons.arrow_forward,
                  color: Colors.pink,
                ),
                trailing: Icon(
                  Icons.send,
                  color: Colors.blue,
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => New_orders()));
                },
              ),
            ),
          ),
          Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('Orders in Progress',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
                leading: Icon(
                  Icons.arrow_forward,
                  color: Colors.pink,
                ),
                trailing: Icon(
                  Icons.send,
                  color: Colors.blue,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Orders_in_progress()));
                },
              ),
            ),
          ),
          Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('Complete Order',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
                leading: Icon(
                  Icons.arrow_forward,
                  color: Colors.pink,
                ),
                trailing: Icon(
                  Icons.send,
                  color: Colors.blue,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Complete_order()));
                },
              ),
            ),
          ),
          Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('Spam orders',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
                leading: Icon(
                  Icons.arrow_forward,
                  color: Colors.pink,
                ),
                trailing: Icon(
                  Icons.send,
                  color: Colors.blue,
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Spam_order()));
                },
              ),
            ),
          ),
          Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('Add Products',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
                leading: Icon(
                  Icons.arrow_forward,
                  color: Colors.pink,
                ),
                trailing: Icon(
                  Icons.send,
                  color: Colors.blue,
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => add_products()));
                },
              ),
            ),
          ),
          Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('Feedback',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
                leading: Icon(
                  Icons.arrow_forward,
                  color: Colors.pink,
                ),
                trailing: Icon(
                  Icons.send,
                  color: Colors.blue,
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => New_orders()));
                },
              ),
            ),
          ),
          Card(
            color: Colors.blue,
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('logOut',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
                leading: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
                trailing: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => home_page()));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
