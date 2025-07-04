import 'package:flutter/material.dart';
import 'package:geometryhunter/constants.dart';
import 'package:geometryhunter/screens/game_mode_screen.dart';
import 'package:get/get.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Image.asset(iconPath, width: 24, height: 24),
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
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 14),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    decoration: BoxDecoration(
                      color: kSecondaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "GAME OVER!",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20, fontWeight:
                      FontWeight.bold ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "$photoCount Photos",
                          style: TextStyle(
                            fontSize: 24,
                            color: kSecondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Shapes:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          alignment: WrapAlignment.center,
                          children: shapeList.map(_buildShapeIcon).toList(),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kSecondaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                        "Start new game",
                        style: TextStyle(color: Colors.white)
                    ),
                  ),

                  const SizedBox(height: 12),

                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => GameModeScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF002924),
                      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                        "Go to main menu",
                        style: TextStyle(color: Colors.white)
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
