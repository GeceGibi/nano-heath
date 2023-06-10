part of 'repos.dart';

class ProductRepo {
  ProductRepo._();
  static final instance = ProductRepo._();

  Future<Product?> getDetail(int productId) async {
    final response = await fetch.get('/products/$productId');

    if (response.isOk) {
      return Product.fromJson(response.data);
    }

    return null;
  }

  Future<List<Product>> getList() async {
    final response = await fetch.get('/products');

    if (response.isOk) {
      return List<Map<String, dynamic>>.from(response.data)
          .map(Product.fromJson)
          .toList();
    }

    return [];
  }
}
