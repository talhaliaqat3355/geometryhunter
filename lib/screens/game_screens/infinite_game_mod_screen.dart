import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../constants.dart';
import '../../gallery_store.dart';
import '../../screens/photo-preview_screen.dart';
import '../../screens/select-shape_screen.dart';
import '../../screens/game-over&draw_screens/game-over-infinite_screen.dart';
import '../../controller/infinite_1vs1_controller.dart';

class InfiniteModScreen extends StatefulWidget {
  const InfiniteModScreen({super.key});

  @override
  State<InfiniteModScreen> createState() => _InfiniteModScreenState();
}

class _InfiniteModScreenState extends State<InfiniteModScreen> {
  final ImagePicker _picker = ImagePicker();
  final Infinite1v1Controller controller = Get.put(Infinite1v1Controller());

  List<File> _images = [];

  Future<void> _captureForPlayer(int player) async {
    final shape = controller.getShape(player);
    if (shape.isEmpty) {
      // Open shape selector
      Get.to(() => SelectShapeScreen(onShapeSelected: (selectedShape) async {
        controller.setShapeForPlayer(player, selectedShape);
        Get.back();
        await _openCameraFlow(player, selectedShape);
      }));
    } else {
      await _openCameraFlow(player, shape);
    }
  }

  Future<void> _openCameraFlow(int player, String shape) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile == null) return;

    final imageFile = File(pickedFile.path);

    Get.to(() => PhotoPreviewScreen(
      imageFile: imageFile,
      shapeName: shape,
      onUsePhoto: () async {
        final appDir = await getApplicationDocumentsDirectory();
        final fileName = 'img_${DateTime.now().millisecondsSinceEpoch}.jpg';
        final savedPath = path.join(appDir.path, fileName);
        final savedImage = await imageFile.copy(savedPath);

        GalleryStore.addImage(savedImage.path, shape: shape);
        setState(() {
          _images.add(savedImage);
        });

        Get.back();
        controller.switchTurn();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset('assets/images/bg.png', fit: BoxFit.cover)),
          SafeArea(
            child: Column(
              children: [
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
                            Text("INFINITE MOD", style: kInfiniteModTextStyle),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Divider(color: kPrimaryColor),
                        SizedBox(height: 20.h),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _playerTag(player: 1),
                            Obx(() {
                              final shape = controller.getShape(controller.currentPlayer.value);
                              return shape.isNotEmpty
                                  ? Image.asset('assets/images/${shape}_icon.png', height: 36.h)
                                  : SizedBox.shrink();
                            }),
                            _playerTag(player: 2),
                          ],
                        ),
                        SizedBox(height: 20.h),

                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _images.length + 1,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                          ),
                          itemBuilder: (context, index) {
                            if (index == _images.length) {
                              final player = controller.currentPlayer.value;
                              return GestureDetector(
                                onTap: () => _captureForPlayer(player),
                                child: Image.asset('assets/images/camera_placeholder.png', height: 120),
                              );
                            } else {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child: Image.file(_images[index], fit: BoxFit.cover),
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
                    ),
                    child: Text("End game", style: kEndGameButtonTextStyle),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _playerTag({required int player}) {
    return Obx(() {
      final isActive = controller.currentPlayer.value == player;
      final isPlayer1 = player == 1;

      return Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: isActive
                  ? (isPlayer1 ? Colors.blue.shade600 : Colors.red.shade600)
                  : Colors.transparent,
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
                  "Player $player",
                  style: TextStyle(
                    color: isActive ? Colors.white : (isPlayer1 ? Colors.blue : Colors.red),
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ),
          if (isActive)
            Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Text(
                "Your move!",
                style: TextStyle(
                  color: isPlayer1 ? Colors.blue.shade600 : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            )
        ],
      );
    });
  }

}


