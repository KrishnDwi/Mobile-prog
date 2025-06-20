<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Product; // <-- Import model Product

class ProductSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Hapus data produk yang ada sebelumnya untuk menghindari duplikat
        Product::query()->delete();

        // Daftar makanan untuk dimasukkan ke database
        $products = [
            ['name' => 'Nasi Goreng', 'price' => 25000],
            ['name' => 'Mie Goreng', 'price' => 22000],
            ['name' => 'Sate Ayam', 'price' => 30000],
            ['name' => 'Soto Ayam', 'price' => 20000],
            ['name' => 'Rendang', 'price' => 35000],
            ['name' => 'Gado-gado', 'price' => 18000],
            ['name' => 'Bakso', 'price' => 15000],
            ['name' => 'Nasi Padang', 'price' => 28000],
            ['name' => 'Ikan Bakar', 'price' => 45000],
            ['name' => 'Ayam Penyet', 'price' => 26000],
        ];

        // Looping untuk memasukkan setiap produk ke database
        foreach ($products as $product) {
            Product::create($product);
        }
    }
}