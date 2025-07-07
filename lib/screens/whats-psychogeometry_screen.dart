import 'package:flutter/material.dart';
import 'package:geometryhunter/constants.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WhatsPsychogeometryScreen extends StatefulWidget {
  const WhatsPsychogeometryScreen({super.key});

  @override
  State<WhatsPsychogeometryScreen> createState() =>
      _WhatsPsychogeometryScreenState();
}

class _WhatsPsychogeometryScreenState extends State<WhatsPsychogeometryScreen> {
  // Expansion states
  bool _psychogeometryExpanded = false;
  bool _coreIdeaExpanded = false;
  bool _howToIdentifyExpanded = false;
  bool _importantNoteExpanded = false;

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
              padding:  EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   SizedBox(height: 20.h),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child:  Row(
                      children: [
                        Icon(Icons.arrow_back_ios_rounded,
                            size: 18.sp, color: kPrimaryColor),
                        SizedBox(width: 1.w),
                        Text(
                          "BACK",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                   SizedBox(height: 20.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/guide_icon.png'),
                      SizedBox(width: 10.w),
                      Expanded( // ensures the Text wraps within available space
                        child: Text(
                          "WHAT IS PSYCHOGEOMETRY?",
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.sp, // slightly reduced to avoid overflow
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.w,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Divider(
                    color: kPrimaryColor,
                  ),
                   SizedBox(height: 30.h),

                  // Expansion Tiles with Dividers
                  Expanded(
                    child: ListView(
                      children: [
                        // Psychogeometry Section
                        _buildSection(
                          title: 'Psychogeometry',
                          expanded: _psychogeometryExpanded,
                          content: 'Psychogeometry is a personality assessment framework that categorizes individuals into distinct geometric types. These types represent fundamental patterns in cognition, emotion, and behavior, offering insights into personal and interpersonal dynamics.',
                          onTap: () {
                            setState(() {
                              _psychogeometryExpanded = !_psychogeometryExpanded;
                            });
                          },
                        ),
                         SizedBox(height: 10.h),

                        // Core Idea Section
                        _buildSection(
                          title: 'Core Idea',
                          expanded: _coreIdeaExpanded,
                          content: 'Psychogeometry is based on five personality types, each represented by a person\'s geometric shape:\n\n'
                              '• Space\n• Circle\n• Trough\n• Zigzag\n\n'
                              'Each study reflects unique psychological capabilities and interests with the others in different ways. It is important to note that psychogeometry itself attends classification systems, not if it is designed for deeper personality assessment tools used in psychology.',
                          onTap: () {
                            setState(() {
                              _coreIdeaExpanded = !_coreIdeaExpanded;
                            });
                          },
                        ),
                         SizedBox(height: 10.h),

                        // How to Identify Section
                        _buildSection(
                          title: 'How to Identify Your Type',
                          expanded: _howToIdentifyExpanded,
                          content: 'Identifying your primary psychogeometric type involves self-reflection, observation, and sometimes feedback from others. Consider your natural inclinations in various situations and which geometric description resonates most strongly with your core personality patterns.',
                          onTap: () {
                            setState(() {
                              _howToIdentifyExpanded = !_howToIdentifyExpanded;
                            });
                          },
                        ),
                         SizedBox(height: 10.h),

                        // Important Note Section
                        _buildSection(
                          title: 'Important Note',
                          expanded: _importantNoteExpanded,
                          content: 'Psychogeometry offers a framework for understanding, not a definitive psychological diagnosis. Personality is complex and dynamic, and individuals often exhibit traits from multiple geometric types.',
                          onTap: () {
                            setState(() {
                              _importantNoteExpanded = !_importantNoteExpanded;
                            });
                          },
                        ),
                         SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required bool expanded,
    required String content,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding:  EdgeInsets.symmetric(vertical: 16.h),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: kPrimaryColor.withOpacity(0.3),
                  width: 2.w,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style:  TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                AnimatedRotation(
                  turns: expanded ? 1.25 : 1,
                  duration: const Duration(milliseconds: 300),
                  child:  Icon(
                    Icons.arrow_forward_ios,
                    size: 20.sp,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (expanded)
          Padding(
            padding:  EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
            child: Text(
              content,
              style:  TextStyle(
                fontSize: 22.sp,
                height: 1.5.h,
              ),
            ),
          ),
      ],
    );
  }
}