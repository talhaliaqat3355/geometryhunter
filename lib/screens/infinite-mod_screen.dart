import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geometryhunter/constants.dart';
import 'package:geometryhunter/screens/select-shape_screen.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:geometryhunter/gallery_store.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geometryhunter/screens/game-over&draw_screens/game-over-infinite_screen.dart';

class InfiniteModScreen extends StatefulWidget {
  const InfiniteModScreen({super.key});

  @override
  State<InfiniteModScreen> createState() => _InfiniteModScreenState();
}

class _InfiniteModScreenState extends State<InfiniteModScreen> {
  final ImagePicker _picker = ImagePicker();
  List<File> _images = [];

  Future<void> _takePhoto() async {

    Get.to(() => SelectShapeScreen(onShapeSelected: (shape) async {
      Get.back(); // Close shape picker

      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        final appDir = await getApplicationDocumentsDirectory();
        final fileName = 'img_${DateTime.now().millisecondsSinceEpoch}.jpg';
        final savedPath = path.join(appDir.path, fileName);
        final File imageFile = await File(pickedFile.path).copy(savedPath);

        GalleryStore.addImage(imageFile.path, shape: shape);

        // Step 4: Update UI
        setState(() {
          _images.add(imageFile);
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
                fit: BoxFit.cover,
              )
          ),
          SafeArea(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/infinite_icon.png',
                          height: 30,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'INFINITE MOD',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: kPrimaryColor,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Divider(
                      color: kPrimaryColor,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _playerTag(),
                        Text(
                        '${_images.length} Photos',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Your move!',
                          style: TextStyle(
                          fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: kPlayerColor,
                        ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                            child: GridView.builder(
                              itemCount: _images.length + 1,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemBuilder: (context, index){
                                if(index == _images.length){
                                  return GestureDetector(
                                    onTap: _takePhoto,
                                    child: Image.asset('assets/images/camera_placeholder.png',height: 100,),
                                  );
                                }
                                else{
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                   child: Image.file(_images [index], fit: BoxFit.cover,)
                                  );
                                }
                              },
                            ),
                         ),
                          const SizedBox(height: 20 ),
                          Padding(padding: EdgeInsets.only(bottom: 20),
                            child: ElevatedButton(
                                onPressed: () {
                              final usedShapes = GalleryStore.getTaggedImages()
                                  .map((img) => img['shape'] as String?)
                                  .whereType<String>()
                                  .where((shape) => shape.trim().toLowerCase() != "all")
                                  .toSet()
                                  .toList();

                              Get.to(() => GameOverInfiniteScreen(
                                photoCount: _images.length,
                                shapeList: usedShapes,
                              ));
                            },

                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.infinity,60) ,
                                  backgroundColor: kPrimaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)
                                  )
                                ),
                                child: Text(
                                  'End game',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                                )
                            ),
                          )
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
  Widget _playerTag() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: kPlayerColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children:  [
          Image.asset('assets/images/person_icon.png', height: 22,color: Colors.white),
          SizedBox(width: 6),
          Text(
            "Player 1",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18
            ),
          )
        ],
      ),
    );
  }
}
