// Lokasi: krishn/lib/main.dart (Versi Final)

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductPage(),
    );
  }
}

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  // 1. Ubah isLoading menjadi true agar loading tampil saat pertama kali
  bool isLoading = true;
  List<dynamic> products = [];
  String? errorMessage;

  // 2. Gunakan initState untuk memanggil data secara otomatis
  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    // Set state untuk menampilkan loading dan menghapus error lama
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    // URL API dari server Laravel Anda
    const url = 'http://127.0.0.1:8000/api/products';

    try {
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      
      // Print di debug console untuk memastikan kode berjalan
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        // Jika respons berhasil, decode JSON
        setState(() {
          products = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        // Jika server merespons dengan error (404, 500, dll)
        setState(() {
          errorMessage = 'Gagal memuat data. Status: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      // Jika terjadi error koneksi (misal: server mati, tidak ada internet)
      debugPrint('Error: $e');
      setState(() {
        errorMessage = 'Terjadi kesalahan koneksi: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produk Laravel'),
        actions: [
          // Tambahkan tombol refresh di AppBar
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchProducts,
          ),
        ],
      ),
      body: Center(
        child: _buildBody(),
      ),
    );
  }

  // Widget helper untuk body agar lebih rapi
  Widget _buildBody() {
    if (isLoading) {
      // Tampilkan loading jika isLoading true
      return const CircularProgressIndicator();
    } else if (errorMessage != null) {
      // Tampilkan pesan error jika ada
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          errorMessage!,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.red, fontSize: 16),
        ),
      );
    } else if (products.isEmpty) {
      // Tampilkan pesan jika data kosong
      return const Text('Tidak ada produk yang ditemukan.');
    } else {
      // Tampilkan daftar produk jika semua berhasil
      return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: CircleAvatar(child: Text('${product['id']}')),
              title: Text(product['name'] ?? 'Tanpa Nama'),
              subtitle: Text('Harga: ${product['price']}'),
            ),
          );
        },
      );
    }
  }
}