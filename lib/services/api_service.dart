import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'device_info.dart';
import 'location_service.dart';

class ApiService {
  static final _client = http.Client();

  static final _loginUrl = Uri.parse('http://10.100.102.6:5000/login');

  static final _registerUrl = Uri.parse('http://10.100.102.6:5000/register');

  static final _sendImageUrl =
      Uri.parse("http://10.100.102.6:5000/sendMeasurement");

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
      Map<String, dynamic> deviceInfo = await DeviceInfo.getPlatformState();
      String deviceModel = deviceInfo['model'] ?? "unknown";
      Position? position = await LocationService.getCurrentPosition();
      if (position != null) {
        request.fields.addAll({
          "cloud_cover": '0',
          "latitude": position.latitude.toString(),
          "longitude": position.longitude.toString(),
          "elevation": position.altitude.toString(),
          "device": deviceModel
        });
      }

      request.files.add(http.MultipartFile.fromBytes(
          'image', File(imageFile!.path).readAsBytesSync(),
          filename: imageFile!.path));
      http.Response response =
          await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
        var value = response.body.replaceAll(new RegExp(r'[^0-9]'), '');
        return value;
      } else {
        await EasyLoading.showError(
            "Error Code : ${response.statusCode.toString()}");
      }
    } catch (error) {
      print(error.toString());
    }
    return -1;
  }
}
