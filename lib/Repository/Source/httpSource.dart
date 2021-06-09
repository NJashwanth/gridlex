import 'dart:convert';

import 'package:gridlex_assessment/Home/Model/MedicalFormModel.dart';
import 'package:http/http.dart' as http;

class HttpSource {
  static HttpSource? _instance;

  static HttpSource? getInstance() {
    if (_instance == null) _instance = new HttpSource();
    return _instance;
  }

  Future<Map<String, dynamic>> sendDataToServer(
      MedicalFormModel medicalFormModel) async {
    try {
      Uri uri = Uri.parse(
          "https://us-central1-assesstment-2b188.cloudfunctions.net/formDetaisl-sendSingleFormToServer");
      var headers = {'Content-Type': 'application/json'};

      final response = await http.post(uri,
          headers: headers, body: jsonEncode(medicalFormModel.toJson()));
      print('response is ' + response.body);
      if (response.statusCode == 200) {
        return getEncodedMap(jsonDecode(response.body));
      } else {
        print('error occurred');
        return {
          "isSuccess": false,
          "message": "Error occurred Please try again later"
        };
      }
    } catch (e) {
      print("error for sendDataToServer = $e");

      return {
        "isSuccess": false,
        "message": "Error occurred Please try again later"
      };
    }
  }

  Future<Map<String, dynamic>> sendTotalDataToServer(
      List<dynamic> listToSendToServer) async {
    try {
      Uri uri = Uri.parse(
          "https://us-central1-assesstment-2b188.cloudfunctions.net/formDetaisl-sendMultipleDataToServer");
      var headers = {'Content-Type': 'application/json'};

      final response = await http.post(uri,
          headers: headers, body: jsonEncode(listToSendToServer));
      print('response is ' + response.body);
      if (response.statusCode == 200) {
        return getEncodedMap(jsonDecode(response.body));
      } else {
        print('error occurred');
        return {
          "isSuccess": false,
          "message": "Error occurred Please try again later"
        };
      }
    } catch (e) {
      print("error for sendDataToServer = $e");

      return {
        "isSuccess": false,
        "message": "Error occurred Please try again later"
      };
    }
  }

  Map<String, dynamic> getEncodedMap(Map<dynamic, dynamic> temp) {
    Map<String, dynamic> data = new Map();
    temp.forEach((key, value) {
      data[key.toString()] = value;
    });
    return jsonDecode(jsonEncode(data));
  }
}
