<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\InputController;
/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/inputs', [InputController::class, 'index']);

//route untuk create data 
Route::get('/inputs/create', [InputController::class, 'create']);
//route menyimpan data
Route::post('/inputs', [InputController::class, 'simpan']);

//route untuk edit jadi pertama kita dapatkan dulu data dari primary keynya yaitu ID 
Route::get('/inputs/{id}/edit', [InputController::class, 'edit']);
// pakek method put karena pakek update/edit data
Route::put('/inputs/{id}', [InputController::class, 'update']);

//route delete data dari id data yang ingin di delete data
Route::delete('/inputs/{id}', [Inputcontroller::class, 'destroy']);
