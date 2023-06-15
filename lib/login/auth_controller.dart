import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
class ApiService {
  static Future<Map<String, dynamic>> makeApiCall(String apiUrl, Map<String, String> headers, dynamic requestBody) async {
    try {
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData;
      } else {
        throw Exception('API call failed with status code ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error in API call: $error');
    }
  }
}

class AuthController {
  Future<String?> generateToken(String username, String apiKey) async {
    final String apiUrl = 'https://issuanceapis-uat.pinelabs.com/v1/auths/tokens/signin';

    Map<String, String> headers = {
      'accept': 'application/json',
      'content-type': 'application/json',
    };

    Map<String, String> body = {
      'username': username,
      'apiKey': apiKey,
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        if (data['responseCode'] == 0) {
          String refreshToken = data['refreshToken'];
          String token = data['token'];

          // Store the token in shared preferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);

          return token;
        } else {
          String responseMessage = data['responseMessage'];
          throw responseMessage;
        }
      } else {
        throw 'Error: HTTP ${response.statusCode}';
      }
    } catch (e) {
      throw 'Error: $e';
    }
  }


  static Future<Map<String, dynamic>> minnativekycphone(String apiUrl, Map<String, String> headers, dynamic requestBody) async {
    try {
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData;
      } else {
        throw Exception('API call failed with status code ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error in API call: $error');
    }
  }

  
}
