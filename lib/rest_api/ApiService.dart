import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

class ApiService {
  late Dio _dio1;
  late Dio _dioWorldTime;
  late Dio _dioWorldTimeNew;
  late Dio _dio3;
  late Dio _dioRamrie;

  final String baseUrl1 = 'https://jsonplaceholder.typicode.com'; // Sample API
  final String baseUrl2 = 'http://worldtimeapi.org/api/timezone/';
  final String baseUrl3 = 'https://dummyjson.com';
  final String baseUrlRamrie = 'https://dummyjson.com';
  final String baseUrlIndoTime = 'http://timeapi.io/api/Time/current/zone';

  ApiService() {
    _dio1 = Dio(BaseOptions(baseUrl: baseUrl1));
    // Add interceptors
    _dio1.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          Logger().i('Request: ${options.method} ${options.path}');
          return handler.next(options); // Continue with the request
        },
        onResponse: (response, handler) {
          Logger().i('Response: ${response.statusCode} ${response.data}');
          return handler.next(response); // Continue with the response
        },
        onError: (DioError e, handler) {
          Logger().e('Error: ${e.message}');
          return handler.next(e); // Continue with the error
        },
      ),
    );

    _dioWorldTime = Dio(BaseOptions(baseUrl: baseUrl2));
    // Add interceptors
    _dioWorldTime.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          Logger().i('Request: ${options.method} ${options.path}');
          return handler.next(options); // Continue with the request
        },
        onResponse: (response, handler) {
          Logger().i('Response: ${response.statusCode} ${response.data}');
          return handler.next(response); // Continue with the response
        },
        onError: (DioError e, handler) {
          Logger().e('Error: ${e.message}');
          return handler.next(e); // Continue with the error
        },
      ),
    );

    _dio3 = Dio(BaseOptions(baseUrl: baseUrl3));
    _dio3.options.headers = {'Content-Type': 'application/json'};
    // Add interceptors
    _dio3.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          Logger().i('Request: ${options.method} ${baseUrl3}${options.path}');
          return handler.next(options); // Continue with the request
        },
        onResponse: (response, handler) {
          Logger().i('Response: ${response.statusCode} ${response.data}');
          return handler.next(response); // Continue with the response
        },
        onError: (DioError e, handler) {
          Logger().e('Error: ${e.message}');
          return handler.next(e); // Continue with the error
        },
      ),
    );

    _dioRamrie = Dio(BaseOptions(baseUrl: baseUrlRamrie));
    _dioRamrie.options.headers = {'Content-Type': 'application/json'};
    // Add interceptors
    _dioRamrie.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          Logger().i('Request: ${options.method} ${baseUrlRamrie}${options.path}');
          return handler.next(options); // Continue with the request
        },
        onResponse: (response, handler) {
          Logger().i('Response: ${response.statusCode} ${response.data}');
          return handler.next(response); // Continue with the response
        },
        onError: (DioError e, handler) {
          Logger().e('Error: ${e.message}');
          return handler.next(e); // Continue with the error
        },
      ),
    );

    _dioWorldTimeNew = Dio(BaseOptions(baseUrl: baseUrlIndoTime));
    _dioWorldTimeNew.options.headers = {'Content-Type': 'application/json'};
    // Add interceptors
    _dioWorldTimeNew.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          Logger().i('Request: ${options.method} ${baseUrlIndoTime}${options.path}');
          return handler.next(options); // Continue with the request
        },
        onResponse: (response, handler) {
          Logger().i('Response: ${response.statusCode} ${response.data}');
          return handler.next(response); // Continue with the response
        },
        onError: (DioError e, handler) {
          Logger().e('Error: ${e.message}');
          return handler.next(e); // Continue with the error
        },
      ),
    );
  }

  // GET request
  Future<List<dynamic>> getPosts() async {
    try {
      Response response = await _dio1.get('/posts');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Future<String> getCurrentTime(String timezone) async {
  //   try {
  //     Response response =
  //         await _dioWorldTime.get('$timezone'); // Example: Asia/Jakarta
  //     return response.data['datetime']; // Return the datetime string
  //   } catch (e) {
  //     Logger().e('Error in API call: $e'); // Log error
  //     throw Exception('Failed to fetch time'); // Rethrow a specific error
  //     // rethrow;
  //   }
  // }

  Future<Map<String, dynamic>> getCurrentTimeNew(String timezone) async {
    try {
      Response response = await _dioWorldTimeNew.get(
        '',
        queryParameters: {
          'timeZone': timezone, // Example: Asia/Jakarta
        },
      );
      return response.data; // Return the entire data map
    } catch (e) {
      Logger().e('Error in API call: $e'); // Log error
      throw Exception('Failed to fetch time'); // Rethrow a specific error
    }
  }

  // POST request
  Future<dynamic> createPost(Map<String, dynamic> data) async {
    try {
      Response response = await _dio1.post('/posts', data: data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> postLoginApiService(Map<String, dynamic> data) async {
    try {
      Response response = await _dio3.post('/user/login', data: data);
      return response;
    } catch (e) {
      if (e is DioException) {
        // Check if the error has a response and log the message
        if (e.response != null) {
          debugPrint('Error status code: ${e.response?.statusCode}');
          debugPrint('Error message: ${e.response?.data['message']}');
        } else {
          debugPrint('Error without response: $e');
        }
      } else {
        debugPrint('Unexpected error: $e');
      }
      rethrow; // Propagate the error further if needed
    }
  }

  Future<Response> postAbsenMasukApiService(Map<String, dynamic> data) async {
    try {
      Response response = await _dioRamrie.post('/user/masuk', data: data);
      return response;
    } catch (e) {
      if (e is DioException) {
        // Check if the error has a response and log the message
        if (e.response != null) {
          debugPrint('Error status code: ${e.response?.statusCode}');
          debugPrint('Error message: ${e.response?.data['message']}');
        } else {
          debugPrint('Error without response: $e');
        }
      } else {
        debugPrint('Unexpected error: $e');
      }
      rethrow; // Propagate the error further if needed
    }
  }

  Future<Response> postAbsenPulangApiService(Map<String, dynamic> data) async {
    try {
      Response response = await _dioRamrie.post('/user/pulang', data: data);
      return response;
    } catch (e) {
      if (e is DioException) {
        // Check if the error has a response and log the message
        if (e.response != null) {
          debugPrint('Error status code: ${e.response?.statusCode}');
          debugPrint('Error message: ${e.response?.data['message']}');
        } else {
          debugPrint('Error without response: $e');
        }
      } else {
        debugPrint('Unexpected error: $e');
      }
      rethrow; // Propagate the error further if needed
    }
  }

  ///
}
