import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geometryhunter/constants.dart';
import 'package:geometryhunter/screens/gallery_screen.dart';
import 'package:geometryhunter/screens/select-shape_screen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geometryhunter/screens/gallery_store.dart';

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
    Get.to(() => SelectShapeScreen(
        onShapeSelected: (ShapeName) async{
          Get.back();
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);

      setState(() {
        _images[index] = imageFile;
        currentPlayer = currentPlayer == 1 ? 2 : 1;
      });

      //  Save image to GalleryStore
      GalleryStore.addImage(imageFile.path, shape: "Rectangle");
    }
        },
        ),
    );
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
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/tic-tac_icon.png',height: 30,),
                      SizedBox(width: 5),
                      Text(
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
                  Divider(
                    color: kPrimaryColor,
                    endIndent: 10,
                    indent: 10,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _playerTag("Player 1", true, currentPlayer == 1),
                    Image.asset('assets/images/triangle_icon.png',height: 40),
                      _playerTag("Player 2", false, currentPlayer == 2),
                    ],
                  ),
                  const SizedBox(height: 40),
                  //  Grid
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
                                // Horizontal
                                Positioned(
                                  top: cellSize - 1, // line b/w row 1 and 2
                                  left: 0,
                                  right: 0,
                                  child: Container(height: 2, color: kPrimaryColor),
                                ),
                                Positioned(
                                  top: (cellSize * 2) - 1, // line b/w row 2 and 3
                                  left: 0,
                                  right: 0,
                                  child: Container(height: 2, color:kPrimaryColor),
                                ),

                                // Vertical
                                Positioned(
                                  left: cellSize - 1, // line b/w column 1 and 2
                                  top: 0,
                                  bottom: 150,
                                  child: Container(width: 2, color:kPrimaryColor),
                                ),
                                Positioned(
                                  left: (cellSize * 2) - 1, // line b/w column 2 and 3
                                  top: 0,
                                  bottom: 150,
                                  child: Container(width: 2, color: kPrimaryColor, height: 1),
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
                        Get.to(() => GalleryScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:kPrimaryColor,
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
           // border: Border.all(color: isBlue ? Colors.blue : Colors.red),
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
                  fontSize: 18
                ),
              ),
            ],
          ),
        ),if(isActive)
          const Padding(padding: EdgeInsets.only(top: 10),
              child: Text(
                "Your move!",
                style: TextStyle(color: kPlayerColor, fontWeight: FontWeight.bold,fontSize: 18),
              )
          )
      ],
    );
  }
}
