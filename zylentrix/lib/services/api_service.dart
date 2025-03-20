import 'package:http/http.dart' as http;
import 'package:zylentrix/models/post.dart';
import 'dart:convert';

class ApiService {
  static const String url = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<PostModel>> fetchPosts() async {
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(
            Duration(seconds: 10), // Timeout to prevent indefinite waiting
            onTimeout: () {
              throw Exception("Connection Timeout. Please try again.");
            },
          );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => PostModel.fromJson(json)).toList();
      } else if (response.statusCode == 404) {
        throw Exception("Resource not found.");
      } else if (response.statusCode == 500) {
        throw Exception("Server error. Please try again later.");
      } else {
        throw Exception(
          "Failed to load posts. Error code: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Network error: ${e.toString()}");
    }
  }
}
