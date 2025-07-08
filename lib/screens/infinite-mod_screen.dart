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
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                padding: EdgeInsets.symmetric(horizontal:20.w, vertical: 20.h),
                child: Column(
                  children: [
                     SizedBox(height: 40.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/infinite_icon.png',
                          height: 40.h,
                        ),
                         SizedBox(width: 10.w),
                        Text(
                          'INFINITE MOD',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.sp,
                            color: kPrimaryColor,
                          ),
                        )
                      ],
                    ),
                     SizedBox(height: 10.h),
                    Divider(
                      color: kPrimaryColor,
                    ),
                     SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _playerTag(),
                        Text(
                        '${_images.length} Photos',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor
                          ),
                        )
                      ],
                    ),
                     SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child:  Text(
                          'Your move!',
                          style: TextStyle(
                          fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                            color: kPlayerColor,
                        ),
                        ),
                      ),
                    ),
                     SizedBox(height: 20.h),
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
                                    borderRadius: BorderRadius.circular(8.r),
                                   child: Image.file(_images [index], fit: BoxFit.cover,)
                                  );
                                }
                              },
                            ),
                         ),
                           SizedBox(height: 20.h ),
                          Padding(padding: EdgeInsets.only(bottom: 20.h),
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
                                  minimumSize:  Size(double.infinity,60.h) ,
                                  backgroundColor: kPrimaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.r)
                                  )
                                ),
                                child: Text(
                                  'End game',
                                style: TextStyle(
                                  fontSize: 18.sp,
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
      padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: kPlayerColor,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children:  [
          Image.asset('assets/images/person_icon.png', height: 22.h,color: Colors.white),
          SizedBox(width: 6.w),
          Text(
            "Player 1",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp
            ),
          )
        ],
      ),
    );
  }
}
