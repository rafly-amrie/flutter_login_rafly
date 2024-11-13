// import 'package:flutter/cupertino.dart';
// import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../rest_api/ApiProv.dart';
import '../utils/BaseHelper.dart';

class LoginScr extends StatefulWidget {
  const LoginScr({super.key});

  @override
  State<LoginScr> createState() => _LoginScrState();
}

class _LoginScrState extends State<LoginScr> {

  bool _isHidden = true;
  bool _isChecked = false;
  String _errorMessage = '';
  String _unameLogin = '';
  String _pwdLogin = '';
  bool _isRemember = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _loadPref();
    super.initState();
  }

  Future<void> _loadPref() async {
    _unameLogin = await BaseHelper.getStringFromPref(BaseHelper.varPrefLoginUname) ?? '';
    _pwdLogin = await BaseHelper.getStringFromPref(BaseHelper.varPrefLoginPwd) ?? '';
    _isRemember = await BaseHelper.getBoolFromPref(BaseHelper.varPrefIsRemember) ?? false;
    _usernameController.text = _unameLogin;
    _passwordController.text = _pwdLogin;
    _isChecked = _isRemember;
    setState(() {

    });
  }

  ///
  DateTime? currentBackPressTime;
  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Press again to exit', style: TextStyle(fontSize: 16.sp),)),
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    final apiProv = Provider.of<ApiProv>(context);

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: <Widget>[
                Image.network(
                  'https://0.academia-photos.com/39681201/119096034/108412033/s200_rafly.yusrizal_amrie.jpeg',
                  height: 100,
                ),
                SizedBox(height: 25),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Username',
                    style:
                    TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _usernameController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your username',
                    labelStyle: TextStyle(fontSize: 16.sp),
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Password',
                    style:
                    TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  obscureText: _isHidden,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your password',
                    labelStyle: TextStyle(fontSize: 16.sp),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isHidden ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isHidden = !_isHidden;
                        });
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'Remember me',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        if (_usernameController.text != '' && _passwordController.text != '') {
                          _isChecked = value!;
                          BaseHelper.saveBoolToPref(BaseHelper.varPrefIsRemember, value);
                          if (value == true) {
                            BaseHelper.saveStringToPref(BaseHelper.varPrefLoginUname, _usernameController.text.toString(),);
                            BaseHelper.saveStringToPref(BaseHelper.varPrefLoginPwd, _passwordController.text.toString(),);
                          } else {
                            BaseHelper.removePref(BaseHelper.varPrefLoginUname);
                            BaseHelper.removePref(BaseHelper.varPrefLoginPwd);
                          }
                        }
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading, // Checkbox before the text
                  ),
                ),
                SizedBox(height: 25),
                if (_errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      _errorMessage,
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final dataPostLogin = {
                        'username': _usernameController.text,
                        'password': _passwordController.text,
                        'expiresInMins': 1440,
                      };
                      await apiProv.postLoginApiProv(context, dataPostLogin);
                      setState(() {
                        _errorMessage = apiProv.errorMessage;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: apiProv.isLoading == false
                        ? Text('Login', style: TextStyle(fontSize: 16.sp))
                        : Container(width: 20.w, height: 20.h, child:
                    Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,

                        )),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
}
