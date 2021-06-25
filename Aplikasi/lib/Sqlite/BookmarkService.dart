import 'package:aa/Sqlite/repository.dart';

import 'bookmark.dart';

class BookmarkService {
  Repository _repository;

  BookmarkService() {
    _repository = Repository();
  }
  //creating data
  // ignore: non_constant_identifier_names
  Savebookmark(Bookmark bookmark) async {
    return await _repository.inserData('bookmark', bookmark.bookmarkMap());
  }

  //read data from table
  readBookmark() async {
    return await _repository.readData('bookmark');
  }

  //read data dari id yaitu sebagai primary key
  readBookmarkById(bookmarkId) async {
    return await _repository.readDataById('bookmark', bookmarkId);
  }

  //update data
  updateBookmark(Bookmark bookmark) async {
    return await _repository.updateBookmark('bookmark', bookmark.bookmarkMap());
  }

  //delete data
  deleteBookmark(bookmarkId) async {
    return await _repository.deleteBookmark('bookmark', bookmarkId);
  }
}
