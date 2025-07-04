class GalleryStore {
  static final List<Map<String, dynamic>> _gallery = [];

  static void addImage(String path, {String shape = "All"}) {
    _gallery.add({
      "path": path,
      "shape": shape,
    });
  }

  static List<Map<String, dynamic>> getTaggedImages() {
    return _gallery;
  }

  static List<String> getAllShapes() {
    return _gallery
        .map((img) => img['shape'] as String?)
        .whereType<String>() // filters out nulls and ensures non-null String
        .where((shape) => shape != "All")
        .toSet()
        .toList();
  }


  static void clear() {
    _gallery.clear();
  }
}

