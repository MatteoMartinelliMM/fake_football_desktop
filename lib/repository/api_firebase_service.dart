import 'dart:convert';

import 'package:fake_football_desktop/utils/constants.dart';
import 'package:fake_football_desktop/model/player.dart';
import 'package:http/http.dart' as http;

class ApiFirebaseService {
  static final ApiFirebaseService _instance = ApiFirebaseService._getInstance();
  late String baseUrl;
  late http.Client _httpClient;

  factory ApiFirebaseService() {
    return _instance;
  }

  ApiFirebaseService._getInstance() {
    _httpClient = http.Client();
    baseUrl = BASE_URL;
  }

  Future<Map<String, dynamic>?> getFromUrl({required List<String> path}) async {
    var response =
        await _httpClient.get(_createUrl(path: path)).timeout(TIMOUT_AMOUNT, onTimeout: () {
      return DEFAULT_TIMEOUT_RESPONSE;
    });
    print('calling path ${_createUrl(path: path)}');
    print('response ${response.statusCode} ${response.reasonPhrase}');
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  Uri _createUrl({required List<String> path}) {
    return Uri.parse('$baseUrl${path.join('/')}$FIXED_PARAMS_JSON');
  }

  Future<void> putToUrl(List<String> path, Map<String, dynamic> jsonData) async {
    final response = await http.put(_createUrl(path: path), body: jsonEncode(jsonData));

    if (response.statusCode == 200) {
      print('Data inserted successfully.');
    } else {
      print('Failed to insert data: ${response.reasonPhrase}');
    }
  }

  Future<void> patchToUrl(List<String> path, Map<String, dynamic> jsonData) async {
    final response = await http.patch(_createUrl(path: path), body: jsonEncode(jsonData));
    if (response.statusCode == 200) {
      print('Data updated successfully.');
    } else {
      print('Failed to insert data: ${response.reasonPhrase}');
    }
  }

  Future<void> putDataToPathString(List<String> path, String jsonData) async {
    final response = await http.put(_createUrl(path: path), body: jsonData);

    if (response.statusCode == 200) {
      print('Data inserted successfully.');
    } else {
      print('Failed to insert data: ${response.reasonPhrase}');
    }
  }
}
