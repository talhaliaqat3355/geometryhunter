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
      child: Image.asset(iconPath, width: 34, height: 24),
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
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 18),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: kSecondaryColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
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
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 70),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
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
                            fontSize: 40,
                            color: kSecondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          "Shapes:",
                          style: TextStyle(fontWeight: FontWeight.bold,color: kPrimaryColor,fontSize: 20),
                        ),
                        const SizedBox(height: 10),
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
                      minimumSize: const Size(double.infinity, 60),
                      backgroundColor: kSecondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                        "Start new game",
                        style: TextStyle(color: Colors.white,fontSize: 22)
                    ),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => GameModeScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity,60),
                      backgroundColor: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                        "Go to main menu",
                        style: TextStyle(color: Colors.white,fontSize: 22)
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
