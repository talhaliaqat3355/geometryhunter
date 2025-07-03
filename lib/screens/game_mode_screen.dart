import 'package:flutter/material.dart';
import 'package:geometryhunter/constants.dart';
import 'package:geometryhunter/screens/home_screen.dart';
import 'package:geometryhunter/screens/infinite-mod_screen.dart';
import 'package:geometryhunter/screens/tic-tac-3x3-gamemode_screen.dart';
import 'package:get/get.dart';
import 'package:geometryhunter/screens/one-vs-one_screen.dart';

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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                          Get.to(() => HomeScreen()) ;
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.arrow_back_ios_rounded, size: 18, color: kPrimaryColor),
                        SizedBox(width: 1),
                        Text(
                          "BACK",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Center(
                    child: Text(
                      "SELECT A MOD",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  Expanded(
                    child: ListView(
                      children: [
                        _buildGameModeButton(
                          imagePath: 'assets/images/tic-tac_icon.png',
                          title: "TIC TAC TOE - 3X3",
                          onTap: (){ Get.to(() => TicTacToeScreen());},
                        ),
                        const SizedBox(height: 20),
                        _buildGameModeButton(
                          imagePath: 'assets/images/sword_icon.png',
                          title: "1 VS 1",
                          onTap: () {Get.to(() => WhosBiggerScreen());},
                        ),
                        const SizedBox(height: 20),
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
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Image.asset(imagePath, height: 78, color: kPrimaryColor),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 26,
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
