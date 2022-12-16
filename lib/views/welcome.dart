import 'package:flutter/material.dart';
import 'package:light_pollution/views/camera_widget.dart';
import 'login.dart';
import 'register.dart';

class WelcomePage extends StatefulWidget {
  Function(int) callback;
  WelcomePage(this.callback, {super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
            onTap: () {
              //Login widget
              setState(() {
                widget.callback(1);
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: const Center(
                child: Text(
                  "Login",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(25)),
            )),
        InkWell(
            onTap: () {
              //Register widget
              setState(() {
                widget.callback(2);
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
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
                  color: Colors.green, borderRadius: BorderRadius.circular(25)),
            )),
        InkWell(
            onTap: () {
              //Camera widget
              setState(() {
                widget.callback(3);
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 60),
              child: const Center(
                child: Text(
                  "Continue as Guest",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color.fromARGB(118, 0, 0, 0),
                  borderRadius: BorderRadius.circular(25)),
            ))
      ],
    );
  }
}
