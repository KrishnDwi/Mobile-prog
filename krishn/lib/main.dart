// Lokasi: krishn/lib/main.dart (Versi Final)
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';
import 'product_detail_page.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AuthCheckPage(),
    );
  }
}

class AuthCheckPage extends StatefulWidget {
  const AuthCheckPage({super.key});
  @override
  State<AuthCheckPage> createState() => _AuthCheckPageState();
}

class _AuthCheckPageState extends State<AuthCheckPage> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token != null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const ProductPage()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool isLoading = true;
  String? error;

  // --- STATE BARU UNTUK SEARCH ---
  List<dynamic> _allProducts = []; // Menyimpan semua produk dari API
  List<dynamic> _filteredProducts = []; // Menyimpan produk yang sudah difilter
  final _searchController = TextEditingController(); // Controller untuk search bar
  // --- AKHIR STATE BARU ---

  @override
  void initState() {
    super.initState();
    fetchProducts();
    // Tambahkan listener untuk mendeteksi perubahan pada search bar
    _searchController.addListener(_filterProducts);
  }

  // Jangan lupa dispose controller untuk menghindari memory leak
  @override
  void dispose() {
    _searchController.removeListener(_filterProducts);
    _searchController.dispose();
    super.dispose();
  }

  // --- LOGIKA FILTER ---
  void _filterProducts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        // Jika search bar kosong, tampilkan semua produk
        _filteredProducts = List.from(_allProducts);
      } else {
        // Jika ada query, filter berdasarkan nama produk
        _filteredProducts = _allProducts.where((product) {
          final productName = (product['name'] as String? ?? '').toLowerCase();
          return productName.contains(query);
        }).toList();
      }
    });
  }

  Future<void> fetchProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/products'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        setState(() {
          // Isi kedua list saat data berhasil diambil
          _allProducts = jsonDecode(response.body);
          _filteredProducts = List.from(_allProducts);
        });
      } else {
        setState(() => error = "Gagal memuat data.");
      }
    } catch (e) {
      setState(() => error = "Error: $e");
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    await http.post(
      Uri.parse('http://127.0.0.1:8000/api/logout'),
      headers: {'Authorization': 'Bearer $token'},
    );
    await prefs.remove('auth_token');
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Menu'),
        actions: [
          IconButton(onPressed: _logout, icon: const Icon(Icons.logout))
        ],
      ),
      // Gunakan Column untuk menampung search bar dan list
      body: Column(
        children: [
          // --- WIDGET SEARCH BAR ---
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Cari menu...',
                hintText: 'Contoh: Nasi Goreng',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          // --- AKHIR WIDGET SEARCH BAR ---
          
          // Gunakan Expanded agar ListView mengisi sisa ruang
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : error != null
                    ? Center(child: Text(error!))
                    // Gunakan _filteredProducts untuk menampilkan data
                    : _filteredProducts.isEmpty
                        ? const Center(child: Text('Menu tidak ditemukan.'))
                        : ListView.builder(
                            itemCount: _filteredProducts.length,
                            itemBuilder: (context, index) {
                              final product = _filteredProducts[index];
                              return Card(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4.0),
                                child: ListTile(
                                  title: Text(product['name']),
                                  subtitle: Text('Rp ${product['price']}'),
                                  trailing: const Icon(Icons.chevron_right),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailPage(product: product),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
          ),
        ],
      ),
    );
  }
}