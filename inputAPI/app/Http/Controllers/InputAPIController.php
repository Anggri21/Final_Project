<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Input;
class InputAPIController extends Controller
{
    //Method menampilkan isi database di API
    public function index()
    {
        //ambil isi database terlebih dahulu
        //jngan lupa import class diatas
        $inputs = Input::all();
        //karena kita menggunakan json maka menggunakan response dan yang di isi ini namanya endpoint
        // yang nanti akan digunakan sama orang
        return response()->json(['message' => 'Sukses', 'data' => $inputs]);
    }
    //Method menampilkan isi database dari ID data yang ingin dibuka
    public function show($id)
    {
        $input = Input::find($id);
        return response()->json(['message' => 'Sukses', 'data' => $input]);
    }

    //untuk formnya dibuat di postman dengan method POST nanti ditambahkan di body isi dari data API kita seperti nama, deskripsi,dll
    //setelah itu baru ke method Simpan ini, abis buat formnya diaplikasi nanti akan disimpan ke database dan muncul pesan sucess di postman
    public function simpan(Request $request)
    {
        $input = Input::create($request->all());
        return  response()->json(['message' => 'Berhasil disimpan', 'data' => $input]);
    }

    //method edit di API
    // method update perlu parameter id agar data yang di edit jelas di ID mana di edit 
    public function update(Request $request, $id)
    {
        $input = Input::find($id);
        $input->update($request->all());
        return response()->json(['message' => 'Berhasil diupdate', 'data' => $input]);
    }

    //method Delete di APi
    public function destroy($id)
    {
        $input = Input::find($id);
        $input->delete();
        return response()->json(['message' => 'Berhasil didelete', 'data' => null]);
    }
}
