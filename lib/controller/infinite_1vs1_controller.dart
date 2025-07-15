import 'package:get/get.dart';

class Infinite1v1Controller extends GetxController {
  var currentPlayer = 1.obs;
  RxMap<int, String> playerShapes = <int, String>{1: '', 2: ''}.obs;

  void setShapeForPlayer(int player, String shape) {
    playerShapes[player] = shape;
  }

  String getShape(int player) => playerShapes[player] ?? '';

  void switchTurn() {
    currentPlayer.value = currentPlayer.value == 1 ? 2 : 1;
  }
}
