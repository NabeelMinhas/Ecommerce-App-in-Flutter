import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pro/pages/home.dart';

import '../drawer.dart';

class register_Screen extends StatefulWidget {
  register_Screen({Key? key}) : super(key: key);

  @override
  _register_ScreenState createState() => _register_ScreenState();
}

class _register_ScreenState extends State<register_Screen> {
  FirebaseAuth auth = FirebaseAuth.instance; //instance

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Registration'),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFFeb51b7),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.all(48.0),
                child: Card(
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: My_Form(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}

// ***************************form code***************** //

class My_Form extends StatefulWidget {
  My_Form({Key? key}) : super(key: key);

  @override
  _My_FormState createState() => _My_FormState();
}

class _My_FormState extends State<My_Form> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _controllerUsername = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  TextEditingController _controllerConPassword = TextEditingController();
  String alreadyEmail = " ";
  String weak = " ";

  void regis() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _controllerUsername.text,
              password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        weak = "the password is so week";
      } else if (e.code == 'email-already-in-use') {
        alreadyEmail = "This email is already register ";
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _controllerUsername,
              decoration: const InputDecoration(
                icon: const Icon(
                  Icons.person,
                  color: Color(0xFFeb51b7),
                ),
                hintText: 'Enter your full UserName',
                focusColor: Color(0xFFeb51b7),
                labelText: 'UserName',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _controllerPassword,
              obscureText: true,
              decoration: const InputDecoration(
                icon: const Icon(
                  Icons.lock,
                  color: Color(0xFFeb51b7),
                ),
                hintText: 'Enter the password',
                labelText: 'Password',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter password';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _controllerConPassword,
              obscureText: true,
              decoration: const InputDecoration(
                icon: const Icon(
                  Icons.lock,
                  color: Color(0xFFeb51b7),
                ),
                hintText: 'Enter the password again',
                labelText: 'Confirm Password',
              ),
              validator: (value) {
                if (value!.isEmpty &&
                    (_controllerConPassword.text != _controllerPassword.text)) {
                  return 'Password does not match ';
                }
                return null;
              },
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              alreadyEmail,
              style: TextStyle(color: Colors.red),
            ),
            new Container(
              padding: const EdgeInsets.only(left: 150.0, top: 40.0),
              // ignore: deprecated_member_use
              child: new RaisedButton(
                color: Color(0xFFeb51b7),
                child: const Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  // It returns true if the form is valid, otherwise returns false
                  if (_formKey.currentState!.validate()) {
                    regis();
                    setState(() {});
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => home_page()));

                    // If the form is valid, display a Snackbar.
                    Scaffold.of(context)
                        // ignore: deprecated_member_use
                        .showSnackBar(SnackBar(
                            content: Text('Registration is in processing.')));
                  }
                },
              ),
            ),
            InkWell(
              child: Text(
                'Sign in',
                style:
                    TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
