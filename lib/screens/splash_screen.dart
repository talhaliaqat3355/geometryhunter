import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 @override
  void initState() {
   super.initState();
    Future.delayed(const Duration(seconds: 3), () {

      Get.to(() => HomeScreen()); }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child:ConstrainedBox(
          constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height ),
        child: Center(
                      child: Image.asset(
                        'assets/images/preload.png',
                        width: 250.w,
                        height: 250.h,
                      ),
                    ),
    )
    ),
    );
  }
}
