import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geometryhunter/constants.dart';
import 'package:geometryhunter/screens/game-over&draw_screens/game-draw_screen.dart';
import 'package:geometryhunter/screens/game-over&draw_screens/game-win(tic-tac-toe)_screen.dart';
import 'package:geometryhunter/screens/select-shape_screen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geometryhunter/gallery_store.dart';

class TicTacToeScreen extends StatefulWidget {
  const TicTacToeScreen({super.key});

  @override
  State<TicTacToeScreen> createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  List<File?> _images = List.generate(9, (_) => null);
  List<int?> _playerMoves = List.generate(9, (_) => null);
  int currentPlayer = 1;
  int moveCount = 0;

  final ImagePicker _picker = ImagePicker();

  Future<void> _captureImage(int index) async {
    if (_images[index] != null) return; // Prevent overwriting existing move

    Get.to(() => SelectShapeScreen(
      onShapeSelected: (shapeName) async {
        Get.back();
        final pickedFile = await _picker.pickImage(source: ImageSource.camera);

        if (pickedFile != null) {
          final File imageFile = File(pickedFile.path);

          setState(() {
            _images[index] = imageFile;
            _playerMoves[index] = currentPlayer;
            moveCount++;
          });

          GalleryStore.addImage(imageFile.path, shape: shapeName);

          if (_checkWinner(currentPlayer)) {
            Future.delayed(const Duration(milliseconds: 300), () {
              Get.to(() => GameWinScreen(winnerPlayer: currentPlayer));
            });
          }
          else if (moveCount == 9) {
            Get.to(() => const GameDrawScreen());
          } else {
            setState(() {
              currentPlayer = currentPlayer == 1 ? 2 : 1;
            });
          }
        }
      },
    ));
  }

  bool _checkWinner(int player) {
    List<List<int>> winPositions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var pos in winPositions) {
      if (_playerMoves[pos[0]] == player &&
          _playerMoves[pos[1]] == player &&
          _playerMoves[pos[2]] == player) {
        return true;
      }
    }
    return false;
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
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/tic-tac_icon.png', height: 30),
                      const SizedBox(width: 5),
                      const Text(
                        "TIC TAC TOE - 3X3",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          color: kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: kPrimaryColor,
                    endIndent: 10,
                    indent: 10,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _playerTag("Player 1", true, currentPlayer == 1),
                      Image.asset('assets/images/triangle_icon.png', height: 40),
                      _playerTag("Player 2", false, currentPlayer == 2),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            double cellSize = constraints.maxWidth / 3;

                            return Stack(
                              children: [
                                GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 9,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                  ),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () => _captureImage(index),
                                      child: Container(
                                        color: Colors.transparent,
                                        padding: const EdgeInsets.all(12),
                                        child: _images[index] != null
                                            ? Image.file(_images[index]!, fit: BoxFit.cover)
                                            : Image.asset('assets/images/camera_placeholder.png'),
                                      ),
                                    );
                                  },
                                ),
                                Positioned(
                                  top: cellSize - 1,
                                  left: 0,
                                  right: 0,
                                  child: Container(height: 2, color: kPrimaryColor),
                                ),
                                Positioned(
                                  top: (cellSize * 2) - 1,
                                  left: 0,
                                  right: 0,
                                  child: Container(height: 2, color: kPrimaryColor),
                                ),
                                Positioned(
                                  left: cellSize - 1,
                                  top: 0,
                                  bottom: 150,
                                  child: Container(width: 2, color: kPrimaryColor),
                                ),
                                Positioned(
                                  left: (cellSize * 2) - 1,
                                  top: 0,
                                  bottom: 150,
                                  child: Container(width: 2, color: kPrimaryColor),
                                ),
                              ],
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
                        int? winner;
                        if (_checkWinner(1)) {
                          winner = 1;
                        } else if (_checkWinner(2)) {
                          winner = 2;
                        }

                        if (winner != null) {
                          Get.to(() => GameWinScreen(winnerPlayer: winner!));
                        } else {
                          Get.to(() => const GameDrawScreen());
                        }
                      },

                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 60),
                        backgroundColor: kPrimaryColor,
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
          ),
        ],
      ),
    );
  }

  Widget _playerTag(String name, bool isBlue, bool isActive) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: isBlue ? Colors.blue.shade600 : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
             Image.asset('assets/images/person_icon.png', height: 20,color: isBlue ? Colors.white: Colors.red),
             // Icon(Icons.person, size: 24, color: isBlue ? Colors.white : Colors.red),
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
              style: TextStyle(color: kPlayerColor, fontWeight: FontWeight.bold, fontSize: 18),
            ),
          )
      ],
    );
  }
}
