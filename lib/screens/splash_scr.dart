// import 'package:flutter/cupertino.dart';
// import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../utils/BaseHelper.dart';
import 'home_scr.dart';
import 'login_scr.dart';

class SplashScr extends StatefulWidget {
  const SplashScr({super.key});

  @override
  State<SplashScr> createState() => _SplashScrState();
}

class _SplashScrState extends State<SplashScr> with SingleTickerProviderStateMixin {
  String? _accessToken;
  String? _loginTime;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    _loadPref();

    // Initialize AnimationController for FadeTransition
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Adjust duration as needed
      vsync: this,
    );

    // Define the animation (opacity range from 0.0 to 1.0)
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {}); // Rebuild on animation change
      });

    // Start the animation
    _controller.forward();

    Timer(
      const Duration(seconds: 3),
          () async => await navigateToNextScreen(context),
    );
    super.initState();
  }

  @override
  void activate() {
    // TODO: implement activate
    super.activate();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant SplashScr oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose(); // Dispose of the animation controller
    super.dispose();
  }

  @override
  noSuchMethod(Invocation invocation) {
    // TODO: implement noSuchMethod
    return super.noSuchMethod(invocation);
  }

  @override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  ///
  Future<void> _loadPref() async {
    _accessToken =
    await BaseHelper.getStringFromPref(BaseHelper.varPrefAccessToken);
    _loginTime =
    await BaseHelper.getStringFromPref(BaseHelper.varPrefLoginTime);
  }

  Future<void> navigateToNextScreen(BuildContext context) async {
    DateTime now = DateTime.now();
    String todayStr = DateFormat('yyyy-MM-dd').format(now);

    if (_loginTime == null || _accessToken == null) {
      await BaseHelper.clearAllSharedPreferences();
      _navigateToLogin();
    } else {
      DateTime loginTime = DateTime.parse(_loginTime!);
      String loginDayStr = DateFormat('yyyy-MM-dd').format(loginTime);

      if (todayStr != loginDayStr) {
        await BaseHelper.clearAllSharedPreferences();
        _navigateToLogin();
      } else {
        _navigateToHome();
      }
    }
  }

  void _navigateToLogin() {
    Get.offAll(
      const LoginScr(),
      transition: Transition.zoom, // Fade-in effect
      duration: const Duration(milliseconds: 2250), // Animation duration
    );
  }

  void _navigateToHome() {
    Get.offAll(
      const HomeScr(),
      transition: Transition.zoom, // Fade-in effect
      duration: const Duration(milliseconds: 2250), // Animation duration
    );
  }

  ///

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }

}
