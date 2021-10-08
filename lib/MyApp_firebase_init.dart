// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:pro/admin/Complete_Order.dart';
import 'package:pro/admin/New_orders.dart';
import 'package:pro/admin/Orders_in_progress.dart';
import 'package:pro/admin/add_products.dart';
import 'package:pro/admin/dashboard.dart';
import 'package:pro/authentication/login.dart';
import 'package:pro/authentication/register.dart';
import 'package:pro/drawer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pro/pages/home.dart';
import 'package:pro/pages/product_detail.dart';
import 'package:pro/pages/product_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /* *********************************Firebase app initialization************************************** */

  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      return Text('error is    $_error');
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Text('loading');
    }

    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFFeb51b7),
        // primarySwatch: Colors.pink,
      ),
      title: 'Home',
      home: Scaffold(
        body: home_page_section(),
        drawer: MyDrawer(),
      ),
    );
  }
}
