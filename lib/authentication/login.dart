import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pro/admin/dashboard.dart';
import 'package:pro/authentication/register.dart';
import 'package:pro/drawer.dart';
import 'package:pro/pages/home.dart';

class login_Screen extends StatefulWidget {
  login_Screen({Key? key}) : super(key: key);

  @override
  _login_ScreenState createState() => _login_ScreenState();
}

class _login_ScreenState extends State<login_Screen> {
  FirebaseAuth auth = FirebaseAuth.instance; //instance

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Login',
            style: TextStyle(fontSize: 20),
          ),
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

// ***************************form code*****************//

class My_Form extends StatefulWidget {
  My_Form({Key? key}) : super(key: key);

  @override
  _My_FormState createState() => _My_FormState();
}

class _My_FormState extends State<My_Form> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  String userfound = " ";
  String passwordWrong = " ";
  // String state = 'not_ok';
  void log() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      userfound = ' ';
      passwordWrong = '';
      if (e.code == 'invalid-email') {
        userfound = "user not found kindly register";
        // setState(() {});
      } else if (e.code == 'wrong-password') {
        passwordWrong = "Your Password is wrong";
        // setState(() {});
      }
    }
  }

  bool usercheck() {
    User? user = FirebaseAuth.instance.currentUser;
    if (_controllerEmail.text == 'nabeelshafiq223@gmail.com' &&
        _controllerPassword.text == 'Rajpoot') {
      return true;
    }
    return false;
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
              controller: _controllerEmail,
              decoration: const InputDecoration(
                icon: const Icon(
                  Icons.person,
                  color: Color(0xFFeb51b7),
                ),
                hintText: 'Enter your Email',
                focusColor: Color(0xFFeb51b7),
                labelText: 'Email',
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
                  return 'Please enter valid password';
                }
                return null;
              },
            ),
            // SizedBox(),

            Text(
              passwordWrong,
              style: TextStyle(color: Colors.red),
            ),
            Text(
              userfound,
              style: TextStyle(color: Colors.red),
            ),
            new Container(
              padding: const EdgeInsets.only(left: 150.0, top: 40.0),
              // ignore: deprecated_member_use
              child: new RaisedButton(
                  color: Color(0xFFeb51b7),
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    // It returns true if the form is valid, otherwise returns false
                    if (_formKey.currentState!.validate()) {
                      log();
                      setState(() {});
                      bool check = false;
                      check = usercheck();

                      if (check) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => dashboard()));
                      } else if (FirebaseAuth.instance.currentUser != null) {
                        // wrong call in wrong place!
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => home_page()));
                      }
                    }
                  }),
            ),
            InkWell(
              child: Text(
                'Registration',
                style:
                    TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => register_Screen()));
              },
            )
          ],
        ),
      ),
    );
  }
}
