<?php
namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        User::factory()->create([
             'name' => 'Test User',
             'username' => 'testuser', // username untuk login
             'email' => 'test@example.com',
             'password' => 'password', // password untuk login
        ]);
    }
}