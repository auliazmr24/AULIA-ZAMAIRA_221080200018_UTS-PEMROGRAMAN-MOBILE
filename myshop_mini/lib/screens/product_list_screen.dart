import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/product.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatelessWidget {
  final Category category;

  const ProductListScreen({super.key, required this.category});

  List<Product> _getProductsByCategory(String categoryId) {
    final allProducts = [
      // Makanan - semua warna seragam
      Product(
        id: 'p1',
        name: 'Nasi Goreng',
        price: 25000,
        icon: Icons.rice_bowl,
        categoryId: 'food',
        color: const Color(0xFF6B7FD7),
      ),
      Product(
        id: 'p2',
        name: 'Mie Ayam',
        price: 20000,
        icon: Icons.ramen_dining,
        categoryId: 'food',
        color: const Color(0xFF6B7FD7),
      ),
      Product(
        id: 'p3',
        name: 'Sate Ayam',
        price: 30000,
        icon: Icons.lunch_dining,
        categoryId: 'food',
        color: const Color(0xFF6B7FD7),
      ),
      Product(
        id: 'p4',
        name: 'Gado-Gado',
        price: 18000,
        icon: Icons.set_meal,
        categoryId: 'food',
        color: const Color(0xFF6B7FD7),
      ),
      // Minuman
      Product(
        id: 'd1',
        name: 'Es Teh Manis',
        price: 8000,
        icon: Icons.local_cafe,
        categoryId: 'drink',
        color: const Color(0xFF6B7FD7),
      ),
      Product(
        id: 'd2',
        name: 'Jus Alpukat',
        price: 15000,
        icon: Icons.local_bar,
        categoryId: 'drink',
        color: const Color(0xFF6B7FD7),
      ),
      Product(
        id: 'd3',
        name: 'Kopi Susu',
        price: 18000,
        icon: Icons.coffee,
        categoryId: 'drink',
        color: const Color(0xFF6B7FD7),
      ),
      Product(
        id: 'd4',
        name: 'Air Mineral',
        price: 5000,
        icon: Icons.water_drop,
        categoryId: 'drink',
        color: const Color(0xFF6B7FD7),
      ),
      // Elektronik
      Product(
        id: 'e1',
        name: 'Smartphone',
        price: 3500000,
        icon: Icons.smartphone,
        categoryId: 'electronic',
        color: const Color(0xFF6B7FD7),
      ),
      Product(
        id: 'e2',
        name: 'Laptop',
        price: 8500000,
        icon: Icons.laptop,
        categoryId: 'electronic',
        color: const Color(0xFF6B7FD7),
      ),
      Product(
        id: 'e3',
        name: 'Headphone',
        price: 450000,
        icon: Icons.headphones,
        categoryId: 'electronic',
        color: const Color(0xFF6B7FD7),
      ),
      Product(
        id: 'e4',
        name: 'Smart Watch',
        price: 1200000,
        icon: Icons.watch,
        categoryId: 'electronic',
        color: const Color(0xFF6B7FD7),
      ),
    ];

    return allProducts.where((p) => p.categoryId == categoryId).toList();
  }

  String _formatPrice(double price) {
    return 'Rp ${price.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        )}';
  }

  @override
  Widget build(BuildContext context) {
    final products = _getProductsByCategory(category.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          category.name,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title dengan style konsisten
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFF6B7FD7), Color(0xFF9B8FD9)],
                ).createShader(bounds),
                child: Text(
                  category.name,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${products.length} produk tersedia',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              // Grid 2 kolom
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return _buildProductCard(context, products[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: product.color.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon dengan gradient background
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      // ignore: deprecated_member_use
                      product.color.withOpacity(0.2),
                      // ignore: deprecated_member_use
                      product.color.withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  product.icon,
                  size: 40,
                  color: product.color,
                ),
              ),
              const SizedBox(height: 12),
              // Label
              Text(
                product.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2C3E50),
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 8),
              // Price dengan badge style
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: product.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _formatPrice(product.price),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: product.color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}