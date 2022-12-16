import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:light_pollution/views/welcome.dart';
import '../main.dart';
import '../services/errors.dart';

import 'dart:convert';
import 'package:flutter/material.dart';

class CameraWidget extends StatefulWidget {
  Function(int) callback;
  CameraWidget(this.callback, {super.key});
  @override
  State<CameraWidget> createState() {
    return _CameraWidgetState();
  }
}

List<CameraDescription> _cameras = <CameraDescription>[];
Future<void> loadCameras() async {
  // Fetch the available cameras before initializing the app.
  try {
    _cameras = await availableCameras();
  } on CameraException catch (e) {
    ErrorHandler.logError(e.code, e.description);
  }
}

class _CameraWidgetState extends State<CameraWidget>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  CameraController? controller;
  XFile? imageFile;
  XFile? videoFile;
  VoidCallback? videoPlayerListener;

  // Counting pointers (number of user fingers on screen)
  int _pointers = 0;

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

  // #docregion AppLifecycle
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }
  }
  // #enddocregion AppLifecycle

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      //handle return button
      onWillPop: () async {
        if (this.controller != null) {
          this.controller = null;
          setState(() {});
        } else {
          //Welcome widget
          setState(() {
            widget.callback(0);
          });
        }
        return false;
      },
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: _cameraPreviewWidget(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: <Widget>[],
            ),
          ),
          Container(
              width: 75.0,
              height: 75.0,
              child: controller != null
                  ? FloatingActionButton(
                      backgroundColor: Color.fromARGB(255, 49, 121, 255),
                      onPressed: () {
                        onTakePictureButtonPressed();
                      },
                      child: const Text('Capture',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w900,
                          )),
                    )
                  : null),
        ],
      ),
    );
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget() {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return Container(
          width: 200.0,
          height: 200.0,
          child: FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 219, 132, 0),
            onPressed: () {
              onNewCameraSelected(_cameras[0]);
            },
            child: const Text('Record Light Pollution',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w900,
                )),
          ));
    } else {
      return CameraPreview(controller!);
    }
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void showInSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> onNewCameraSelected(CameraDescription cameraDescription) async {
    final CameraController? oldController = controller;
    if (oldController != null) {
      controller = null;
      await oldController.dispose();
    }

    final CameraController cameraController = CameraController(
      cameraDescription,
      kIsWeb ? ResolutionPreset.max : ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    controller = cameraController;

    // If the controller is updated then update the UI.
    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
      if (cameraController.value.hasError) {
        showInSnackBar(
            'Camera error ${cameraController.value.errorDescription}');
      }
    });

    try {
      await cameraController.initialize();
      await Future.wait(<Future<Object?>>[
        ...!kIsWeb
            //set exposure and other paramaters to suit light pollution recording
            ? <Future<Object?>>[
                cameraController.getMaxExposureOffset().then((double value) =>
                    {cameraController.setExposureOffset(value)}),
                cameraController.setFlashMode(FlashMode.off),
                cameraController.setFocusMode(FocusMode.auto),
                cameraController.setZoomLevel(1.0)
              ]
            : <Future<Object?>>[],
      ]);
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          showInSnackBar('You have denied camera access.');
          break;
        case 'CameraAccessDeniedWithoutPrompt':
          // iOS only
          showInSnackBar('Please go to Settings app to enable camera access.');
          break;
        case 'CameraAccessRestricted':
          // iOS only
          showInSnackBar('Camera access is restricted.');
          break;
        case 'AudioAccessDenied':
          showInSnackBar('You have denied audio access.');
          break;
        case 'AudioAccessDeniedWithoutPrompt':
          // iOS only
          showInSnackBar('Please go to Settings app to enable audio access.');
          break;
        case 'AudioAccessRestricted':
          // iOS only
          showInSnackBar('Audio access is restricted.');
          break;
        default:
          _showCameraException(e);
          break;
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  void onTakePictureButtonPressed() {
    takePicture().then((XFile? file) {
      if (mounted) {
        setState(() {
          imageFile = file;
        });
        if (file != null) {
          showInSnackBar('Picture saved to ${file.path}');
        }
      }
    });
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      final XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  void _showCameraException(CameraException e) {
    ErrorHandler.logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }
}
