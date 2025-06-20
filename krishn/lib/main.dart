// Salin dan tempel seluruh kode ini ke file main.dart Anda
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io'; // Import untuk Platform

void main() {
  runApp(const MainApp());
}

// FUNGSI UNTUK MENDAPATKAN URL API YANG BENAR
String get apiUrl {
  // Ganti '192.168.1.10' dengan IP Address LOKAL KOMPUTER ANDA
  const String localIp = '192.168.1.10'; 
  
  if (Platform.isAndroid) {
    // Untuk emulator Android, 10.0.2.2 merujuk ke localhost komputer
    // Tapi untuk device fisik, harus pakai IP lokal
    // Cara paling aman adalah selalu gunakan IP lokal komputer.
    return 'http://$localIp:8000/api/products';
  } else {
    // Untuk iOS atau platform lain
    return 'http://$localIp:8000/api/products';
  }
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
  List<dynamic> products = [];
  bool isLoading = true; // Set true agar loading tampil saat pertama kali
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchProducts(); // Langsung panggil data saat halaman dibuka
  }

  Future<void> fetchProducts() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await http
          .get(Uri.parse(apiUrl))
          .timeout(const Duration(seconds: 10)); // Timeout lebih lama
          
      debugPrint('Connecting to: $apiUrl');
      debugPrint('Status code: ${response.statusCode}');
      debugPrint('Body: ${response.body}');

      if (response.statusCode == 200) {
        // Cek jika response body tidak kosong
        if (response.body.isNotEmpty) {
           final data = jsonDecode(response.body);
            setState(() {
              products = data;
              isLoading = false;
            });
        } else {
           setState(() {
            products = []; // Atur data jadi kosong jika response body kosong
            isLoading = false;
          });
        }
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Failed to load products. Status code: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error connecting to server: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Produk'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchProducts,
            tooltip: 'Refresh Data',
          ),
        ],
      ),
      body: Center( // Dibungkus dengan Center
        child: isLoading
            ? const CircularProgressIndicator()
            : errorMessage != null
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Gagal memuat data:\n$errorMessage',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  )
                : products.isEmpty
                    ? const Text('Tidak ada produk yang tersedia.')
                    : ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            child: ListTile(
                              title: Text(
                                product['name']?.toString() ?? 'Nama tidak tersedia', 
                                style: const TextStyle(fontWeight: FontWeight.bold)
                              ),
                              subtitle: Text('Harga: Rp ${product['price']?.toString() ?? '0'}'),
                              leading: CircleAvatar(
                                child: Text((index + 1).toString()),
                              ),
                            ),
                          );
                        },
                      ),
      ),
    );
  }
}