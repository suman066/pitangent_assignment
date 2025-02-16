import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home_section/model/product_model.dart';

class CartBloc extends Cubit<Map<Product, int>> {
  CartBloc() : super({});

  void addToCart(Product product) {
    final updatedCart = Map<Product, int>.from(state);
    updatedCart.update(product, (quantity) => quantity + 1, ifAbsent: () => 1);
    emit(updatedCart);
  }


  void removeFromCart(Product product) {
    final updatedCart = Map<Product, int>.from(state);
    if (updatedCart.containsKey(product)) {
      if (updatedCart[product]! > 1) {
        updatedCart[product] = updatedCart[product]! - 1;
      } else {
        updatedCart.remove(product);
      }
    }
    emit(updatedCart);
  }
}