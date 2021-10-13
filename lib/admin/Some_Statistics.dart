import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:pro/admin/New_orders.dart';
import 'package:pro/admin/statistic_query.dart';
import 'package:pro/pages/product_detail.dart';
// import 'globals.dart' as globals;

class Statistics extends StatefulWidget {
  Statistics({Key? key}) : super(key: key);
  // String a = '12/10/2021';
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  // String da = '12/10/2021';
  String date_return(String newValueSelected) {
    if (newValueSelected == 'Today') {
      dat = formatDate(DateTime.now(), [
        dd,
        '/',
        mm,
        '/',
        yyyy,
      ]);
    } else if (newValueSelected == 'This month') {
      dat = formatDate(DateTime.now(), [
        mm,
      ]);
    } else if (newValueSelected == 'This year') {
      dat = formatDate(DateTime.now(), [
        yyyy,
      ]);
    }
    return dat;
  }

  //derop down button assets strat
  var _currency = ['Today', 'This month', 'This year'];
  var _currentItemSelected = 'Today';
  //drop down assets end
  static String dat = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics'),
        actions: [
          DropdownButton<String>(
            items: _currency.map((String dropDownStringItem) {
              return DropdownMenuItem<String>(
                value: dropDownStringItem,
                child: Text(
                  dropDownStringItem,
                  // style: TextStyle(color: Colors.white),
                ),
              );
            }).toList(),
            onChanged: (String? newValueSelected) {
              setState(() {
                this._currentItemSelected = newValueSelected!;
                // dat = '13/10/2021';
              });
            },
            value: _currentItemSelected,
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Container(
              child: Column(
        children: [
          // new orders section
          SizedBox(
            height: 5,
          ),
          Text(
            'New Orders',
            style: TextStyle(fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                color: Colors.pink,
                height: MediaQuery.of(context).size.height * 0.25,
                child: neworderstatistics(
                  date: date_return(_currentItemSelected),
                  firebase_collection: 'orders',
                  search_attribute: _currentItemSelected,
                )),
          ),

          // progress order
          SizedBox(
            height: 5,
          ),
          Text(
            'Orders in progress',
            style: TextStyle(fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                color: Colors.blue,
                height: MediaQuery.of(context).size.height * 0.25,
                child: neworderstatistics(
                  date: date_return(_currentItemSelected),
                  firebase_collection: 'proceed_orders',
                  search_attribute: _currentItemSelected,
                )),
          ),
          //complete orders
          SizedBox(
            height: 5,
          ),
          Text(
            'Complete Orders',
            style: TextStyle(fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                color: Colors.pink,
                height: MediaQuery.of(context).size.height * 0.25,
                child: neworderstatistics(
                  date: date_return(_currentItemSelected),
                  firebase_collection: 'complete_orders',
                  search_attribute: _currentItemSelected,
                )),
          ),
          FlatButton(
              onPressed: () {
                setState(() {
                  // da = '17/10/0211';
                });
              },
              child: Text('click me'))
        ],
      ))),
    );
  }
}
