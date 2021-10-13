import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pro/admin/dashboard.dart';
import 'package:pro/authentication/login.dart';
import 'package:pro/pages/catagories.dart';
import 'package:pro/pages/home.dart';
import 'package:pro/pages/product_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

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
              color: Colors.pink,
            ),
            child: SingleChildScrollView(
              child: Container(
                  child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: (user != null)
                        ? Column(
                            children: [
                              Text(
                                'Hello ',
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                user.email,
                                // 'hell',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          )
                        : FlatButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => login_Screen()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.red,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.login,
                                      color: Colors.pink,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Login ',
                                      style: TextStyle(
                                          color: Colors.pink, fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => home_page()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.red,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
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
          ),
          Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('All Product',
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
                      MaterialPageRoute(builder: (context) => product_page()));
                },
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                'Product Catagories',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('Shampoo & Soap',
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
                          builder: (context) => catagory(
                                received: "Soaps & Shampo",
                              )));
                },
              ),
            ),
          ),
          Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('Perfumes',
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
                          builder: (context) => catagory(
                                received: 'Perfumes',
                              )));
                },
              ),
            ),
          ),
          Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('Makeup',
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
                          builder: (context) => catagory(
                                received: 'Makeup',
                              )));
                },
              ),
            ),
          ),
          Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('Others',
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
                          builder: (context) => catagory(
                                received: 'Others',
                              )));
                },
              ),
            ),
          ),
          Card(
            color: Colors.blue,
            elevation: 10,
            child: Container(
              child: (user != null)
                  ? ListTile(
                      title: Text('log out',
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => home_page()));
                      },
                    )
                  : Container(),
            ),
          ),
          Container(
            child: ((user != null) &&
                    (user.email == 'nabeelshafiq223@gmail.com'))
                ? Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text('Dashboard',
                            style:
                                TextStyle(color: Colors.black, fontSize: 20)),
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
                                  builder: (context) => dashboard()));
                        },
                      ),
                    ),
                  )
                : Container(),
          )
        ],
      ),
    );
  }
}
