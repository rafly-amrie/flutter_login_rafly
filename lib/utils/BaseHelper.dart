import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseHelper {
  ///___________________________________________________________________________
  static Future<dynamic> saveStringToPref(
      String fieldName, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(fieldName, value);
  }

  static Future<dynamic> saveIntToPref(String fieldName, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(fieldName, value);
  }

  static Future<dynamic> saveBoolToPref(String fieldName, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(fieldName, value);
  }

  static Future<dynamic> saveDoubleToPref(
      String fieldName, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(fieldName, value);
  }

  static Future<dynamic> saveStringListToPref(
      String fieldName, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(fieldName, value);
  }

  ///___________________________________________________________________________
  static Future<dynamic> getStringFromPref(String fieldName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(fieldName);
  }

  static Future<dynamic> getIntFromPref(String fieldName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(fieldName);
  }

  static Future<dynamic> getBoolFromPref(String fieldName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(fieldName);
  }

  static Future<dynamic> getDoubleFromPref(String fieldName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(fieldName);
  }

  static Future<dynamic> getStringListFromPref(String fieldName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(fieldName);
  }

  ///___________________________________________________________________________
  static Future<bool> removePref(String fieldName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(fieldName);
  }

  static Future<bool> checkPref(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  static Future<void> clearAllSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static Future<void> clearLogoutSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(varPrefIsRemember) == true) {
      String uname = await getStringFromPref(varPrefLoginUname);
      String pwd = await getStringFromPref(varPrefLoginPwd);
      bool isRemember = await getBoolFromPref(varPrefIsRemember);
      prefs.clear();
      BaseHelper.saveStringToPref(BaseHelper.varPrefLoginUname, uname,);
      BaseHelper.saveStringToPref(BaseHelper.varPrefLoginPwd, pwd,);
      BaseHelper.saveBoolToPref(BaseHelper.varPrefIsRemember, isRemember,);
    } else {
      prefs.clear();
    }
  }

  static Future<void> clearNewDaySharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(varPrefAccessToken);
    prefs.remove(varPrefRefreshToken);
  }

  ///___________________________________________________________________________
  static screenWidth(BuildContext context) {
    MediaQuery.of(context).size.width;
  }

  static screenHeight(BuildContext context) {
    MediaQuery.of(context).size.height;
  }

  static showMessageDialog(BuildContext context, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "RAMRIE",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          content: Text(
            content,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.amber; // Pressed color
                    }
                    return Colors.blue; // Default color
                  },
                ),
                padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                ),
                textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(
                    fontSize: 16.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              child: Text(
                "OK",
                style: TextStyle(fontSize: 16.0.sp, color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  ///___________________________________________________________________________
  static const String varPrefId = 'id';
  static const String varPrefUsername = 'username';
  static const String varPrefEmail = 'email';
  static const String varPrefFirstName = 'firstName';
  static const String varPrefLastName = 'lastName';
  static const String varPrefGender = 'gender';
  static const String varPrefImage = 'image';
  static const String varPrefAccessToken = 'accessToken';
  static const String varPrefRefreshToken = 'refreshToken';

  static const String varPrefIsRemember = 'isRemember';
  static const String varPrefLoginUname = 'loginUname';
  static const String varPrefLoginPwd = 'loginPwd';

  static const String varPrefLoginTime = 'loginTime';
  static const String varPrefLogoutTime = 'logoutTime';

  static const String varPrefLatitude = 'latitude';
  static const String varPrefLongitude = 'longitude';

  static const String varPrefWaktuAbsenMasuk = 'waktuAbsenMasuk';
  static const String varPrefWaktuAbsenPulang = 'waktuAbsenPulang';

  static const String varPrefWaktuAbsenMasukOver = 'waktuAbsenMasukOver';
  static const String varPrefWaktuAbsenPulangOver = 'waktuAbsenPulangOver';

  static const String varPrefSelfie = 'selfie';
}
