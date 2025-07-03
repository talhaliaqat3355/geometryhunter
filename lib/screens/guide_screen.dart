import 'package:flutter/material.dart';
import 'package:geometryhunter/constants.dart';
import 'package:get/get.dart';
import 'package:geometryhunter/screens/whats-psychogeometry_screen.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

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
                      onTap: () => Get.back(),
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
              
                    Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Image.asset('assets/images/guide_icon.png'),
                     SizedBox(width: 4),
                     Text(
                          "HOW TO PLAY?",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                       ]
                      ),
                    Divider(
                      color: kPrimaryColor,
                    ),
                    const SizedBox(height: 30),
              
                    Expanded(
                      child: ListView(
                        children: [
                          _buildGameModeButton(
                            imagePath: 'assets/images/tic-tac_icon.png',
                            title: "TIC TAC TOE - 3X3",
                           // onTap: (){ Get.to(() => TicTacToeScreen());},
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'In this mode, two players compete in a game similar to tic-tac-toe.Outsmart your opponent by forming a winning combination of different shapes!',
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildGameModeButton(
                            imagePath: 'assets/images/sword_icon.png',
                            title: "1 VS 1",
                           // onTap: () => Get.toNamed('/tic_tac_toe'),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                              'This is a standard mode where you can challenge your friend in a race against time. Take turns collecting as many shapes as you can in 60 seconds!',
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildGameModeButton(
                            imagePath: 'assets/images/infinite_icon.png',
                            title: "INFINITE MOD",
                           // onTap: () => Get.toNamed('/maximum_number'),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'This mode is an endless shape-finding challenge. Discover as many shapes as you can in your space — with no time limit!',
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w600
                            ),
                          )
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (){
                        Get.to(() => WhatsPsychogeometryScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kSecondaryColor,
                        minimumSize: const Size(double.infinity, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'More About "Psychogeometry"',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
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
   // required VoidCallback onTap,
    required imagePath,
  }) {
    return GestureDetector(
     // onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          children: [
            Image.asset(imagePath, height: 68, color: kPrimaryColor),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
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
