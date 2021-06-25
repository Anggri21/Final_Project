import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditData extends StatelessWidget {
  final Map input;
  EditData({@required this.input});
  final _formkey = GlobalKey<FormState>();
  TextEditingController namaController = TextEditingController();
  TextEditingController warnaController = TextEditingController();
  TextEditingController ukuranController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController gambarController = TextEditingController();
  //membuat method POST untuk Upload data ke API
  Future updateKonten() async {
    // karena ingin mengedit data maka menggunakan method PUT maka perlu tambahan body karena di body API kita akan menambahkan data object yang sudah ditulis harus sama dengan yang ada di API
    // dan tambahan pada url yaitu upload ["id"] fungsinya untuk mengetahui id data ke berapa yang diedit pada API
    final response = await http
        .put(Uri.parse("http://192.168.1.2:80/api/inputs/" + input['id'].toString()), body: {
      "nama_baju": namaController.text,
      "warna_baju": warnaController.text,
      "ukuran_baju": ukuranController.text,
      "harga_baju": hargaController.text,
      "gambar": gambarController.text,
    });
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit data "),
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: EdgeInsets.only(top: 15, left: 10, right: 10),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: TextField(
                  controller: namaController..text = input['nama_baju'],
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Nama Baju",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: TextField(
                  controller: warnaController..text = input['warna_baju'],
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Warna",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: TextField(
                  controller: ukuranController..text = input['ukuran_baju'],
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Ukuran",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: TextField(
                  controller: hargaController..text = input['harga_baju'],
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Harga Baju",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: TextField(
                  controller: gambarController..text = input['gambar'],
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Gambar",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    // tombol simpan
                    Expanded(
                      child: RaisedButton(
                        color: Colors.green,
                        textColor: Colors.white,
                        child: Text(
                          'Update',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          if (_formkey.currentState.validate()) {
                            updateKonten().then((value) {
                              Navigator.pop(context);
                            });
                          }
                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    // tombol batal
                    Expanded(
                      child: RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Text(
                          'Batal',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
