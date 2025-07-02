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

  static void clear() {
    _gallery.clear();
  }
}
