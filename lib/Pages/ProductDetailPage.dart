import 'package:flutter/material.dart';
import 'package:productlist/Pages/productApiIntegration.dart';
class ProductDetailPage extends StatefulWidget {
  final int productId;
  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late Future<Map<String, dynamic>> productDetails;

  @override
  void initState() {
    super.initState();
    productDetails = fetchProductDetails(widget.productId);
    print('productDetails,$productDetails');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: productDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: \${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No product details available'));
          }

          final productData = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(productData['image'], height: 200, fit: BoxFit.cover),
                ),
                const SizedBox(height: 16),
                Text(
                  productData['title'],
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Category: ${productData['category']}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${productData['price']}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                ),
                const SizedBox(height: 16),
                Text(
                  'Description:',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  productData['description'],
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rating: ${productData['rating']['rate']}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                    Text(
                      'Reviews: ${productData['rating']['count']}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
