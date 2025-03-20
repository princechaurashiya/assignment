import 'package:flutter/foundation.dart';
import 'package:zylentrix/models/post.dart';

import '../services/api_service.dart';

class PostViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<PostModel> _posts = [];
  bool _isLoading = false;
  String _error = "";

  List<PostModel> get posts => _posts;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchPosts() async {
    _isLoading = true;
    _error = "";
    notifyListeners();

    try {
      _posts = await _apiService.fetchPosts();
    } catch (e) {
      _error = e.toString(); // Store the error message
    }

    _isLoading = false;
    notifyListeners();
  }
}
