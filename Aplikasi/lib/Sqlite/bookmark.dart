class Bookmark {
  int id;
  String nama;
  String description;

  bookmarkMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['nama'] = nama;
    mapping['description'] = description;
    return mapping;
  }
}
