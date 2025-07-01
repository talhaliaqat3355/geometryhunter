import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geometryhunter/constants.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class TicTacToeScreen extends StatefulWidget {
  const TicTacToeScreen({super.key});

  @override
  State<TicTacToeScreen> createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  List<File?> _images = List.generate(9, (_) => null);
  int currentPlayer = 1;

  final ImagePicker _picker = ImagePicker();

  Future<void> _captureImage(int index) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _images[index] = File(pickedFile.path);
        currentPlayer = currentPlayer == 1 ? 2 : 1;
      });
    }
  }

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
              children: [
                const SizedBox(height: 16),
                const Text(
                  "TIC TAC TOE - 3X3",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _playerTag("Player 1", true, currentPlayer == 1),
                    const Text("🔺",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    _playerTag("Player 2", false, currentPlayer == 2),
                  ],
                ),
                const SizedBox(height: 10),
                //  Status
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Your move!",
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                //  Grid
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: GridView.builder(
                        itemCount: 9,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 6,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => _captureImage(index),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 1),
                              ),
                              child: _images[index] != null
                                  ? Image.file(_images[index]!, fit: BoxFit.cover)
                                  : Container(
                                padding: const EdgeInsets.all(12),
                                child: Image.asset('assets/images/photoAdd.png'),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:kSplashBGColor,
                      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "End game",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _playerTag(String name, bool isBlue, bool isActive) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isBlue ? Colors.blue : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: isBlue ? Colors.blue : Colors.red),
          ),
          child: Row(
            children: [
              Icon(Icons.person, size: 20, color: isBlue ? Colors.white : Colors.red),
              const SizedBox(width: 4),
              Text(
                name,
                style: TextStyle(
                  color: isBlue ? Colors.white : Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
