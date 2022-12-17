import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ApiService {
  static final _client = http.Client();

  static var _loginUrl = Uri.parse('http://10.100.102.7:5000/login');

  static var _registerUrl = Uri.parse('http://10.100.102.7:5000/register');

  static var _sendImageUrl =
      Uri.parse("http://10.100.102.7:5000/sendMeasurement");

  static login(username, password, context) async {
    http.Response response = await _client.post(_loginUrl, body: {
      "username": username,
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

  static register(
      username, first_name, last_name, age, password, context) async {
    try {
      http.Response response = await _client.post(_registerUrl, body: {
        "username": username,
        "first_name": first_name,
        "last_name": last_name,
        "age": age,
        "password": password,
      });
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        if (json[0] == 'username already exist') {
          await EasyLoading.showError(json[0]);
        } else {
          await EasyLoading.showSuccess(json[0]);
          return true;
        }
      } else {
        await EasyLoading.showError(
            "Error Code : ${response.statusCode.toString()}");
      }
    } catch (_) {
      print("failed");
    }
    return false;
  }

  static upload(XFile imageFile) async {
    try {
      var request = http.MultipartRequest('POST', _sendImageUrl);
      request.files.add(http.MultipartFile.fromBytes(
          'image', File(imageFile!.path).readAsBytesSync(),
          filename: imageFile!.path));
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        return true;
      } else {
        await EasyLoading.showError(
            "Error Code : ${response.statusCode.toString()}");
      }
    } catch (error) {
      print(error.toString());
    }
    return false;
  }
}
