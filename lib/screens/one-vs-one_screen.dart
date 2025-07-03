import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geometryhunter/constants.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import '../screens/gallery_store.dart';
import 'package:geometryhunter/screens/select-shape_screen.dart';

class WhosBiggerScreen extends StatefulWidget {
  const WhosBiggerScreen({super.key});

  @override
  State<WhosBiggerScreen> createState() => _WhosBiggerScreenState();
}

class _WhosBiggerScreenState extends State<WhosBiggerScreen> {
  final ImagePicker _picker = ImagePicker();
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
        // Game over logic here
        Get.snackbar("Time's up!", "Game has ended.");
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

        GalleryStore.addImage(imageFile.path, shape: shape);

        setState(() {
          currentPlayer = currentPlayer == 1 ? 2 : 1;
        });
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/bg.png',
                fit: BoxFit.cover),
          ),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     Image.asset('assets/images/sword_icon.png',
                     height: 40,
                     ),
                      SizedBox(width: 8),
                      Text(
                        "1 VS 1",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                        ),
                      )
                    ],
                  ),
                 const Divider(
                    color: kPrimaryColor,
                  ),
                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Stack(
                      children: [
                        Container(
                          height: 18,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 18,
                          width: MediaQuery.of(context).size.width * (secondsLeft / 60),
                          decoration: BoxDecoration(
                            color: kSecondaryColor,
                            borderRadius: BorderRadius.circular(20),
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

                  const SizedBox(height: 16),

                  // 👤 Players & Turn
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _PlayerTag("Player 1", true, currentPlayer == 1),
                      Image.asset('assets/images/triangle_icon.png', height: 30),
                      _PlayerTag("Player 2", false, currentPlayer == 2),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (currentPlayer == 1) ...[
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: _takeTurn,
                            child: Image.asset(
                              'assets/images/camera_placeholder.png',
                              height: 100,
                            ),
                          ),
                        ],
                        const Spacer(),
                        if (currentPlayer == 2) ...[
                          GestureDetector(
                            onTap: _takeTurn,
                            child: Image.asset(
                              'assets/images/camera_placeholder.png',
                              height: 100,
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "End game",
                        style: TextStyle(color: Colors.white, fontSize: 18),
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

  Widget _PlayerTag(String name, bool isBlue, bool isActive) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isBlue ? Colors.blue.shade600 : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Icon(Icons.person, size: 24, color: isBlue ? Colors.white : Colors.red),
              const SizedBox(width: 4),
              Text(
                name,
                style: TextStyle(
                  color: isBlue ? Colors.white : Colors.red,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        if (isActive)
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "Your move!",
              style: TextStyle(color: kPlayerColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          )
      ],
    );
  }
}
