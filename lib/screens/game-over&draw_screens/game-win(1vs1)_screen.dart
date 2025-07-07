import 'package:flutter/material.dart';
import 'package:geometryhunter/gallery_store.dart';
import 'package:get/get.dart';
import 'package:geometryhunter/constants.dart';
import 'package:geometryhunter/screens/game_mode_screen.dart';
import 'package:geometryhunter/screens/1vs1game-mod_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class GameWin1vs1Screen extends StatelessWidget {
  final int player1Score;
  final int player2Score;

  const GameWin1vs1Screen({
    super.key,
    required this.player1Score,
    required this.player2Score,
  });

  @override
  Widget build(BuildContext context) {
    // Dynamically determine winner
    int winnerPlayer = player1Score > player2Score ? 1 : 2;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/bg.png', fit: BoxFit.cover),
          ),
          SafeArea(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
              child: Column(
                children: [
                   SizedBox(height: 40.h),

                  Container(
                    width: double.infinity,
                    padding:  EdgeInsets.symmetric(vertical: 18.h),
                    decoration: BoxDecoration(
                      color: kSecondaryColor,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child:  Center(
                      child: Text(
                        "GAME OVER!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                   SizedBox(height: 30.h),

                  Container(
                    width: double.infinity,
                    padding:  EdgeInsets.symmetric(vertical: 60.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10.r,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Image.asset('assets/images/person_icon.png', height: 36.h, color: kSecondaryColor),
                        SizedBox(width: 10.w),
                        Text(
                          'Player $winnerPlayer',
                          style: TextStyle(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.bold,
                            color: kSecondaryColor,
                          ),
                         ),
                        ],
                        ),
                         SizedBox(height: 10.h),
                         Text(
                          'WINS!',
                          style: TextStyle(
                            fontSize: 42.sp,
                            fontWeight: FontWeight.bold,
                            color: kSecondaryColor,
                          ),
                        ),
                         SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Image.asset('assets/images/person_icon.png', height: 22.h, color: kPlayerColor),
                                 SizedBox(width: 6.w),
                                 Text(
                                  'Player 1',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kPlayerColor,
                                    fontSize: 20.sp,
                                  ),
                                ),
                              ],
                            ),
                             SizedBox(width: 12.w),
                            Text(
                              '$player1Score : $player2Score',
                              style:  TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22.sp,
                                color: kPrimaryColor,
                              ),
                            ),
                             SizedBox(width: 12.w),
                            Row(
                              children: [
                                 Text(
                                  'Player 2',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize: 20.sp,
                                  ),
                                ),
                                 SizedBox(width: 6.w),
                                Image.asset('assets/images/person_icon.png', height: 20.h, color: Colors.red),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                   SizedBox(height: 30.h),

                  ElevatedButton(
                    onPressed: () {
                      GalleryStore.clear();
                      Get.to(() =>  WhosBiggerScreen());
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
                      style: TextStyle(color: Colors.white, fontSize: 20.sp),
                    ),
                  ),

                   SizedBox(height: 20.h),

                  ElevatedButton(
                    onPressed: () {
                      Get.to(() =>  GameModeScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize:  Size(double.infinity, 60.h),
                      backgroundColor: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                    child:  Text(
                      "Go to main menu",
                      style: TextStyle(color: Colors.white, fontSize: 20.sp),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
