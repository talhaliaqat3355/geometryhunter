import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';
import '../../controller/onevsonecontroller.dart';
import '../1vs1game-mod_screen.dart';
import '../game_mode_screen.dart';

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
    final int winner = player1Score > player2Score ? 1 : 2;

    return Scaffold(
      body: Stack(children: [
        Positioned.fill(
          child: Image.asset('assets/images/bg.png', fit: BoxFit.cover),
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: SingleChildScrollView(
              child: ConstrainedBox(constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              child: Column(children: [
                SizedBox(height: 40.h),
                _gameOverBanner(),
                SizedBox(height: 20.h),
                _winnerBox(winner),
                SizedBox(height: 30.h),
                _startNewGameButton(),
                SizedBox(height: 20.h),
                _mainMenuButton(),
              ]),
            ),
          ),
        ),
        )
       ]
      ),
    );
  }

  Widget _gameOverBanner() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
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
    );
  }

  Widget _winnerBox(int winnerPlayer) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(48),
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
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/person_icon.png',
              height: 30.h,
              color: kSecondaryColor,
            ),
            SizedBox(width: 7.w),
            Text(
              "Player $winnerPlayer",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: kSecondaryColor,
              ),
            ),
          ],
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
      ]),
    );
  }

  Widget _startNewGameButton() {
    return ElevatedButton(
      onPressed: () {
        final controller = Get.find<OneVsOneController>();
        controller.resetGame();
        Get.off(() =>  WhosBiggerScreen());
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: kSecondaryColor,
        minimumSize: Size(double.infinity, 70.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
      ),
      child: Text(
        'Start New Game',
        style: TextStyle(
          fontSize: 18.sp,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _mainMenuButton() {
    return ElevatedButton(
      onPressed: () {
        final controller = Get.find<OneVsOneController>();
        controller.resetGame();
        Get.off(() => GameModeScreen());
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryColor,
        minimumSize: Size(double.infinity, 70.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
      ),
      child: Text(
        'Go to main menu',
        style: TextStyle(
          fontSize: 18.sp,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
