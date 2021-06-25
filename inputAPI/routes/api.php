<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\InputAPIController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

// CRUD
// /uploads itu digunakan pas di website 127.0.0.1/upload nah setelah itu pakek controller dan arahkan ke blade yang kita buat yaitu Index ada pada upload controller
// jangan lupa import kelas uploadcontroller diatas supaya pada route dikenali kelas upload controller

Route::get('/inputs', [InputAPIController::class, 'index']);
//route untuk bisa melihat lebih spesifik pada 1 data
Route::get('/inputs/{id}', [InputAPIController::class, 'show']);

//di api gak perlu create karena form yang digunakan nanti diaplikasi
//route menyimpan data
Route::post('/inputs', [InputAPIController::class, 'simpan']);

//untuk form edit tidak dibuatkan route karena nanti dari aplikasinya
// pakek method put karena pakek update/edit data
Route::put('/inputs/{id}', [InputAPIController::class, 'update']);

//route delete data dari id data yang ingin di delete data
Route::delete('/inputs/{id}', [InputAPIcontroller::class, 'destroy']);
