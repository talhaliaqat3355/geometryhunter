import 'dart:io';
import 'package:GH0406/screens/photo_preview_screen.dart';
import 'package:GH0406/screens/select_shape_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';
import '../../gallery_store.dart';
import 'package:GH0406/screens/game_overanddraw_screens/game_draw_screen.dart';
import 'package:GH0406/screens/game_overanddraw_screens/game_win(tic_tac_toe)_screen.dart';

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

  String? player1Shape;
  String? player2Shape;
  bool player1ShapeSelected = false;
  bool player2ShapeSelected = false;

  Future<void> _captureImage(int index) async {
    if (_images[index] != null) return;

    if ((currentPlayer == 1 && !player1ShapeSelected) ||
        (currentPlayer == 2 && !player2ShapeSelected)) {
      await Get.to(() => SelectShapeScreen(
        onShapeSelected: (shapeName) {
          if (currentPlayer == 1) {
            player1Shape = shapeName;
            player1ShapeSelected = true;
          } else {
            player2Shape = shapeName;
            player2ShapeSelected = true;
          }
          Get.back();
          _openCamera(index);
        },
      ));
    } else {
      _openCamera(index);
    }
  }

  void _openCamera(int index) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      final shapeName = currentPlayer == 1 ? player1Shape! : player2Shape!;

      Get.to(() => PhotoPreviewScreen(
        imageFile: imageFile,
        shapeName: shapeName,
        onUsePhoto: () async {
          Get.back();

          final appDir = await getApplicationDocumentsDirectory();
          final fileName = 'img_${DateTime.now().millisecondsSinceEpoch}.jpg';
          final savedPath = path.join(appDir.path, fileName);
          final savedImage = await imageFile.copy(savedPath);

          setState(() {
            _images[index] = savedImage;
            _playerMoves[index] = currentPlayer;
            moveCount++;
          });

          GalleryStore.addImage(savedImage.path, shape: shapeName);

          if (_checkWinner(currentPlayer)) {
            Future.delayed(const Duration(milliseconds: 300), () {
              Get.to(() => GameWinScreen(
                winnerPlayer: currentPlayer,
                previousGameScreen: const TicTacToeScreen(),
              ));
            });
          } else if (moveCount == 9) {
            Get.to(() => GameDrawScreen(previousGameScreen: const TicTacToeScreen()));
          } else {
            setState(() {
              currentPlayer = currentPlayer == 1 ? 2 : 1;
            });
          }
        },
      ));
    }
  }

  bool _checkWinner(int player) {
    List<List<int>> winPositions = [
      [0, 1, 2], [3, 4, 5],
      [6, 7, 8], [0, 3, 6],
      [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6],
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
            child: Image.asset('assets/images/bg.png', fit: BoxFit.cover),
          ),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
                      child: Column(
                        children: [
                          SizedBox(height: 50.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/tic-tac_icon.png', height: 30.h),
                              SizedBox(width: 5.w),
                              Text("TIC TAC TOE - 3X3", style: kTicTacToeTextStyle),
                            ],
                          ),
                          const Divider(color: kPrimaryColor),
                          SizedBox(height: 20.h),
                          Stack(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _PlayerTag("Player 1", 1),
                                  _PlayerTag("Player 2", 2),
                                ],
                              ),
                              if (currentPlayer == 1 && player1Shape != null)
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  top: 0,
                                  child: Center(
                                    child: Image.asset(
                                      'assets/images/${player1Shape}_icon.png',
                                      height: 40.h,
                                    ),
                                  ),
                                ),
                              if (currentPlayer == 2 && player2Shape != null)
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  top: 0,
                                  child: Center(
                                    child: Image.asset(
                                      'assets/images/${player2Shape}_icon.png',
                                      height: 40.h,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 40.h),
                          AspectRatio(
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
                                            padding: EdgeInsets.all(12.w),
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
                                      child: Container(height: 2.h, color: kPrimaryColor),
                                    ),
                                    Positioned(
                                      top: (cellSize * 2) - 1,
                                      left: 0,
                                      right: 0,
                                      child: Container(height: 2.h, color: kPrimaryColor),
                                    ),
                                    Positioned(
                                      left: cellSize - 1,
                                      top: 0,
                                      bottom: 0,
                                      child: Container(width: 2.w, color: kPrimaryColor),
                                    ),
                                    Positioned(
                                      left: (cellSize * 2) - 1,
                                      top: 0,
                                      bottom: 0,
                                      child: Container(width: 2.w, color: kPrimaryColor),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.h, left: 20.w, right: 20.w),
                  child: ElevatedButton(
                    onPressed: () {
                      int? winner;
                      if (_checkWinner(1)) {
                        winner = 1;
                      } else if (_checkWinner(2)) {
                        winner = 2;
                      }

                      if (winner != null) {
                        Get.to(() => GameWinScreen(
                          winnerPlayer: winner!,
                          previousGameScreen: const TicTacToeScreen(),
                        ));
                      } else {
                        Get.to(() => GameDrawScreen(previousGameScreen: const TicTacToeScreen()));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 70.h),
                      backgroundColor: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                    child: Text("End game", style: kEndGameButtonTextStyle),
                  ),
                )
              ],
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

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
            padding: EdgeInsets.only(top: 10.h),
            child: Text(
              "Your move!",
              style: TextStyle(
                color: isPlayer1 ? Colors.blue.shade600 : Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
          ),
      ],
    );
  }
}
