import 'dart:convert';
import 'package:flutter/material.dart';
import '../Frontend/error_page.dart';
import '../Network/api.dart';
import 'Blog_model.dart';

class BlogProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Blog> _blogs = [];
  final List<Blog> _favoriteBlogs = [];

  List<Blog> get blogs => _blogs;

  List<Blog> get favoriteBlogs => _favoriteBlogs;

  Future<void> fetchBlogs(BuildContext context) async {
    try {
      final response = await _apiService.fetchBlogs();
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey("blogs")) {
          final List<dynamic> blogList = data["blogs"];
          _blogs = blogList.map((json) {
            return Blog(
              id: json['id'],
              title: json['title'],
              imageUrl: json['image_url'],
            );
          }).toList();
          notifyListeners();
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ErrorPage(),
            ),
          );
          throw Exception('"blogs" key not found in the JSON response');
        }
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ErrorPage(),
          ),
        );
        throw Exception('Failed to load blogs');
      }
    } catch (e) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ErrorPage(),
        ),
      );
      throw Exception('Network error: $e');
    }
  }

  void toggleFavorite(String blogId) {
    final blogIndex = _blogs.indexWhere((blog) => blog.id == blogId);
    if (blogIndex != -1) {
      _blogs[blogIndex].isFavorite = !_blogs[blogIndex].isFavorite;
      notifyListeners();
    }
  }

  List<Blog> getFavoriteBlogs() {
    return _blogs.where((blog) => blog.isFavorite).toList();
  }
}
