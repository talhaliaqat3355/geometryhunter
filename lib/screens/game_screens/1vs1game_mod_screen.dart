import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import '../../controller/one_vs_one_controller.dart';
import '../../gallery_store.dart';
import '../game-over&draw_screens/game-draw_screen.dart';
import '../game-over&draw_screens/game-win(1vs1)_screen.dart';

class WhosBiggerScreen extends StatelessWidget {
  WhosBiggerScreen({super.key});
  final OneVsOneController controller = Get.find<OneVsOneController>();

  @override
  Widget build(BuildContext context) {
    // Start timer only once
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!controller.timerStarted.value) {
        controller.startPlayerTimer(1, () {
          controller.switchToNextPlayer(() {
            _endGame();
          });
        });
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
                            Text("1 VS 1", style: k1vs1TextStyle),
                          ],
                        ),
                        const Divider(color: kPrimaryColor),
                        SizedBox(height: 20.h),
                        _buildTimerBar(context),
                        SizedBox(height: 20.h),
                        _buildPlayersRow(),
                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),
                ),
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
                    child: Text("End game", style: kEndGameButtonTextStyle),
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
    return Obx(() {
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
            width: MediaQuery.of(context).size.width *
                (controller.secondsLeft.value / 60),
            decoration: BoxDecoration(
              color: kSecondaryColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
          Positioned.fill(
            child: Center(
              child: Text(
                "${controller.secondsLeft.value} SEC",
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildPlayersRow() {
    return Obx(() {
      return Column(
        children: [
          // Player names and status row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _playerNameSection("Player 1", 1),
              Expanded(
                child: Column(
                  children: [
                    _centerShape(),
                  ],
                ),
              ),
              _playerNameSection("Player 2", 2),
            ],
          ),
          SizedBox(height: 20.h),
          // Images row - horizontally aligned
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Player 1 images
              Expanded(
                child: Column(
                  children: [
                    ..._buildPlayerImages(1),
                    if (controller.currentPlayer.value == 1)
                      _buildCameraButton(1),
                  ],
                ),
              ),
              SizedBox(width: 20.w),
              // Player 2 images
              Expanded(
                child: Column(
                  children: [
                    ..._buildPlayerImages(2),
                    if (controller.currentPlayer.value == 2)
                      _buildCameraButton(2),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    });
  }

  Widget _centerShape() {
    final current = controller.currentPlayer.value;
    final shape = controller.getPlayerShape(current);

    if (shape != null && shape.isNotEmpty) {
      return Image.asset('assets/images/${shape}_icon.png', height: 30.h);
    } else {
      return const SizedBox();
    }
  }

  Widget _playerNameSection(String name, int player) {
    bool isActive = controller.currentPlayer.value == player;
    bool isPlayer1 = player == 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/person_icon.png',
                height: 22.h,
                color:
                isActive ? Colors.white : (isPlayer1 ? Colors.blue : Colors.red),
              ),
              SizedBox(width: 4.w),
              Text(
                name,
                style: TextStyle(
                  color:
                  isActive ? Colors.white : (isPlayer1 ? Colors.blue : Colors.red),
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          height: 25.h, // Fixed height for consistent spacing
          child: isActive
              ? Text(
            "Your move!",
            style: TextStyle(
              color: isPlayer1 ? Colors.blue.shade600 : Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          )
              : null,
        ),
      ],
    );
  }

  List<Widget> _buildPlayerImages(int player) {
    return controller.playerImages[player]!
        .map((path) => Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Container(
        width: 90.w,
        height: 70.h,
        decoration: BoxDecoration(
          border: Border.all(color: kPlayerColor, width: 2.w),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Image.file(File(path), fit: BoxFit.cover),
      ),
    ))
        .toList();
  }

  Widget _buildCameraButton(int player) {
    return GestureDetector(
      onTap: () {
        controller.captureImage(player, () {
          controller.switchToNextPlayer(() {
            _endGame();
          });
        });
      },
      child: Padding(
        padding: EdgeInsets.only(top: 8.h),
        child: Image.asset('assets/images/camera_placeholder.png',
            height: 60.h),
      ),
    );
  }

  void _endGame() {
    int p1 = controller.getPlayerImageCount(1);
    int p2 = controller.getPlayerImageCount(2);
    if (p1 == 0 && p2 == 0 || p1 == p2) {
      Get.to(() => GameDrawScreen(previousGameScreen: WhosBiggerScreen()));
    } else {
      Get.to(() => GameWin1vs1Screen(player1Score: p1, player2Score: p2));
    }
  }
}


