import 'package:flutter/material.dart';
import 'package:geometryhunter/screens/gallery_screen.dart';
import 'package:geometryhunter/screens/game-over&draw_screens/game-draw_screen.dart';
import 'package:geometryhunter/screens/game_mode_screen.dart';
import 'package:get/get.dart';
import '../constants.dart';
import 'package:geometryhunter/screens/guide_screen.dart';

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
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                children: [
                  const SizedBox(height: 40),
                    Image.asset(
                     'assets/images/logo.png',
                       height: 220,
                      width: 220,
                     ),
                  const SizedBox(height: 50),
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
                          Get.to(()=>GalleryScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
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
                ),
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
                Get.to(() => GuideScreen());
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
