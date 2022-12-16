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
  late String email;
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
                      fillColor: Colors.white, filled: true, hintText: 'email'),
                  onChanged: (value) {
                    setState(() {
                      email = value;
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
                  await ApiService.register(email, password, context);
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
}
