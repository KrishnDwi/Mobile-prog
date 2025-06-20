<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // 1. Hapus data user lama dan buat user baru untuk login
        User::query()->delete();
        User::factory()->create([
             'name' => 'bagus',
             'username' => 'bagus',
             'email' => 'bagus@example.com',
             'password' => 'admin123', // passwordnya adalah 'password'
        ]);

        // 2. Panggil ProductSeeder untuk mengisi data makanan
        $this->call([
            ProductSeeder::class,
        ]);
    }
}