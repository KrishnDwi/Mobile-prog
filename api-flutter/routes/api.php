<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\ProductController;

Route::apiResource('products', ProductController::class);
Route::get('/products', function () {
    return \App\Models\Product::all();
});
