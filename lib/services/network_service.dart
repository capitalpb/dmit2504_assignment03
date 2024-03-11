import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkService {
  static const headers = {
    'Content-Type': 'application/json',
    'Access-Control-Allow-Credentials': 'true',
    'Access-Control-Allow-Headers': 'Content-Type',
    'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE',
    'Access-Control-Allow-Origin': '*',
  };

  static Future getData(Uri url) async {
    try {
      http.Response response = await http.get(url, headers: headers);

      return response.statusCode == 200
          ? jsonDecode(response.body)
          : throw Exception(
              'ERROR response status code: ${response.statusCode}');
    } catch (e) {
      // ignore: avoid_print
      print('NetworkService getData catch: $e');
    }
  }
}
