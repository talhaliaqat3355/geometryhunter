import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';
import '../../controller/one_vs_one_controller.dart';
import '../../gallery_store.dart';
import '../game_screens/1vs1game_mod_screen.dart';
import '../game_mode_screen.dart';
import '../game_screens/tic-tac-3x3_game_mode_screen.dart';


class GameDrawScreen extends StatefulWidget {
  final Widget previousGameScreen;
  const GameDrawScreen({super.key, required this.previousGameScreen});

  @override
  State<GameDrawScreen> createState() => _GameDrawState();
}

class _GameDrawState extends State<GameDrawScreen> {
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
                  padding: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                     constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
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
                            padding:  EdgeInsets.symmetric(horizontal: 40.w, vertical: 70.h),
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
                            child:  Text(
                              'Draw',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 60.sp,
                                fontWeight: FontWeight.bold,
                                color: kDrawTextColor,
                              ),
                            ),
                          ),
                           SizedBox(height: 30.h),
                          ElevatedButton(
                            onPressed: () {
                              if (widget.previousGameScreen is WhosBiggerScreen) {
                                final OneVsOneController controller = Get.find<OneVsOneController>();
                                controller.resetGame() ;
                                Get.off(() =>  WhosBiggerScreen());
                              } else if (widget.previousGameScreen is TicTacToeScreen) {
                                GalleryStore.clear();
                                Get.off(() => const TicTacToeScreen());
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kSecondaryColor,
                              minimumSize:  Size(double.infinity, 70.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child:  Text(
                              'Start New Game',
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                           SizedBox(height: 20.h),
                          ElevatedButton(
                            onPressed: () {
                                final OneVsOneController controller = Get.find<OneVsOneController>();
                                controller.resetGame();
                                Get.offAll(() => GameModeScreen()); // completely reset to menu
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
                                fontSize: 20.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ]
                    ),
                    )
                  ),
                ),
              ),
          ]
        ),
    );
  }
}
