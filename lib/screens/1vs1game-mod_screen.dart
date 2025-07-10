import 'dart:io';
import 'package:GH0406/screens/select-shape_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';
import '../controller/one_vs_one_controller.dart';
import '../gallery_store.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'game-over&draw_screens/game-draw_screen.dart';
import 'game-over&draw_screens/game-win(1vs1)_screen.dart';

class WhosBiggerScreen extends StatelessWidget {
  WhosBiggerScreen({super.key});
  final OneVsOneController controller = Get.find<OneVsOneController>();

  @override
  Widget build(BuildContext context) {
    controller.startTimer(() {
      int p1 = controller.getPlayerImageCount(1);
      int p2 = controller.getPlayerImageCount(2);
      if (p1 == 0 && p2 == 0 || p1 == p2) {
        Get.to(() => GameDrawScreen(previousGameScreen: WhosBiggerScreen()));
      } else {
        Get.to(() => GameWin1vs1Screen(player1Score: p1, player2Score: p2));
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/bg.png', fit: BoxFit.cover),
          ),
          SafeArea(
            child: Column(
              children: [
                // scrollable part
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/sword_icon.png', height: 40.h),
                            SizedBox(width: 8.w),
                            Text("1 VS 1", style: k1vs1TextStyle
                            ),
                          ],
                        ),
                        const Divider(color: kPrimaryColor),
                        SizedBox(height: 20.h),

                        Obx(() => _buildTimerBar(context)),
                        SizedBox(height: 20.h),
                        Obx(() => _buildPlayersRow()),
                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),
                ),

                // pinned bottom button
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 12.h),
                  child: ElevatedButton(
                    onPressed: () {
                      controller.resetGame();
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 70.h),
                      backgroundColor: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                    child: Text(
                        "End game",
                        style: kEndGameButtonTextStyle
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimerBar(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 42.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 42.h,
          width: MediaQuery.of(context).size.width * (controller.secondsLeft.value / 60),
          decoration: BoxDecoration(
            color: kSecondaryColor,
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        Positioned.fill(
          child: Center(
            child: Text(
              "${controller.secondsLeft.value} SEC",
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlayersRow() {
    final hasAnyMove = GalleryStore.getTaggedImages().isNotEmpty;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _playerColumn("Player 1", 1, controller.player1ImagePath),
        Expanded(
          child: Column(
            children: [
              SizedBox(height: 5.h),
              Center(
                child: hasAnyMove
                    ? Text(
                  "${controller.getPlayerImageCount(1)} : ${controller.getPlayerImageCount(2)}",
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                )
                    : Image.asset('assets/images/triangle-shape_icon.png', height: 30.h),
              ),
            ],
          ),
        ),
        _playerColumn("Player 2", 2, controller.player2ImagePath),
      ],
    );
  }

  Widget _playerColumn(String name, int number, String? imagePath) {
    bool isActive = controller.currentPlayer.value == number;
    final bool isPlayer1 = number == 1;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: isActive
                ? (isPlayer1 ? Colors.blue.shade600 : Colors.red.shade600)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/images/person_icon.png',
                height: 22.h,
                color: isActive ? Colors.white : (isPlayer1 ? Colors.blue : Colors.red),
              ),
              SizedBox(width: 4.w),
              Text(
                name,
                style: TextStyle(
                  color: isActive ? Colors.white : (isPlayer1 ? Colors.blue : Colors.red),
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
            ],
          ),
        ),
        if (isActive)
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: Text(
              "Your move!",
              style: TextStyle(
                color: isPlayer1 ? Colors.blue.shade600 : Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
          ),
        SizedBox(height: 20.h),
        if (imagePath != null)
          Container(
            width: 80.w,
            height: 60.h,
            decoration: BoxDecoration(
              border: Border.all(color: kPlayerColor, width: 2.w),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Image.file(File(imagePath), fit: BoxFit.cover),
          ),
        if (isActive)
          GestureDetector(
            onTap: () {
              Get.to(() => SelectShapeScreen(
                onShapeSelected: (shape) async {
                  Get.back();
                  await controller.takeTurn((imagePath) {
                    // optional: trigger UI update
                  }, shape);
                },
              ));
            },
            child: Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Image.asset('assets/images/camera_placeholder.png', height: 60.h),
            ),
          ),
      ],
    );
  }
}