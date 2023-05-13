import 'dart:async';
import 'package:light_pollution/views/camera_widget.dart';
import 'package:flutter/material.dart';

/// CameraApp is the Main Application.
class LightPollutionApp extends StatefulWidget {
  const LightPollutionApp({super.key});

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
    final List<Widget> pages = <Widget>[
      CameraWidget(onItemTapped),
    ];

    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/wallpaper.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: pages.elementAt(selectedIndex)),
    ));
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const LightPollutionApp());
}
