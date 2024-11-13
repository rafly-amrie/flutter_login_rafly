import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/home_scr.dart';
import '../utils/BaseHelper.dart';
import 'ApiService.dart';
import 'ResponseHandler.dart';

class ApiProv with ChangeNotifier {
  ///
  final ApiService _apiService = ApiService();

  ///
  List<dynamic> _posts = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<dynamic> get posts => _posts;

  bool get isLoading => _isLoading;

  String get errorMessage => _errorMessage;

  ///
  // Fetch posts (GET)
  Future<void> fetchPosts() async {
    _isLoading = true;
    notifyListeners(); // Notify listeners of loading state
    try {
      _posts = await _apiService.getPosts();
    } catch (e) {
      // Handle error
      debugPrint(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify listeners when data is ready
    }
  }

  // Create a post (POST)
  Future<void> addPost(Map<String, dynamic> postData) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _apiService.createPost(postData);
      await fetchPosts(); // Fetch updated posts after adding
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  ///
  Future<void>  postLoginApiProv(
      BuildContext context, Map<String, dynamic> postData) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.postLoginApiService(postData);
      ResponseHandler.handleResponse(context, response, _customLoginHandler);
    } catch (e) {
      debugPrint(e.toString());
      if (e is DioException && e.response != null) {
        // Extract statusCode, statusMessage, and message from response
        final statusCode = e.response?.statusCode ?? 'Unknown';
        final statusMessage = e.response?.statusMessage ?? 'Unknown';
        final errorMessage = e.response?.data['message'] ?? 'An error occurred';
        _errorMessage = '$errorMessage';
        // _errorMessage = 'Status Code: $statusCode - Status Message: $statusMessage - Message: $errorMessage';
      } else {
        // Handle other exceptions (if any)
        debugPrint('Unexpected error: $e');
        BaseHelper.showMessageDialog(
            context, 'postLoginApiProv : ${e.toString()}');
      }
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  _customLoginHandler(int statusCode, data) async {
    switch (statusCode) {
      case 200:
        // Handle 200 response for login
        // if (data['code'] == 200) {}
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // await prefs.setString(BaseHelper.varPrefToken, data['accessToken']);

        _errorMessage = '';

        BaseHelper.saveStringToPref(BaseHelper.varPrefLoginTime, DateTime.now().toString());

        BaseHelper.saveIntToPref(BaseHelper.varPrefId, data['id']);
        BaseHelper.saveStringToPref(BaseHelper.varPrefUsername, data['username']);
        BaseHelper.saveStringToPref(BaseHelper.varPrefEmail, data['email']);
        BaseHelper.saveStringToPref(BaseHelper.varPrefFirstName, data['firstName']);
        BaseHelper.saveStringToPref(BaseHelper.varPrefLastName, data['lastName']);
        BaseHelper.saveStringToPref(BaseHelper.varPrefGender, data['gender']);
        BaseHelper.saveStringToPref(BaseHelper.varPrefImage, data['image']);
        BaseHelper.saveStringToPref(BaseHelper.varPrefAccessToken, data['accessToken']);
        BaseHelper.saveStringToPref(BaseHelper.varPrefRefreshToken, data['refreshToken']);

        Get.offAll(() => HomeScr(),
          transition: Transition.zoom,
          duration: const Duration(milliseconds: 1750),
        );
        break;
      case 400:
        debugPrint('_customLoginHandler - 400');
        _errorMessage = data['message'] ?? 'Invalid credentials';
        notifyListeners();
        break;
      case 500:
        debugPrint('_customLoginHandler - 500');
        _errorMessage = 'Server error. Please try again later.';
        notifyListeners();
        break;
      default:
        _errorMessage = 'Unhandled status code: $statusCode';
        notifyListeners();
        throw Exception('Unhandled status code: $statusCode');
    }
  }

  ///
  Future<void> postAbsenMasukProv(
      BuildContext context, Map<String, dynamic> postData) async {
    _isLoading = true;
    notifyListeners();

    try {
      debugPrint('postData : $postData');
      final response = await _apiService.postAbsenMasukApiService(postData);
      ResponseHandler.handleResponse(
          context, response, _customAbsenMasukHandler);
    } catch (e) {
      debugPrint(e.toString());
      if (e is DioException && e.response != null) {
        // Extract statusCode, statusMessage, and message from response
        final statusCode = e.response?.statusCode ?? 'Unknown';
        final statusMessage = e.response?.statusMessage ?? 'Unknown';
        final errorMessage = e.response?.data['message'] ?? 'An error occurred';
        _errorMessage = '$errorMessage';
        // _errorMessage = 'Status Code: $statusCode - Status Message: $statusMessage - Message: $errorMessage';
      } else {
        // Handle other exceptions (if any)
        debugPrint('Unexpected error: $e');
        BaseHelper.showMessageDialog(
            context, 'postLoginApiProv : ${e.toString()}');
      }
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  _customAbsenMasukHandler(int statusCode, data) async {
    switch (statusCode) {
      case 200:
        // Handle 200 response for login
        // if (data['code'] == 200) {}
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // await prefs.setString(BaseHelper.varPrefToken, data['accessToken']);

        _errorMessage = '';

        BaseHelper.saveStringToPref(
            BaseHelper.varPrefLoginTime, DateTime.now());

        BaseHelper.saveIntToPref(BaseHelper.varPrefId, data['id']);

        break;
      case 400:
        debugPrint('_customLoginHandler - 400');
        _errorMessage = data['message'] ?? 'Invalid credentials';
        notifyListeners();
        break;
      case 500:
        debugPrint('_customLoginHandler - 500');
        _errorMessage = 'Server error. Please try again later.';
        notifyListeners();
        break;
      default:
        _errorMessage = 'Unhandled status code: $statusCode';
        notifyListeners();
        throw Exception('Unhandled status code: $statusCode');
    }
  }

  ///
  Future<void> postAbsenPulangProv(
      BuildContext context, Map<String, dynamic> postData) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.postAbsenPulangApiService(postData);
      ResponseHandler.handleResponse(
          context, response, _customAbsenPulangHandler);
    } catch (e) {
      debugPrint(e.toString());
      if (e is DioException && e.response != null) {
        // Extract statusCode, statusMessage, and message from response
        final statusCode = e.response?.statusCode ?? 'Unknown';
        final statusMessage = e.response?.statusMessage ?? 'Unknown';
        final errorMessage = e.response?.data['message'] ?? 'An error occurred';
        _errorMessage = '$errorMessage';
        // _errorMessage = 'Status Code: $statusCode - Status Message: $statusMessage - Message: $errorMessage';
      } else {
        // Handle other exceptions (if any)
        debugPrint('Unexpected error: $e');
        BaseHelper.showMessageDialog(
            context, 'postLoginApiProv : ${e.toString()}');
      }
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  _customAbsenPulangHandler(int statusCode, data) async {
    switch (statusCode) {
      case 200:
        // Handle 200 response for login
        // if (data['code'] == 200) {}
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // await prefs.setString(BaseHelper.varPrefToken, data['accessToken']);

        _errorMessage = '';

        BaseHelper.saveStringToPref(
            BaseHelper.varPrefLoginTime, DateTime.now());

        BaseHelper.saveIntToPref(BaseHelper.varPrefId, data['id']);

        break;
      case 400:
        debugPrint('_customLoginHandler - 400');
        _errorMessage = data['message'] ?? 'Invalid credentials';
        notifyListeners();
        break;
      case 500:
        debugPrint('_customLoginHandler - 500');
        _errorMessage = 'Server error. Please try again later.';
        notifyListeners();
        break;
      default:
        _errorMessage = 'Unhandled status code: $statusCode';
        notifyListeners();
        throw Exception('Unhandled status code: $statusCode');
    }
  }

  ///
}
