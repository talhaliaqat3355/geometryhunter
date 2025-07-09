import 'package:flutter/material.dart';
import 'package:geometryhunter/constants.dart';
import 'package:geometryhunter/gallery_store.dart';
import 'package:geometryhunter/screens/game_mode_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GameWinScreen extends StatelessWidget {
  final int winnerPlayer;
  final Widget previousGameScreen;
  const GameWinScreen({super.key, required this.winnerPlayer, required this.previousGameScreen});

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
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height
                    ),
                  child: Column(
                      children: [
                         SizedBox(height: 40.h),
                        Container(
                          width: double.infinity,
                          padding:  EdgeInsets.symmetric(
                            horizontal: 32.w,
                            vertical: 16.h,
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
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                         SizedBox(height: 20.h),
                        Container(
                          width: double.infinity,
                          padding:  EdgeInsets.all(48),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20.r,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child:  Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                Image.asset('assets/images/person_icon.png',
                                height: 30.h,
                                color: kSecondaryColor
                                ),
                                   SizedBox(width: 7.w),
                                  Text(
                                    "Player $winnerPlayer",
                                  style:TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: kSecondaryColor,
                                  ) ,)
                               ]
                              ),
                             SizedBox(height: 10.h),
                            Text(
                              'WINS!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 60.sp,
                                fontWeight: FontWeight.bold,
                                color: kSecondaryColor,
                              ),
                            ),
                            ]
                          ),
                        ),
                         SizedBox(height: 30.h),
                        ElevatedButton(
                          onPressed: (){
                            GalleryStore.clear();
                            Get.off(() => previousGameScreen);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kSecondaryColor,
                            minimumSize:  Size(double.infinity, 70.h),
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
                            Get.to(()=>GameModeScreen());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            minimumSize:  Size(double.infinity, 70.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                          ),
                          child:  Text(
                            'Go to main menu',
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ]
                  ),
                ),
                )
              ),
            ),
          ]
      ),
    );
  }
}
