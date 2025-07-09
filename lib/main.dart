import 'package:flutter/material.dart';
import 'package:geometryhunter/controller/music_controller.dart';
import 'package:geometryhunter/controller/onevsonecontroller.dart';
import 'package:geometryhunter/screens/splash_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(MusicController());
  Get.put(OneVsOneController());
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(412, 915),
        minTextAdapt: true,
        splitScreenMode: true,
    builder: (_ , child) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'GeometryHunter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashScreen(),
    );
  }
    );
  }
}
