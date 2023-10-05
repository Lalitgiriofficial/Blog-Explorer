import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
  static const String adminSecret =
      '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

  Future<http.Response> fetchBlogs() async {
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });

      if (response.statusCode == 200) {
        debugPrint("Request successful");
      } else {
        debugPrint('Request failed with status code: ${response.statusCode}');
        debugPrint('Response data: ${response.body}');
      }

      return response;
    } catch (e) {
      debugPrint('Error: $e');
      return http.Response('Error: $e', 500);
    }
  }
}
