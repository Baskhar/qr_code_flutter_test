import 'package:http/http.dart' as http;

import 'dart:convert';

abstract class IHttpClient {
  Future<dynamic> get({required String url, String? token});
  Future<dynamic> post({required String url, required Map<String, dynamic> body});
}

class HttpClient implements IHttpClient {
  final client = http.Client();

  @override
  Future<dynamic> get({required String url, String? token}) async {
    final headers = token != null ? {'Authorization': 'Bearer $token'} : null;
    final response = await client.get(Uri.parse(url), headers: headers);
    return jsonDecode(response.body);
  }

  @override
  Future<dynamic> post({required String url, required Map<String, dynamic> body}) async {
    final response = await client.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return jsonDecode(response.body);
  }
}
