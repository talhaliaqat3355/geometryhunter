import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geometryhunter/constants.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import '../gallery_store.dart';
import 'package:geometryhunter/screens/select-shape_screen.dart';
import 'package:geometryhunter/screens/game-over&draw_screens/game-draw_screen.dart';
import 'package:geometryhunter/screens/game-over&draw_screens/game-win(1vs1)_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WhosBiggerScreen extends StatefulWidget {
  const WhosBiggerScreen({super.key});

  @override
  State<WhosBiggerScreen> createState() => _WhosBiggerScreenState();
}
class _WhosBiggerScreenState extends State<WhosBiggerScreen> {
  final ImagePicker _picker = ImagePicker();
  String? player1ImagePath;
  String? player2ImagePath;

  int currentPlayer = 1;
  int secondsLeft = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft == 0) {
        timer.cancel();

        int player1Count = _getPlayerImageCount(1);
        int player2Count = _getPlayerImageCount(2);

        if (player1Count == 0 && player2Count == 0) {
          Get.to(() => const GameDrawScreen());
        } else if (player1Count == player2Count) {
          Get.to(() => const GameDrawScreen());
        } else {
          Get.to(() => GameWin1vs1Screen(
            player1Score: player1Count,
            player2Score: player2Count,
          ));
        }
      } else {
        setState(() {
          secondsLeft--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _takeTurn() async {
    Get.to(() => SelectShapeScreen(onShapeSelected: (shape) async {
      Get.back();

      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        final appDir = await getApplicationDocumentsDirectory();
        final fileName = 'img_${DateTime.now().millisecondsSinceEpoch}.jpg';
        final savedPath = path.join(appDir.path, fileName);
        final File imageFile = await File(pickedFile.path).copy(savedPath);

        GalleryStore.addImage(
          imageFile.path,
          shape: shape,
          player: currentPlayer,
        );

        setState(() {
          if (currentPlayer == 1) {
            player1ImagePath = imageFile.path;
          } else {
            player2ImagePath = imageFile.path;
          }
          currentPlayer = currentPlayer == 1 ? 2 : 1;
        });
      }
    }));
  }

  int _getPlayerImageCount(int playerNumber) {
    return GalleryStore.getTaggedImages()
        .where((img) => img['player'] == playerNumber)
        .length;
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
              padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
              child: Column(
                children: [
                   SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/sword_icon.png', height: 40.h),
                       SizedBox(width: 8.w),
                       Text(
                        "1 VS 1",
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                        ),
                      )
                    ],
                  ),
                  const Divider(color: kPrimaryColor),
                   SizedBox(height: 20.h),

                  // Timer Bar
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 0),
                    child: Stack(
                      children: [
                        Container(
                          height: 40.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 40.h,
                          width: MediaQuery.of(context).size.width * (secondsLeft / 60),
                          decoration: BoxDecoration(
                            color: kSecondaryColor,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                        Positioned.fill(
                          child: Center(
                            child: Text(
                              "$secondsLeft SEC",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                   SizedBox(height: 20.h),

                  // Player tags and score / icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Player 1 + Camera
                      Column(
                        children: [
                          _PlayerTag("Player 1", 1),
                          if (currentPlayer == 1)
                             SizedBox(height: 10.h),
                          if (currentPlayer == 1)
                            GestureDetector(
                              onTap: _takeTurn,
                              child: Image.asset(
                                'assets/images/camera_placeholder.png',
                                height: 60.h,
                              ),
                            ),
                        ],
                      ),
                          // Score or Triangle Ico
                      SizedBox(
                        height: 50.h, // adjust based on your layout
                        child: Center(
                          child: GalleryStore.getTaggedImages().isEmpty
                              ? Image.asset('assets/images/triangle-shape_icon.png', height: 30.h)
                              : Text(
                            "${_getPlayerImageCount(1)} : ${_getPlayerImageCount(2)}",
                            style:  TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ),

                      // Player 2 + Camera
                      Column(
                        children: [
                          _PlayerTag("Player 2", 2),
                          if (currentPlayer == 2)
                             SizedBox(height: 10.h),
                          if (currentPlayer == 2)
                            GestureDetector(
                              onTap: _takeTurn,
                              child: Image.asset(
                                'assets/images/camera_placeholder.png',
                                height: 60.h,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
               //   const SizedBox(height: 16),
                  const Spacer(),

                  Padding(
                   padding:  EdgeInsets.only(bottom: 20.h),
                        child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize:  Size(double.infinity, 60.h),
                            backgroundColor: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                          ),
                          child:  Text(
                            "End game",
                            style: TextStyle(color: Colors.white, fontSize: 18.sp),
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
  Widget _PlayerTag(String name, int playerNumber) {
    final bool isActive = currentPlayer == playerNumber;
    final bool isPlayer1 = playerNumber == 1;

    final Color activeColor = isPlayer1 ? Colors.blue.shade600 : Colors.red.shade600;
    final Color textColor = Colors.white;

    // Pick correct image path
    String? imagePath = isPlayer1 ? player1ImagePath : player2ImagePath;

    return Column(
      children: [
        Container(
          padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: isActive ? activeColor : Colors.transparent,
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
                  color: isActive ? textColor : (isPlayer1 ? Colors.blue : Colors.red),
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
            ],
          ),
        ),
        if (isActive)
          Padding(
            padding:  EdgeInsets.only(top: 10.h),
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
            child: Image.file(
              File(imagePath),
              fit: BoxFit.cover,
            ),
          ),
      ],
    );
  }
}

