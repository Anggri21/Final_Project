import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class FormInput extends StatefulWidget {
  @override
  _FormInputState createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController namaController = TextEditingController();
  TextEditingController warnaController = TextEditingController();
  TextEditingController ukuranController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController gambarController = TextEditingController();
  //membuat method POST untuk Upload data ke API
  Future saveUpload() async {
    // karena ingin menambahkan data/POST maka perlu tambahan body karena di body API kita akan menambahkan data object yang ditulis harus sama dengan yang ada di API
    final response = await http.post(Uri.parse("http://192.168.1.3:80/api/inputs"), body: {
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
        title: Text("Input Data Baju"),
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
                  controller: namaController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Nama Baju",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: TextField(
                  controller: warnaController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Warna Baju",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: TextField(
                  controller: ukuranController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Ukuran Baju",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: TextField(
                  controller: hargaController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Harga baju",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: TextField(
                  controller: gambarController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Link gambar",
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
                          'Save',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          if (_formkey.currentState.validate()) {
                            saveUpload().then((value) {
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
                          'Cancel',
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
