import 'package:flutter/material.dart';
import 'package:geometryhunter/constants.dart';
import 'package:geometryhunter/screens/home_screen.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: GestureDetector(
        onTap: (){Get.to(()=> HomeScreen()) ;
          },
        child: Center(
                    child: Image.asset(
                      'assets/images/preload.png',
                      width: 250,
                      height: 250,
                    ),
                  ),
      ),
    );
  }
}
