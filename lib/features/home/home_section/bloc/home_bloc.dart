import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../model/product_model.dart';
import '../repository/home_repo.dart';
import 'home_event.dart';
import 'home_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final HomeRepo homeRepo;
  ProductBloc(this.homeRepo) : super(ProductLoading()) {
    on<FetchProducts>((event, emit) async {
      try {
        final products = await homeRepo.fetchProducts();
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError());
      }
    });
  }
}