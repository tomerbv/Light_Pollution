import 'dart:async';
import 'package:light_pollution/views/camera_widget.dart';
import 'package:light_pollution/views/login.dart';
import 'package:light_pollution/views/register.dart';
import 'package:light_pollution/views/welcome.dart';
import 'package:flutter/material.dart';

/// CameraApp is the Main Application.
class LightPollutionApp extends StatefulWidget {
  @override
  State<LightPollutionApp> createState() {
    return _LightPollutionAppState();
  }
}

class _LightPollutionAppState extends State<LightPollutionApp>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  int selectedIndex = 0;

  onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    loadCameras();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = <Widget>[
      // WelcomePage(onItemTapped),
      // LoginPage(onItemTapped),
      // RegisterPage(onItemTapped),
      CameraWidget(onItemTapped),
    ];

    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text(
          'Light Pollution App',
        ),
      ),
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/wallpaper.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: _pages.elementAt(selectedIndex)),
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   backgroundColor: Colors.black,
      //   unselectedItemColor: Colors.white,
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.login),
      //       label: 'Login',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.app_registration_rounded),
      //       label: 'Register',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.camera),
      //       label: 'Measure',
      //     ),
      //   ],
      //   currentIndex: selectedIndex,
      //   onTap: (onItemTapped),
      // ),
    ));
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(LightPollutionApp());
}
