class GalleryStore {
  static final List<Map<String, dynamic>> _gallery = [];

  static void addImage(String path, {String shape = "All", int player = 1}) {
    _gallery.add({
      "path": path,
      "shape": shape,
      "player": player,
    });
  }

  // return all tagged images
  static List<Map<String, dynamic>> getTaggedImages() {
    return _gallery;
  }
// return all shapes except 'All'
  static List<String> getAllShapes() {
    return _gallery
        .map((img) => img['shape'] as String?)
        .whereType<String>() // remove nulls
        .where((shape)=> shape.trim().toLowerCase() != "all")
        .toSet()
        .toList();
  }
  // images by specific player
  static List<Map<String, dynamic>> getImagesByPlayer(int player) {
    return _gallery.where((img) => img['player'] == player).toList();
  }

  static int getPlayerImageCount(int player) {
    return _gallery.where((img) => img['player'] == player).length;
  }

  static void clear() {
    _gallery.clear();
  }
}


