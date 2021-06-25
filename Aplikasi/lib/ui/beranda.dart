import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class Beranda extends StatefulWidget {
  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  final String url = "http://192.168.1.3/api/inputs";

  Future getData() async {
    var response = await http.get(Uri.parse(url));
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Material(
              elevation: 2,
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                  hintText: "Cari Produk",
                  suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: () {}),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          iklan(),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 320,
            child: FutureBuilder(
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
          ),
        ],
      ),
    );
  }

  Container iklan() {
    return Container(
      height: 200.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          Image.network(
              "https://2.bp.blogspot.com/-RlZkQQ-ydVQ/XUo3BO6dCXI/AAAAAAAAD2k/JAAPUd6ggOY0Gb4ZSKfZGlNgvTCpdQCLQCLcBGAs/s1600/contoh-iklan-baju-dalam-bahasa-inggris.jpg"),
          Image.network("https://mahatekno.com/wp-content/uploads/2020/09/contoh-iklan-baju.jpg"),
          Image.network(
              "https://i0.wp.com/lh3.googleusercontent.com/-ng2TE5r1EUM/V8A1xLrC8aI/AAAAAAAAAZI/HkdiGVznvX4fiQ6bsHqjWJj_pBMpOG8-gCLcB/s1600/iklan%2Bbaju%25282%2529.jpg?resize=650,400"),
          Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_o6kvRsfrmvY9ZjlmCjhldPzgdVuz79bljie_OYUoKpqeflUcglY7iGLERmjHjE1BPsg&usqp=CAU"),
        ],
        autoplay: false,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        indicatorBgPadding: 4.0,
      ),
    );
  }
}
