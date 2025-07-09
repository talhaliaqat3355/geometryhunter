import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:geometryhunter/constants.dart';

class PhotoPreviewScreen extends StatelessWidget {
  final File imageFile;
  final String shapeName;
  final VoidCallback onUsePhoto;

  const PhotoPreviewScreen({
    Key? key,
    required this.imageFile,
    required this.shapeName,
    required this.onUsePhoto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Image.file(imageFile, fit: BoxFit.cover)),

          // UI Overlay
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Get.back(),
                        child: Row(
                          children: [
                            Icon(Icons.arrow_back_ios_rounded, size: 18.sp, color: kTextColor),
                            SizedBox(width: 2.w),
                            Text(
                              "BACK",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                                color: kTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "YOUR SHAPE: $shapeName",
                        style: TextStyle(
                          color: kSecondaryColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: onUsePhoto,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kSecondaryColor,
                          minimumSize: Size(double.infinity, 70.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                        child: Text(
                          "Use this photo",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      ElevatedButton(
                        onPressed: () => Get.back(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          minimumSize: Size(double.infinity, 70.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                        child: Text(
                          "Take a new one",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}


