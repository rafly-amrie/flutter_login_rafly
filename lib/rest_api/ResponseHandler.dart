import 'package:dio/dio.dart' as myDio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ResponseHandler {
  ///
  static handleResponse(
      BuildContext context, myDio.Response response, Function customHandler) {
    switch (response.statusCode) {
      case 200:
        // return _handleSuccess(response.statusCode, response.data);
        return customHandler(response.statusCode, response.data);
      case 400:
        // return _handleBadRequest(response.statusCode, response.data);
        return customHandler(response.statusCode, response.data);
      case 401:
        return Get.dialog(
          barrierDismissible: false,
          AlertDialog(
            title: Text("RAMRIE"),
            content: Text('Sesi habis, silahkan login ulang.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                // Close the dialog
                child: Text("OK"),
              ),
            ],
          ),
        );
      case 500:
        // return _handleServerError(response.statusCode, response.data);
        return customHandler(response.statusCode, response.data);
      default:
        throw Exception('Unknown error occurred');
    }
  }

  static _handleSuccess(data) {
    if (data['code'] >= 100 && data['code'] < 200) {
      // handle specific success code range 100-199
    } else if (data['code'] >= 200 && data['code'] < 300) {
      // handle specific success code range 200-299
    }
    return data;
  }

  static _handleBadRequest(data) {
    // Handle 400 error
    throw Exception('Bad request: ${data['message']}');
  }

  static _handleServerError(data) {
    // Handle 500 error
    throw Exception('Server error: ${data['message']}');
  }

  ///
}
