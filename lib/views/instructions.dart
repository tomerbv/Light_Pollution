import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Instructions extends StatelessWidget {
  const Instructions({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                  title: const Text('Instructions',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white70,
                          fontWeight: FontWeight.w700)),
                  backgroundColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          width: 360,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: const Text(
                              "1. Set the estimated cloud cover around you",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w700)),
                        ),
                        Container(
                          width: 360,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: const Text(
                              "2. Aim your camera at the night sky",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w700)),
                        ),
                        Container(
                          width: 360,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: const Text(
                              "3. Make sure the moon or any artificial lights are out of the frame",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w700)),
                        ),
                        Container(
                          width: 360,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: const Text(
                              "4. Capture and send us your messurement like the good samaritan you are",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w700)),
                        ),
                      ]),
                  actions: <Widget>[
                    Center(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(width: 3, color: Colors.white70),
                          )),
                        ),
                      ),
                    )
                  ]),
            ),
        child: const Icon(
          Icons.info,
          size: 40.0,
          color: Colors.white70,
        ));
  }
}
