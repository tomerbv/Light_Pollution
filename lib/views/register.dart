import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../services/api_service.dart';

class RegisterPage extends StatefulWidget {
  Function(int) callback;
  RegisterPage(this.callback, {super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late String username;
  late String first_name;
  late String last_name;
  late String age;
  late String password;

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 300,
                padding: const EdgeInsets.all(10),
                child: TextField(
                  obscureText: false,
                  decoration: InputDecoration(
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
                child: TextField(
                  obscureText: false,
                  decoration: InputDecoration(
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
                child: TextField(
                  obscureText: false,
                  decoration: InputDecoration(
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
                child: TextField(
                  obscureText: false,
                  decoration: InputDecoration(
                      fillColor: Colors.white, filled: true, hintText: 'age'),
                  onChanged: (value) {
                    setState(() {
                      age = value;
                    });
                  },
                )),
            Container(
                width: 300,
                padding: const EdgeInsets.all(10),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
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
                  margin:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                  child: const Center(
                    child: Text(
                      "Register",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(25)),
                ))
          ],

          // ignore: avoid_unnecessary_containers
        ));
  }

  register() async {
    if (await ApiService.register(
        username, first_name, last_name, age, password, context)) {
      return true;
    }
  }
}
