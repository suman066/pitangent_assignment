import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/common/constants/api_constants.dart';
import '../model/product_model.dart';

class HomeRepo {
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(ApiBaseHelper.baseUrl + ApiKeys.products));
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Product.fromJson(data)).toList();
    } catch (e) {
      throw Exception("Failed to load products");
    }
  }
}
