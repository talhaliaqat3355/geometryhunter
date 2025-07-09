import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// colors
const kPrimaryColor = Color(0xFF0A2B27);
const kSecondaryColor = Color(0xFF0FAF5F);
const kPlayerColor = Color(0xFF2874E6);
const kDrawTextColor = Color(0xFF5B5B5B);
const kTextColor = Color(0xFF000000);
const kPGContentTextColor = Color(0xFF141414);
// TextStyles
final kGalleryTextStyle = TextStyle(
  fontSize: 18.sp,
  color: Colors.white,
  fontWeight: FontWeight.w600,
);
final kStartNewGameTextStyle =TextStyle(
  fontSize: 18.sp,
  color: Colors.white,
  fontWeight: FontWeight.w600,
);
final kBackButtonTextStyle =  TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18.sp,
  color: kPrimaryColor,
);
final kSelectModTextStyle = TextStyle(
  fontSize: 24.sp,
  fontWeight: FontWeight.bold,
  letterSpacing: 1,
);
final kBuildGameModTitleTextStyle =TextStyle(
  fontSize: 26.sp,
  color: kPrimaryColor,
  fontWeight: FontWeight.bold,
);
final kTicTacToeTextStyle =TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  letterSpacing: 1.w,
  color: kPrimaryColor,
);
final kEndGameButtonTextStyle =  TextStyle(
  color: Colors.white,
  fontSize: 20.sp,
);
final k1vs1TextStyle = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: kPrimaryColor
);
final kInfiniteModTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 24.sp,
  color: kPrimaryColor,
);
final kPhotoCountTextStyle=TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.bold,
    color: kPrimaryColor
);
final kYoursMoveTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 20.sp,
  color: kPlayerColor,
);
final kPlayer1TextStyle =TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 18.sp,
);