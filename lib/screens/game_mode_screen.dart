import 'package:flutter/material.dart';
import 'package:geometryhunter/constants.dart';
import 'package:geometryhunter/screens/home_screen.dart';
import 'package:geometryhunter/screens/infinite-mod_screen.dart';
import 'package:geometryhunter/screens/tic-tac-3x3-gamemode_screen.dart';
import 'package:get/get.dart';
import 'package:geometryhunter/screens/1vs1game-mod_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GameModeScreen extends StatelessWidget {
  const GameModeScreen({super.key});

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
                    onTap: () {
                          Get.to(() => HomeScreen()) ;
                    },
                    child:  Row(
                      children: [
                        Icon(Icons.arrow_back_ios_rounded, size: 18.sp, color: kPrimaryColor),
                        SizedBox(width: 1.w),
                        Text(
                          "BACK",
                          style: kBackButtonTextStyle
                        ),
                      ],
                    ),
                  ),
                   SizedBox(height: 20.h),

                   Center(
                    child: Text(
                      "SELECT A MOD",
                      style: kSelectModTextStyle
                    ),
                  ),
                   SizedBox(height: 40.h),

                  Expanded(
                    child: ListView(
                      children: [
                        _buildGameModeButton(
                          imagePath: 'assets/images/tic-tac_icon.png',
                          title: "TIC TAC TOE - 3X3",
                          onTap: (){ Get.to(() => TicTacToeScreen());},
                        ),
                         SizedBox(height: 20.h),
                        _buildGameModeButton(
                          imagePath: 'assets/images/sword_icon.png',
                          title: "1 VS 1",
                          onTap: () {Get.to(() => WhosBiggerScreen());},
                        ),
                         SizedBox(height: 20.h),
                        _buildGameModeButton(
                          imagePath: 'assets/images/infinite_icon.png',
                          title: "INFINITE MOD",
                          onTap: (){Get.to(() => InfiniteModScreen());},
                        ),
                      ],
                    ),
                  )
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
    required VoidCallback onTap,
    required imagePath,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:  EdgeInsets.symmetric(vertical: 24.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4.r,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Image.asset(imagePath, height: 78.h, color: kPrimaryColor),
             SizedBox(height: 10.h),
            Text(
              title,
              style: kBuildGameModTitleTextStyle
            ),
          ],
        ),
      ),
    );
  }
}
