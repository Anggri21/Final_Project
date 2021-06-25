import 'package:aa/Sqlite/bookmark_screen.dart';
import 'package:aa/ui/produk.dart';
import 'package:flutter/material.dart';

import 'beranda.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController controller;
  @override
  void initState() {
    controller = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Anggri Shop"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => BookmarkScreen()));
                  },
                  icon: Icon(Icons.bookmark_add_outlined)),
            )
          ],
        ),
        body: TabBarView(
          controller: controller,
          children: <Widget>[Beranda(), Produk()],
        ),
        bottomNavigationBar: new Material(
          color: Colors.blue,
          child: new TabBar(controller: controller, tabs: <Widget>[
            new Tab(icon: new Icon(Icons.home)),
            new Tab(icon: new Icon(Icons.list_rounded)),
          ]),
        ));
  }
}
