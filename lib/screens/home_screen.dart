import 'package:flutter/material.dart';
import 'package:geometryhunter/screens/gallery_screen.dart';
import 'package:geometryhunter/screens/game_mode_screen.dart';
import 'package:get/get.dart';
import '../constants.dart';
import 'package:geometryhunter/screens/guide_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
                'assets/images/bg.png',
                fit: BoxFit.cover,
              ),
          ),
          SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                children: [
                   SizedBox(height: 40.h),
                    Image.asset(
                     'assets/images/logo.png',
                       height: 220.h,
                      width: 220.w,
                     ),
                  SizedBox(height: 50.h),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: (){
                        Get.to(() => GameModeScreen());
                      },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kSecondaryColor,
                          minimumSize:  Size(double.infinity, 60.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                          child:  Text(
                            'Start New Game',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          ),
                      ),
                      ),
                       SizedBox(height: 20.h),
                      ElevatedButton(
                        onPressed: () {
                          Get.to(()=>GalleryScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          minimumSize:  Size(double.infinity, 60.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                        child:  Text(
                          'Gallery',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                   ),
                  )
                 ]
                ),
              )
             ),
          Positioned(
            left: 20.w,
            bottom: 30.h,
            child: GestureDetector(
              onTap: () {

              },
                child: Image.asset(
                  'assets/images/music_icon.png',
                  height: 48.h,
                ),
            ),
          ),

          Positioned(
            right: 20.w,
            bottom: 30.h,
            child: GestureDetector(
              onTap: () {
                Get.to(() => GuideScreen());
              },
              child: Image.asset(
                'assets/images/help_icon.png',
                height: 48.h,
              ),
            ),
          ),
        ],
      )
    );
  }
}
