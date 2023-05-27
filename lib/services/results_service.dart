import 'package:flutter/material.dart';

class ResultsService {
  static void showLightPollutionValueDialog(BuildContext context, int value) {
    const List<Color> barColors = [
      Colors.green,
      Colors.lightGreen,
      Colors.yellow,
      Colors.orange,
      Colors.deepOrange,
      Colors.red,
      Colors.purple,
    ];

    String title;
    String valueAsText;

    switch (value) {
      case 0:
        title = 'Light Pollution Value Too Low';
        valueAsText = 'Make sure your camera is not covered';
        break;
      case 1:
        title = 'Low Light Pollution';
        valueAsText = 'Value: $value';
        break;
      case 2:
        title = 'Moderately Low Light Pollution';
        valueAsText = 'Value: $value';
        break;
      case 3:
        title = 'Moderate Light Pollution';
        valueAsText = 'Value: $value';
        break;
      case 4:
        title = 'Moderately High Light Pollution';
        valueAsText = 'Value: $value';
        break;
      case 5:
        title = 'High Light Pollution';
        valueAsText = 'Value: $value';
        break;
      case 6:
        title = 'Very High Light Pollution';
        valueAsText = 'Value: $value';
        break;
      case 7:
        title = 'Extremely High Light Pollution';
        valueAsText = 'Value: $value';
        break;
      case 8:
        title = 'Light Pollution Value Too High';
        valueAsText = 'Avoid direct light sources';
        break;
      default:
        title = 'Light Pollution Value: $value';
        valueAsText = 'Value: $value';
        break;
    }

    double arrowPosition = 0;
    if (value >= 1 && value <= 7) {
      arrowPosition = (value - 1) / 6; // Normalize value to range [0, 1]
    } else if (value == 0) {
      arrowPosition = -0.1; // Position arrow slightly outside the left boundary
    } else if (value == 8) {
      arrowPosition = 1.1; // Position arrow slightly outside the right boundary
    }

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.black.withOpacity(0.5),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(180, 0, 0, 0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(180, 255, 255, 255),
                  ),
                ),
                if (value != 0 &&
                    value != 8) // Show the bar only for values between 1 and 7
                  const SizedBox(
                    height: 32.0,
                  ),
                if (value != 0 &&
                    value != 8) // Show the bar only for values between 1 and 7
                  Container(
                    height: 25.0,
                    width: 300.0, // Adjust the height as desired
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: const LinearGradient(
                        colors: barColors,
                        begin: Alignment.bottomLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Transform.translate(
                          offset: Offset(arrowPosition * (250), -15),
                          child: Transform.rotate(
                            angle:
                                3.14, // Rotate the arrow by 180 degrees (pi radians)
                            child: Icon(
                              Icons.arrow_drop_up,
                              color: Colors.white,
                              size: 40.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 32.0),
                Text(
                  valueAsText,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(180, 255, 255, 255),
                  ),
                ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Close',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(180, 255, 255, 255),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
