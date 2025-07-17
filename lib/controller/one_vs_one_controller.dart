import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import '../gallery_store.dart';
import '../screens/photo_preview_screen.dart';
import 'package:GH0406/screens/select_shape_screen.dart';
import 'package:flutter/foundation.dart';

class OneVsOneController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  var currentPlayer = 1.obs;
  var secondsLeft = 60.obs;
  var timerStarted = false.obs;
  Timer? _timer;

  int playersFinished = 0;

  RxMap<int, List<String>> playerImages = <int, List<String>>{
    1: <String>[],
    2: <String>[],
  }.obs;

  RxString selectedShapePlayer1 = ''.obs;
  RxString selectedShapePlayer2 = ''.obs;

  Set<int> shapeSelectedForPlayers = {};

  final RxMap<int, int> remainingTime = <int, int>{1: 60, 2: 60}.obs;

  void startPlayerTimer(int player, VoidCallback onPlayerTimeEnd, {bool reset = false}) {
    currentPlayer.value = player;
    _timer?.cancel();

    // If reset required
    if (reset || remainingTime[player] == null) {
      remainingTime[player] = 60;
    }

    secondsLeft.value = remainingTime[player]!;
    timerStarted.value = true;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft.value <= 0) {
        timer.cancel();
        timerStarted.value = false;
        remainingTime[player] = 0;
        playersFinished++;
        onPlayerTimeEnd();
      } else {
        secondsLeft.value--;
        remainingTime[player] = secondsLeft.value;
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    timerStarted.value = false;
  }

  void switchToNextPlayer(VoidCallback onFinalGameEnd) {
    if (playersFinished == 1) {
      int nextPlayer = currentPlayer.value == 1 ? 2 : 1;
      startPlayerTimer(nextPlayer, () {
        playersFinished++;
        onFinalGameEnd();
      }, reset: true);
    } else {
      onFinalGameEnd();
    }
  }

  Future<void> captureImage(int player, VoidCallback onTimeEnd) async {
    stopTimer(); // stop immediately when camera opens

    if (!_isShapeSelected(player)) {
      shapeSelectedForPlayers.add(player);
      Get.to(() => SelectShapeScreen(
        onShapeSelected: (shape) async {
          _saveShape(player, shape);
          Get.back();
          await _openCameraAndSave(player, shape, onTimeEnd);
        },
      ));
    } else {
      String shape = getPlayerShape(player)!;
      await _openCameraAndSave(player, shape, onTimeEnd);
    }
  }

  Future<void> _openCameraAndSave(
      int player,
      String shape,
      VoidCallback onTimeEnd,
      ) async {
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
          final savedFile = await imageFile.copy(savedPath);

          GalleryStore.addImage(savedFile.path, shape: shape, player: player);
          playerImages[player]!.add(savedFile.path);
          playerImages.refresh();

          Get.back(); // close preview
          startPlayerTimer(player, onTimeEnd); // resume timer
        },
      ));
    } else {
      // resume if camera cancelled
      startPlayerTimer(player, onTimeEnd);
    }
  }

  bool _isShapeSelected(int player) {
    return player == 1
        ? selectedShapePlayer1.value.isNotEmpty
        : selectedShapePlayer2.value.isNotEmpty;
  }

  void _saveShape(int player, String shape) {
    if (player == 1) {
      selectedShapePlayer1.value = shape;
    } else {
      selectedShapePlayer2.value = shape;
    }
  }

  String? getPlayerShape(int player) {
    return player == 1
        ? selectedShapePlayer1.value
        : selectedShapePlayer2.value;
  }

  int getPlayerImageCount(int player) {
    return playerImages[player]?.length ?? 0;
  }

  void resetGame() {
    stopTimer();
    currentPlayer.value = 1;
    secondsLeft.value = 60;
    timerStarted.value = false;
    playersFinished = 0;

    playerImages[1] = [];
    playerImages[2] = [];
    playerImages.refresh();

    selectedShapePlayer1.value = '';
    selectedShapePlayer2.value = '';
    shapeSelectedForPlayers.clear();

    remainingTime[1] = 60;
    remainingTime[2] = 60;

    // GalleryStore.clear(); // Keep as-is if not needed
  }
}







