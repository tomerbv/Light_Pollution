import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../services/api_service.dart';

class RegisterPage extends StatefulWidget {
  Function(int) callback;
  RegisterPage(this.callback, {super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late String username = '';
  late String first_name = '';
  late String last_name = '';
  late String age = '';
  late String password = '';
  final _formKey = GlobalKey<FormState>();
  static final validCharacters = RegExp(r'^[a-zA-Z0-9]+$');
  static final validAgeCharacters = RegExp(r'^[0-9]+$');

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
                        } else if (!validCharacters.hasMatch(value)) {
                          return 'Invalid Input';
                        }
                        return null;
                      },
                      obscureText: false,
                      decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'first_name'),
                      onChanged: (value) {
                        setState(() {
                          first_name = value;
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
                        } else if (!validCharacters.hasMatch(value)) {
                          return 'Invalid Input';
                        }
                        return null;
                      },
                      obscureText: false,
                      decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'last_name'),
                      onChanged: (value) {
                        setState(() {
                          last_name = value;
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
                        } else if (!validAgeCharacters.hasMatch(value)) {
                          return 'Invalid Input';
                        }
                        return null;
                      },
                      obscureText: false,
                      decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'age'),
                      onChanged: (value) {
                        setState(() {
                          age = value;
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
                        } else if (value.length < 6) {
                          return 'Password length must be least 7 characters';
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
                      register();
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 100, vertical: 10),
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(25)),
                      child: const Center(
                        child: Text(
                          "Register",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ))
              ],

              // ignore: avoid_unnecessary_containers
            )))));
  }

  register() async {
    if (_formKey.currentState!.validate()) {
      var message = await ApiService.register(
          username, first_name, last_name, age, password, context);
      if (message != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message)));
      }
    }
  }
}
