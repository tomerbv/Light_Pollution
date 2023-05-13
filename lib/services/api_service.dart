import 'dart:io';
import 'package:camera/camera.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'device_info.dart';
import 'location_service.dart';

class ApiService {
  //server
  static const ip = "http://132.73.84.182:80";

  //local
  // static const ip = "http://10.100.102.7:5000";

  static final _sendImageUrl = Uri.parse("$ip/app/sendMeasurement");

  static upload(XFile imageFile, String cloudCoverage) async {
    try {
      var request = http.MultipartRequest('POST', _sendImageUrl);
      Map<String, dynamic> deviceInfo = await DeviceInfo.getPlatformState();
      String deviceModel = deviceInfo['model'] ?? "unknown";
      Position? position = await LocationService.getCurrentPosition();
      if (position != null) {
        request.fields.addAll({
          "cloud_cover": cloudCoverage,
          "latitude": position.latitude.toString(),
          "longitude": position.longitude.toString(),
          "elevation": position.altitude.toString(),
          "device": deviceModel
        });
      }

      request.files.add(http.MultipartFile.fromBytes(
          'image', File(imageFile.path).readAsBytesSync(),
          filename: imageFile.path));
      http.Response response =
          await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
        var value = response.body.replaceAll(RegExp(r'[^0-9]'), '');
        return value;
      } else {
        await EasyLoading.showError(
            "Error Code : ${response.statusCode.toString()}");
      }
    } catch (error) {
      print(error.toString());
      return "-1";
    }
    return "-1";
  }
}
