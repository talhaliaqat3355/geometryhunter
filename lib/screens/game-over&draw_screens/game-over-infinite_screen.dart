import 'package:flutter/material.dart';
import 'package:geometryhunter/constants.dart';
import 'package:geometryhunter/screens/game_mode_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GameOverInfiniteScreen extends StatelessWidget {
  final int photoCount;
  final List<String> shapeList; // e.g., ["circle", "rectangle", "zigzag", "triangle"]

  const GameOverInfiniteScreen({
    super.key,
    required this.photoCount,
    required this.shapeList,
  });

  Widget _buildShapeIcon(String shape) {
    String iconPath = 'assets/images/${shape}_icon.png';
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 4.w),
      child: Image.asset(iconPath, width: 34.w, height: 24.h),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/bg.png', fit: BoxFit.cover),
          ),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 18.h),
              child: Column(
                children: [
                   SizedBox(height: 40.h),
                  Container(
                    width: double.infinity,
                    padding:  EdgeInsets.symmetric(
                      horizontal: 32.w,
                      vertical: 20.h,
                    ),
                    decoration: BoxDecoration(
                      color: kSecondaryColor,
                      borderRadius: BorderRadius.circular(10.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8.r,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'GAME OVER!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                   SizedBox(height: 30.h),

                  Container(
                    width: double.infinity,
                    padding:  EdgeInsets.symmetric(horizontal: 40.w ,vertical: 70.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "$photoCount Photos",
                          style: TextStyle(
                            fontSize: 40.sp,
                            color: kSecondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                         SizedBox(height: 30.h),
                         Text(
                          "Shapes:",
                          style: TextStyle(fontWeight: FontWeight.bold,color: kPrimaryColor,fontSize: 20.sp),
                        ),
                         SizedBox(height: 10.h),
                        Wrap(
                          alignment: WrapAlignment.center,
                          children: shapeList.map(_buildShapeIcon).toList(),
                        )
                      ],
                    ),
                  ),

                   SizedBox(height: 40.h),

                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize:  Size(double.infinity, 60.h),
                      backgroundColor: kSecondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                    child:  Text(
                        "Start new game",
                        style: TextStyle(color: Colors.white,fontSize: 22.sp)
                    ),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => GameModeScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize:  Size(double.infinity,60.h),
                      backgroundColor: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                    child:  Text(
                        "Go to main menu",
                        style: TextStyle(color: Colors.white,fontSize: 22.sp)
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
