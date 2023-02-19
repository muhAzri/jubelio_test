import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jubelio_test/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ProductService {
  final consumerKey = dotenv.env['CONSUMER_KEY'];
  final consumerSecret = dotenv.env['CONSUMER_SECRET'];
  final cacheManager = DefaultCacheManager();

  Future<List<ProductModel>> fetchProduct(int page) async {
    var perPage = 10;
    try {
      final cachedResult = await cacheManager.getFileFromCache(
        'https://codetesting.jubelio.store/wp-json/wc/v3/products?page=$page&per_page=$perPage',
      );
      if (cachedResult != null) {
        final responseBody = await cachedResult.file.readAsString();
        return List<ProductModel>.from(
          jsonDecode(responseBody).map(
            (product) => ProductModel.fromJson(product),
          ),
        ).toList();
      }

      final res = await http.get(
        Uri.parse(
          'https://codetesting.jubelio.store/wp-json/wc/v3/products?page=$page&per_page=$perPage',
        ),
        headers: {
          'Authorization':
              'Basic ${base64Encode(utf8.encode('$consumerKey:$consumerSecret'))}',
        },
      );
      if (res.statusCode == 200) {
        final responseBody = res.body;
        cacheManager.putFile(
          'https://codetesting.jubelio.store/wp-json/wc/v3/products?page=$page&per_page=$perPage',
          Uint8List.fromList(utf8.encode(responseBody)),
        );
        return List<ProductModel>.from(
          jsonDecode(responseBody).map(
            (product) => ProductModel.fromJson(product),
          ),
        ).toList();
      }

      throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProductModel>> searchProduct(String query) async {
    try {
      final res = await http.get(
        Uri.parse(
            'https://codetesting.jubelio.store/wp-json/wc/v3/products?search=$query'),
        headers: {
          'Authorization':
              'Basic ${base64Encode(utf8.encode('$consumerKey:$consumerSecret'))}',
        },
      );

      if (res.statusCode == 200) {
        return List<ProductModel>.from(
          jsonDecode(res.body).map(
            (product) => ProductModel.fromJson(product),
          ),
        ).toList();
      }
      
      throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }
}
