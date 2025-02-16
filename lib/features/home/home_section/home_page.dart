import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/common/constants/common_constants.dart';
import '../cart_section/bloc/cart_bloc.dart';
import 'bloc/home_bloc.dart';
import 'bloc/home_state.dart';
import 'model/product_model.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return BlocBuilder<CartBloc, Map<Product, int>>(
                  builder: (context, cartItems) {
                    final quantity = cartItems[product] ?? 0;
                    return Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        leading: Image.network(product.image, width: 50, height: 50),
                        title: Text(product.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                        subtitle: Text('\$${product.price}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle, color: Colors.red),
                              onPressed: quantity > 0 ? () => context.read<CartBloc>().removeFromCart(product) : null,
                            ),
                            Text('$quantity',style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold
                            ),),
                            IconButton(
                              icon: Icon(Icons.add_circle,color: Colors.green),
                              onPressed: () => context.read<CartBloc>().addToCart(product),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return Center(child: Text('Failed to load products'));
          }
        },
      ),
    );
  }
}
