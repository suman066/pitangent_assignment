import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home_section/model/product_model.dart';

class CartBloc extends Cubit<List<Product>> {
  CartBloc() : super([]);

  void addToCart(Product product) {
    emit([...state, product]);
  }
}