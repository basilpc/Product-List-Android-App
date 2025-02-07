import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Services/api.dart';

///Fetch All Products
Future<List<dynamic>> fetchProducts() async {
  final response = await http.get(Uri.parse('$apiUrl/products'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load products');
  }
}

///Fetch Single Product Details
Future<Map<String, dynamic>> fetchProductDetails(int id) async {
  final response = await http.get(Uri.parse('$apiUrl/products/$id'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load product details');
  }
}