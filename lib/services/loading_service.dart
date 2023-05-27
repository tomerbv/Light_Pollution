import 'package:flutter/material.dart';

class LoadingService {
  static void showLoadingAnimation(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(180, 0, 0, 0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                SizedBox(height: 32.0),
                SizedBox(
                  height: 100.0,
                  width: 100.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                  ),
                ),
                SizedBox(height: 32.0),
                Text(
                  'Sending Measurement...',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(180, 255, 255, 255)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void hideLoadingAnimation(BuildContext context) {
    Navigator.of(context).pop();
  }
}
