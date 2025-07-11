import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants.dart';

class SelectShapeScreen extends StatelessWidget {
  final Function(String shape) onShapeSelected;

  const SelectShapeScreen({super.key, required this.onShapeSelected});

  final List<Map<String, dynamic>> shapes = const [
    {"name": "Rectangle", "icon": Icons.crop_16_9},
    {"name": "Square", "icon": Icons.crop_square},
    {"name": "Zigzag", "icon": Icons.waves},
    {"name": "Circle", "icon": Icons.circle_outlined},
    {"name": "Triangle", "icon": Icons.change_history},
    {"name": "Cross", "icon": Icons.close},
  ];

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
              padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child:  Row(
                      children: [
                        Icon(Icons.arrow_back_ios_rounded, size: 18.sp, color: kPrimaryColor),
                        SizedBox(width: 1.w),
                        Text(
                          "BACK",
                          style: kBackButtonTextStyle
                        ),
                      ],
                    ),
                  ),
                   SizedBox(height: 20.h),

                   Center(
                    child: Text(
                      "SELECT A SHAPE",
                      style: kSelectShapeTextStyle
                    ),
                  ),

                   SizedBox(height: 20.h),

                  // Shape Grid
                  Expanded(
                    child: GridView.builder(
                      itemCount: shapes.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                      ),
                      itemBuilder: (context, index) {
                        final shape = shapes[index];
                        return GestureDetector(
                          onTap: () {
                            onShapeSelected(shape['name']);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Icon(
                                shape['icon'],
                                size: 48.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                   SizedBox(height: 20.h),

                  Center(
                    child: TextButton(
                      onPressed: () {
                        onShapeSelected("Unknown");
                      },
                      child:  Text(
                        "Play without selecting shapes",
                        style: kPlayWSShapeTextStyle
                      ),
                    ),
                  ),
                   SizedBox(height: 16.h),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        final randomShape = shapes[DateTime.now().second % shapes.length];
                        onShapeSelected(randomShape['name']);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize:  Size(double.infinity, 20.h),
                        backgroundColor: kPrimaryColor,
                        padding:  EdgeInsets.symmetric(horizontal: 40.w, vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                      ),
                      child:  Text(
                        "Select random shape",
                        style: kSelectRandomShapeTextStyle
                      ),
                    ),
                  ),

                   SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
