import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginPage extends StatefulWidget {
  Function(int) callback;
  LoginPage(this.callback, {super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String username = '';
  late String password = '';
  final _formKey = GlobalKey<FormState>();
  static final validCharacters = RegExp(r'^[a-zA-Z0-9]+$');

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        //handle return button
        onWillPop: () async {
          //Welcome widget
          setState(() {
            widget.callback(0);
          });
          return false;
        },
        child: Form(
            key: _formKey,
            child: Center(
                child: SingleChildScrollView(
                    child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 300,
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Missing Field';
                        } else if (!validCharacters.hasMatch(value)) {
                          return 'Invalid Input';
                        }
                        return null;
                      },
                      obscureText: false,
                      decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'username'),
                      onChanged: (value) {
                        setState(() {
                          username = value;
                        });
                      },
                    )),
                Container(
                    width: 300,
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Missing Field';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'password'),
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    )),
                InkWell(
                    onTap: () async {
                      login();
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 100, vertical: 10),
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(25)),
                      child: const Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ))
              ],
            )))));
  }

  login() async {
    if (_formKey.currentState!.validate()) {
      var message = await ApiService.login(username, password, context);
      if (message != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message)));
      }
    }
  }
}
