import 'package:flutter/material.dart';

void main() {
  runApp(const EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const DashboardScreen(),
    );
  }
}

/// --- DASHBOARD MAIN SCREEN ---
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> products = [
      {
        'title': 'Headphones',
        'desc': 'Immersive sound with premium active noise cancellation and a 40-hour wireless playback battery life.',
        'price': '\$99.99',
        'icon': Icons.headphones,
        'color': Colors.blue[50],
        'accent': Colors.blue[800], 
      },
      {
        'title': 'Smart Watch',
        'desc': 'Track your daily workouts, resting heart rate, deep sleep quality, and receive real-time incoming phone notifications.',
        'price': '\$149.99',
        'icon': Icons.watch,
        'color': Colors.teal[50],
        'accent': Colors.teal[800],
      },
      {
        'title': 'Wireless Mouse',
        'desc': 'Ergonomic ultra-silent clicking layout design featuring adjustable precision DPI gaming tracking levels.',
        'price': '\$29.99',
        'icon': Icons.mouse,
        'color': Colors.amber[50],
        'accent': Colors.amber[900],
      },
      {
        'title': 'Gaming Keyboard',
        'desc': 'Tactile mechanical blue switches featuring a fully customizable dynamic RGB backlighting key profile ecosystem.',
        'price': '\$79.99',
        'icon': Icons.keyboard,
        'color': Colors.purple[50],
        'accent': Colors.purple[800],
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Gadget Dashboard', 
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,        
            crossAxisSpacing: 14,     
            mainAxisSpacing: 14,      
            childAspectRatio: 0.72,   // Gives plenty of room for big text and descriptions
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return AnimatedProductCard(product: product);
          },
        ),
      ),
    );
  }
}

/// --- THE DEMONSTRATION CARD COMPONENT ---
class AnimatedProductCard extends StatelessWidget {
  final Map<String, dynamic> product;

  const AnimatedProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0, 
      color: product['color'], 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0), 
      ),
      clipBehavior: Clip.antiAlias, 
      child: InkWell(
        splashColor: product['accent'].withOpacity(0.15),
        highlightColor: Colors.transparent,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(product: product),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(14.0), 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icon Container
              Container(
                padding: const EdgeInsets.all(10), 
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  product['icon'], 
                  size: 34, 
                  color: product['accent'],
                ),
              ),
              
              // Text Layout Block
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['title'],
                    // FIXED: Changed to FontWeight.w800 and solid black color
                    style: const TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.w800,
                      color: Colors.black, 
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    product['desc'],
                    maxLines: 3, 
                    overflow: TextOverflow.ellipsis,  
                    style: const TextStyle(
                      fontSize: 13, 
                      color: Colors.black87, 
                      fontWeight: FontWeight.w500, 
                      height: 1.3, 
                    ),
                  ),
                ],
              ),
              
              // Price Listing
              Text(
                product['price'],
                // FIXED: Changed to FontWeight.w900 for extra bold pricing visibility
                style: TextStyle(
                  fontSize: 16, 
                  fontWeight: FontWeight.w900, 
                  color: product['accent'],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// --- INTERACTIVE DETAIL SCREEN ---
class ProductDetailScreen extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: product['color'],
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                product['icon'], 
                size: 130, 
                color: product['accent'],
              ),
              const SizedBox(height: 24),
              Text(
                product['title'],
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                product['desc'],
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, color: Colors.black87, height: 1.4),
              ),
              const SizedBox(height: 32),
              Text(
                product['price'],
                style: TextStyle(
                  fontSize: 28, 
                  fontWeight: FontWeight.bold, 
                  color: product['accent'],
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Added ${product['title']} to cart!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: product['accent'],
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                label: const Text(
                  'Add to Cart', 
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}