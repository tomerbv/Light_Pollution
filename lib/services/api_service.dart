import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../main.dart';
import '/views/welcome.dart';
import '../views/camera_widget.dart';

class ApiService {
  static final _client = http.Client();

  static var _loginUrl = Uri.parse('http://10.0.2.2:5000/login');

  static var _registerUrl = Uri.parse('http://10.0.2.2:5000/register');

  static login(email, password, context) async {
    http.Response response = await _client.post(_loginUrl, body: {
      "email": email,
      "password": password,
    });

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      var json = jsonDecode(response.body);

      if (json[0] == 'success') {
        await EasyLoading.showSuccess(json[0]);
        // await Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => CameraWidget()));
      } else {
        EasyLoading.showError(json[0]);
      }
    } else {
      await EasyLoading.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }

  static register(email, password, context) async {
    http.Response response = await _client.post(_registerUrl, body: {
      "email": email,
      "password": password,
    });

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == 'username already exist') {
        await EasyLoading.showError(json[0]);
      } else {
        await EasyLoading.showSuccess(json[0]);
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => CameraWidget()));
      }
    } else {
      await EasyLoading.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }
}
