import 'package:flutter/material.dart';

import 'BookmarkService.dart';
import 'bookmark.dart';

class BookmarkScreen extends StatefulWidget {
  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  var _bookmark = Bookmark();
  var bookmark;
  var _bookmarkservice = BookmarkService();
  var _editBookmarkNameController = TextEditingController();
  var _editBookmarkDescriptionController = TextEditingController();

  // ignore: deprecated_member_use
  List<Bookmark> _bookmarkList = List<Bookmark>();
  @override
  void initState() {
    super.initState();
    getAllBookmark();
  }

  getAllBookmark() async {
    // ignore: deprecated_member_use
    _bookmarkList = List<Bookmark>();
    var bookmarks = await _bookmarkservice.readBookmark();
    bookmarks.forEach((bookmark) {
      setState(() {
        var bookmarkModel = Bookmark();
        bookmarkModel.nama = bookmark['nama'];
        bookmarkModel.description = bookmark['description'];
        bookmarkModel.id = bookmark['id'];
        _bookmarkList.add(bookmarkModel);
      });
    });
  }

  // ignore: non_constant_identifier_names
  editBookmark(BuildContext, bookmarkId) async {
    bookmark = await _bookmarkservice.readBookmarkById(bookmarkId);
    setState(() {
      _editBookmarkNameController.text = bookmark[0]['nama'] ?? 'Tidak ada nama';
      _editBookmarkDescriptionController.text =
          bookmark[0]['description'] ?? 'Tidak ada description';
    });
    editdialog(context);
  }

  editdialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            actions: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                    color: Colors.red,
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        ))),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                    color: Colors.blue,
                    child: TextButton(
                        onPressed: () async {
                          _bookmark.id = bookmark[0]['id'];
                          _bookmark.nama = _editBookmarkNameController.text;
                          _bookmark.description = _editBookmarkDescriptionController.text;

                          var result = await _bookmarkservice.updateBookmark(_bookmark);
                          if (result > 0) {
                            Navigator.pop(context);
                            getAllBookmark();
                          }
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ))),
              ),
            ],
            title: Text('Edit Bookmark'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _editBookmarkNameController,
                    decoration: InputDecoration(hintText: "Name of Bookmark", labelText: "Name"),
                  ),
                  TextField(
                    controller: _editBookmarkDescriptionController,
                    decoration: InputDecoration(hintText: 'Anything', labelText: 'Description'),
                  )
                ],
              ),
            ),
          );
        });
  }

  deletedialog(BuildContext context, bookmarkId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            actions: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                    color: Colors.blue,
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        ))),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                    color: Colors.red,
                    child: TextButton(
                        onPressed: () async {
                          var result = await _bookmarkservice.deleteBookmark(bookmarkId);
                          if (result > 0) {
                            Navigator.pop(context);
                            getAllBookmark();
                          }
                        },
                        child: Text(
                          'Delete',
                          style: TextStyle(color: Colors.white),
                        ))),
              ),
            ],
            title: Text('Are you sure to delete this ?'),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookmark"),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          formdialog(context);
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: _bookmarkList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                child: ListTile(
                    leading: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          editBookmark(BuildContext, _bookmarkList[index].id);
                        }),
                    title: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(_bookmarkList[index].nama),
                          IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                deletedialog(context, _bookmarkList[index].id);
                              })
                        ],
                      ),
                    ),
                    subtitle: Text(_bookmarkList[index].description)),
              ),
            );
          }),
    );
  }
}

formdialog(BuildContext context) {
  var bookmarkNameController = TextEditingController();
  var bookmarkDescriptionController = TextEditingController();
  var _bookmark = Bookmark();
  var _bookmarkservice = BookmarkService();
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          actions: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                  color: Colors.red,
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ))),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                  color: Colors.blue,
                  child: TextButton(
                      onPressed: () async {
                        _bookmark.nama = bookmarkNameController.text;
                        _bookmark.description = bookmarkDescriptionController.text;
                        _bookmarkservice.Savebookmark(_bookmark);

                        Navigator.pop(context);
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ))),
            ),
          ],
          title: Text('Bookmark'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: bookmarkNameController,
                  decoration: InputDecoration(hintText: "Name of Bookmark", labelText: "Name"),
                ),
                TextField(
                  controller: bookmarkDescriptionController,
                  decoration: InputDecoration(hintText: 'Anything', labelText: 'Description'),
                )
              ],
            ),
          ),
        );
      });
}
