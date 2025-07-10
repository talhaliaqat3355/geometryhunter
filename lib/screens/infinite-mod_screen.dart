import 'dart:io';
import 'dart:async';
import 'package:GH0406/screens/photo-preview_screen.dart';
import 'package:GH0406/screens/select-shape_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants.dart';
import '../gallery_store.dart';
import 'game-over&draw_screens/game-over-infinite_screen.dart';

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
        final File imageFile = File(pickedFile.path);

        Get.to(() => PhotoPreviewScreen(
          imageFile: imageFile,
          shapeName: shape,
          onUsePhoto: () async {
            final appDir = await getApplicationDocumentsDirectory();
            final fileName = 'img_${DateTime.now().millisecondsSinceEpoch}.jpg';
            final savedPath = path.join(appDir.path, fileName);
            final File savedImage = await imageFile.copy(savedPath);

            GalleryStore.addImage(savedImage.path, shape: shape);
            setState(() {
              _images.add(savedImage);
            });
            Get.back(); // Close preview screen
          },
        ));
      }
    }));
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
              )),
          SafeArea(
            child: Column(
              children: [
                // Main scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/infinite_icon.png', height: 40.h),
                            SizedBox(width: 10.w),
                            Text(
                              'INFINITE MOD',
                              style: kInfiniteModTextStyle
                            )
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Divider(color: kPrimaryColor),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _playerTag(),
                            Text(
                              '${_images.length} Photos',
                              style: kPhotoCountTextStyle
                            )
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Your move!',
                              style: kYoursMoveTextStyle
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),

                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _images.length + 1,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            if (index == _images.length) {
                              return GestureDetector(
                                onTap: _takePhoto,
                                child: Image.asset(
                                  'assets/images/camera_placeholder.png',
                                  height: 100,
                                ),
                              );
                            } else {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child: Image.file(
                                  _images[index],
                                  fit: BoxFit.cover,
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
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
                      minimumSize: Size(double.infinity, 70.h),
                      backgroundColor: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                    child: Text(
                      'End game',
                      style: kEndGameButtonTextStyle
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _playerTag() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: kPlayerColor,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          Image.asset('assets/images/person_icon.png', height: 22.h, color: Colors.white),
          SizedBox(width: 6.w),
          Text(
            "Player 1",
            style: kPlayer1TextStyle
          )
        ],
      ),
    );
  }
}
