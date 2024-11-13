// import 'package:flutter/cupertino.dart';
// import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../utils/BaseHelper.dart';
import 'login_scr.dart';

class HomeScr extends StatefulWidget {
  const HomeScr({super.key});

  @override
  State<HomeScr> createState() => _HomeScrState();
}

class _HomeScrState extends State<HomeScr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Uhuyyy',
                  style: TextStyle(
                    fontSize: 20.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Text(
                //   '01/Jan/99 - 01:01:01',
                //   style: TextStyle(fontSize: 16.0),
                // ),
                Text(
                  "Huyyy", // Show the formatted time
                  style: TextStyle(fontSize: 16.0.sp),
                )
                /*timeProvider.isLoading || timeProvider.formattedTime == 'Memuat...'
                    ? Text(
                        'Memuat...',
                        style: TextStyle(fontSize: 16.0),
                      )
                    : Text(
                        timeProvider.formattedTime, // Show the formatted time
                        style: TextStyle(fontSize: 16.0),
                      ),*/
              ],
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              iconSize: 25,
              color: Colors.blue,
              onPressed: () {
                debugPrint("Refresh icon tapped!");
              },
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            iconSize: 25,
            color: Colors.red,
            onPressed: () {
              debugPrint("Logout icon tapped!");
              Get.dialog(
                barrierDismissible: false,
                AlertDialog(
                  title: Text(
                    "RAMRIE",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Text(
                    'Anda yakin ingin melakukan logout ?',
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        "Batal",
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        await BaseHelper.clearLogoutSharedPreferences();
                        Get.offAll(() => LoginScr());
                      },
                      child: Text(
                        "Ya",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors
                              .blue, // Change the button text color to blue
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: const Column(
        children: [
          Center(
            child: Text("Ihiwww"),
          ),
        ],
      ),
    );
  }
}
