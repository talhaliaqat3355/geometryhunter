import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import '../gallery_store.dart';
import '../screens/photo-preview_screen.dart';

class OneVsOneController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  var currentPlayer = 1.obs;
  var secondsLeft = 60.obs;
  Timer? _timer;

  String? player1ImagePath;
  String? player2ImagePath;

  void startTimer(Function onTimeEnd) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft.value == 0) {
        timer.cancel();
        onTimeEnd();
      } else {
        secondsLeft.value--;
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }
  Future<void> takeTurn(Function(String imagePath) onCaptured, String shape) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);

      Get.to(() => PhotoPreviewScreen(
        imageFile: imageFile,
        shapeName: shape,
        onUsePhoto: () async {
          // Save the image permanently
          final appDir = await getApplicationDocumentsDirectory();
          final fileName = 'img_${DateTime.now().millisecondsSinceEpoch}.jpg';
          final savedPath = path.join(appDir.path, fileName);
          final File savedFile = await imageFile.copy(savedPath);

          // Add to gallery and update player path
          GalleryStore.addImage(
            savedFile.path,
            shape: shape,
            player: currentPlayer.value,
          );

          if (currentPlayer.value == 1) {
            player1ImagePath = savedFile.path;
          } else {
            player2ImagePath = savedFile.path;
          }

          // Notify callback and switch player
          onCaptured(savedFile.path);
          currentPlayer.value = currentPlayer.value == 1 ? 2 : 1;

          Get.back(); // Close preview screen
        },
      ));
    }
  }


  int getPlayerImageCount(int playerNumber) {
    return GalleryStore.getTaggedImages()
        .where((img) => img['player'] == playerNumber)
        .length;
  }

  void resetGame() {
    stopTimer();
    player1ImagePath = null;
    player2ImagePath = null;
    currentPlayer.value = 1;
    secondsLeft.value = 60;
    GalleryStore.clear();
  }
}
