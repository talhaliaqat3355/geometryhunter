import 'package:GH0406/screens/help_screens/whats-psychogeometry_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

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
                padding:  EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child:  Row(
                        children: [
                          Icon(Icons.arrow_back_ios_rounded, size: 18.sp, color: kTextColor),
                          SizedBox(width: 1.w),
                          Text(
                            "BACK",
                            style: kBackButtonTextStyle
                          ),
                        ],
                      ),
                    ),
                     SizedBox(height: 20.h),
              
                    Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Image.asset('assets/images/guide_icon.png',color: kPrimaryColor),
                     SizedBox(width: 4.w),
                     Text(
                          "HOW TO PLAY?",
                          style: kHowToPlayTextStyle
                        ),
                       ]
                      ),
                    Divider(
                      color: kPrimaryColor,
                    ),
                     SizedBox(height: 30.h),
              
                    Expanded(
                      child: ListView(
                        children: [
                          _buildGameModeButton(
                            imagePath: 'assets/images/tic-tac_icon.png',
                            title: "TIC TAC TOE - 3X3",
                           // onTap: (){ Get.to(() => TicTacToeScreen());},
                          ),
                           SizedBox(height: 20.h),
                           Text(
                            'In this mode, two players compete in a game similar to tic-tac-toe.Outsmart your opponent by forming a winning combination of different shapes!',
                            style: TextStyle(
                              color: kTextColor,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                           SizedBox(height: 20.h),
                          _buildGameModeButton(
                            imagePath: 'assets/images/sword_icon.png',
                            title: "1 VS 1",
                           // onTap: () => Get.toNamed('/tic_tac_toe'),
                          ),
                           SizedBox(height: 20.h),
                           Text(
                              'This is a standard mode where you can challenge your friend in a race against time. Take turns collecting as many shapes as you can in 60 seconds!',
                            style: TextStyle(
                                color: kTextColor,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                           SizedBox(height: 20.h),
                          _buildGameModeButton(
                            imagePath: 'assets/images/infinite_icon.png',
                            title: "INFINITE MOD",
                           // onTap: () => Get.toNamed('/maximum_number'),
                          ),
                           SizedBox(height: 20.h),
                           Text(
                            'This mode is an endless shape-finding challenge. Discover as many shapes as you can in your space — with no time limit!',
                            style: TextStyle(
                                color: kTextColor,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600
                            ),
                          )
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (){
                        Get.to(() => WhatsPsychogeometryScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kSecondaryColor,
                        minimumSize:  Size(double.infinity, 70.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                      ),
                      child:  Text(
                        'More About "Psychogeometry"',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameModeButton({
    required String title,
   // required VoidCallback onTap,
    required imagePath,
  }) {
    return GestureDetector(
     // onTap: onTap,
      child: Container(
        padding:  EdgeInsets.symmetric(vertical: 24.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.r,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          children: [
            Image.asset(imagePath, height: 68.h, color: kPrimaryColor),
             SizedBox(height: 10.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 22.sp,
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
