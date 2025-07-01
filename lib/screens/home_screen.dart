import 'package:flutter/material.dart';
import 'package:geometryhunter/screens/game_mode_screen.dart';
import 'package:get/get.dart';
import '../constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Center(
                  child: Image.asset(
                   'assets/images/logo.png',
                     height: 220,
                    width: 220,
                   ),
                 ),
                const SizedBox(height: 40),
                Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: (){
                      Get.to(() => GameModeScreen());
                    },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kSecondaryColor,
                        minimumSize: const Size(double.infinity, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                        child: const Text(
                          'Start New Game',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        ),
                    ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed('/gallery');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kSplashBGColor,
                        minimumSize: const Size(double.infinity, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Gallery',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                 ),
                )
               ]
              )
             ),
          Positioned(
            left: 20,
            bottom: 30,
            child: GestureDetector(
              onTap: () {

              },
                child: Image.asset(
                  'assets/images/music_icon.png',
                  height: 48,
                ),
            ),
          ),

          Positioned(
            right: 20,
            bottom: 30,
            child: GestureDetector(
              onTap: () {

              },
              child: Image.asset(
                'assets/images/help_icon.png',
                height: 48,
              ),
            ),
          ),
        ],
      )
    );
  }
}
