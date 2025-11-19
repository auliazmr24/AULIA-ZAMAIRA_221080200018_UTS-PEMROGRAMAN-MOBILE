import 'package:flutter/material.dart';
import '../models/category.dart';
import 'product_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  List<Category> _getCategories() {
    return [
      Category(
        id: 'food',
        name: 'Makanan',
        icon: Icons.restaurant,
        color: const Color(0xFF6B7FD7), // Soft periwinkle
      ),
      Category(
        id: 'drink',
        name: 'Minuman',
        icon: Icons.local_drink,
        color: const Color(0xFF6B7FD7), // Sama - konsisten
      ),
      Category(
        id: 'electronic',
        name: 'Elektronik',
        icon: Icons.devices,
        color: const Color(0xFF6B7FD7), // Sama - konsisten
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final categories = _getCategories();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MyShop Mini',
          style: TextStyle(
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
              // Title dengan gradient text effect
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFF6B7FD7), Color(0xFF9B8FD9)],
                ).createShader(bounds),
                child: const Text(
                  'MyShop Mini',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Pilih kategori belanja',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 32),
              // Row: 3 Card dengan desain modern
              Row(
                children: categories.asMap().entries.map((entry) {
                  int idx = entry.key;
                  Category category = entry.value;
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: idx == 0 ? 0 : 8,
                        right: idx == categories.length - 1 ? 0 : 8,
                      ),
                      child: _buildCategoryCard(context, category, idx),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, Category category, int index) {
    // Variasi opacity untuk depth
    final opacities = [1.0, 0.9, 0.85];
    
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductListScreen(category: category),
          ),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              // ignore: deprecated_member_use
              category.color.withOpacity(opacities[index]),
              // ignore: deprecated_member_use
              category.color.withOpacity(opacities[index] - 0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: category.color.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon dengan background circle
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: Colors.white.withOpacity(0.25),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  category.icon,
                  size: 36,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              // Label
              Text(
                category.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}