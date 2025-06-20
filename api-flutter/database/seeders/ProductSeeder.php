<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Product;

class ProductSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Hapus data lama untuk menghindari duplikasi
        Product::query()->delete();

        // Daftar 25 produk makanan dengan deskripsi yang lebih panjang
        $products = [
            ['name' => 'Nasi Goreng Spesial', 'price' => 28000, 'description' => 'Nasi goreng klasik yang dimasak dengan bumbu rahasia, dilengkapi dengan potongan ayam, udang segar, telur mata sapi, dan taburan bawang goreng.'],
            ['name' => 'Mie Goreng Seafood', 'price' => 27000, 'description' => 'Mie telur kenyal yang digoreng dengan aneka hidangan laut seperti cumi, udang, dan bakso ikan, disajikan dengan sayuran segar dan acar.'],
            ['name' => 'Sate Ayam Madura', 'price' => 30000, 'description' => '10 tusuk sate dari daging ayam pilihan yang dibakar sempurna, disiram dengan bumbu kacang medok khas Madura yang manis dan gurih.'],
            ['name' => 'Soto Betawi', 'price' => 35000, 'description' => 'Soto khas Jakarta dengan potongan daging sapi empuk, jeroan, dan kentang, dimasak dalam kuah santan dan susu yang kaya rempah.'],
            ['name' => 'Rendang Daging Sapi', 'price' => 40000, 'description' => 'Masakan daging sapi yang dimasak perlahan dengan santan dan bumbu rempah otentik Minangkabau hingga kering dan meresap sempurna.'],
            ['name' => 'Gado-gado Siram', 'price' => 22000, 'description' => 'Salad sayuran Indonesia berisi lontong, tahu, tempe, dan aneka sayuran rebus, disiram dengan saus kacang yang lezat dan kerupuk.'],
            ['name' => 'Bakso Urat Komplit', 'price' => 20000, 'description' => 'Semangkuk bakso urat yang kenyal disajikan komplit dengan mie kuning, bihun, sawi, tahu, dan pangsit goreng renyah.'],
            ['name' => 'Nasi Padang Komplit', 'price' => 32000, 'description' => 'Sajian nasi hangat dengan lauk rendang, gulai nangka, daun singkong rebus, dan sambal hijau yang menggugah selera.'],
            ['name' => 'Ikan Gurame Bakar', 'price' => 65000, 'description' => 'Ikan gurame ukuran sedang yang segar, dibumbui lalu dibakar di atas arang, disajikan dengan sambal kecap dan lalapan.'],
            ['name' => 'Ayam Penyet Sambal Korek', 'price' => 26000, 'description' => 'Ayam goreng tradisional yang empuk dan gurih, dipenyet dan disajikan di atas cobek dengan sambal korek super pedas.'],
            ['name' => 'Rawon Daging', 'price' => 33000, 'description' => 'Sup daging sapi berkuah hitam pekat dari kluwek, disajikan dengan tauge pendek, telur asin, dan sambal terasi.'],
            ['name' => 'Gudeg Jogja', 'price' => 25000, 'description' => 'Paket nasi gudeg komplit khas Yogyakarta, terdiri dari nangka muda manis, sambal krecek pedas, opor ayam, dan telur pindang.'],
            ['name' => 'Sop Buntut', 'price' => 55000, 'description' => 'Sop legendaris dengan potongan buntut sapi yang direbus hingga empuk, disajikan dengan kentang, wortel, dan taburan seledri.'],
            ['name' => 'Pempek Palembang', 'price' => 25000, 'description' => 'Paket pempek asli Palembang, berisi kapal selam, lenjer, dan adaan, disajikan dengan kuah cuko asam manis pedas.'],
            ['name' => 'Ketoprak Jakarta', 'price' => 18000, 'description' => 'Hidangan khas Betawi berisi lontong, tahu, bihun, tauge, dan timun, dicampur dengan bumbu kacang dan bawang goreng.'],
            ['name' => 'Siomay Bandung', 'price' => 23000, 'description' => 'Siomay ikan tenggiri kukus yang lezat, disajikan lengkap dengan kentang, kol, pare, dan telur, lalu disiram bumbu kacang.'],
            ['name' => 'Tahu Tek Surabaya', 'price' => 20000, 'description' => 'Makanan khas Surabaya berisi tahu setengah matang dan lontong yang digunting, ditambah kentang, tauge, dan saus petis udang.'],
            ['name' => 'Iga Bakar Madu', 'price' => 75000, 'description' => 'Potongan iga sapi premium yang direbus lama hingga empuk, lalu dibakar dengan olesan bumbu madu yang manis dan meresap.'],
            ['name' => 'Nasi Uduk Betawi', 'price' => 15000, 'description' => 'Nasi yang dimasak dengan santan dan rempah, disajikan komplit dengan bihun goreng, tempe orek, telur dadar, dan sambal.'],
            ['name' => 'Karedok', 'price' => 20000, 'description' => 'Salad sayuran mentah khas Sunda yang terdiri dari kol, tauge, kacang panjang, dan terong, diaduk dengan bumbu kacang segar.'],
            ['name' => 'Lontong Sayur', 'price' => 18000, 'description' => 'Potongan lontong yang lembut disiram dengan kuah sayur labu siam dan nangka muda, dilengkapi dengan telur dan kerupuk.'],
            ['name' => 'Sate Padang', 'price' => 32000, 'description' => 'Sate dari potongan lidah dan daging sapi yang direbus dengan bumbu, lalu dibakar dan disajikan dengan kuah kuning kental yang pedas.'],
            ['name' => 'Nasi Liwet Solo', 'price' => 24000, 'description' => 'Nasi gurih yang dimasak dengan santan, disajikan dengan suwiran ayam opor, sayur labu siam, dan areh santan kental.'],
            ['name' => 'Sate Lilit Bali', 'price' => 35000, 'description' => 'Sate khas Bali yang terbuat dari daging ayam cincang, dicampur dengan parutan kelapa dan bumbu base genep yang kaya rasa.'],
            ['name' => 'Ayam Betutu', 'price' => 45000, 'description' => 'Setengah ekor ayam yang dimasak sangat lambat dengan bumbu "base genep" khas Bali, menghasilkan daging yang empuk dan sangat beraroma.'],
        ];

        // Memasukkan data ke dalam tabel 'products'
        foreach ($products as $product) {
            Product::create($product);
        }
    }
}