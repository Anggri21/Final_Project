import 'dart:convert';

import 'package:aa/API/formInput.dart';
import 'package:aa/API/editData.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Produk extends StatefulWidget {
  @override
  _ProdukState createState() => _ProdukState();
}

class _ProdukState extends State<Produk> {
  @override
  Widget build(BuildContext context) {
    final String url = "http://192.168.1.3/api/inputs";

    Future getData() async {
      var response = await http.get(Uri.parse(url));
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    }

    @override
    // ignore: unused_element
    void initState() {
      super.initState();
      getData();
    }

    Future deleteData(String dataId) async {
      final String url = "http://192.168.1.3/api/inputs/" + dataId;
      var response = await http.delete(Uri.parse(url));
      setState(() {
        jsonDecode(response.body);
      });
      return jsonDecode(response.body);
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => FormInput()));
        },
        child: Icon(Icons.add),
      ),
      // ignore: missing_return
      body: FutureBuilder(
        future: getData(),
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: snapshot.data['data'].length,
                // ignore: missing_return
                itemBuilder: (context, index) {
                  return Container(
                    child: Card(
                      elevation: 4,
                      child: Row(
                        children: [
                          Container(
                            child: InkWell(
                              onTap: () {},
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  snapshot.data['data'][index]['gambar'],
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(20),
                            child: Expanded(
                                child: Container(
                              margin: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data['data'][index]['nama_baju'],
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold, fontSize: 15),
                                  ),
                                  Text(
                                    "Ukuran : " + snapshot.data['data'][index]['ukuran_baju'],
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400, fontSize: 15),
                                  ),
                                  Text(
                                    "Rp. " + snapshot.data['data'][index]['harga_baju'],
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400, fontSize: 15),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => EditData(
                                                        input: snapshot.data['data'][index])));
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.blue,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            deleteData(
                                                    snapshot.data['data'][index]['id'].toString())
                                                .then((value) {
                                              setState(() {});
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                  content: Text("Data sudah berhasil di hapus")));
                                            });
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            )),
                          )
                        ],
                      ),
                    ),
                  );
                });
          } else {
            Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
