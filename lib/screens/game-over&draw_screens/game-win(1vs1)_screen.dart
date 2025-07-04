import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geometryhunter/constants.dart';
import 'package:geometryhunter/screens/game_mode_screen.dart';

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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                      color: kSecondaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        "GAME OVER!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 60),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Image.asset('assets/images/person_icon.png', height: 36, color: kSecondaryColor),
                       const SizedBox(width: 10),
                        Text(
                          'Player $winnerPlayer',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: kSecondaryColor,
                          ),
                         ),
                        ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'WINS!',
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            color: kSecondaryColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Image.asset('assets/images/person_icon.png', height: 22, color: kPlayerColor),
                                const SizedBox(width: 6),
                                const Text(
                                  'Player 1',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kPlayerColor,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 12),
                            Text(
                              '$player1Score : $player2Score',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: kPrimaryColor,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Row(
                              children: [
                                const Text(
                                  'Player 2',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Image.asset('assets/images/person_icon.png', height: 20, color: Colors.red),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

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
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => const GameModeScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 60),
                      backgroundColor: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Go to main menu",
                      style: TextStyle(color: Colors.white, fontSize: 20),
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
