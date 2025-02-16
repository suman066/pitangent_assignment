import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home_section/model/product_model.dart';
import 'bloc/cart_bloc.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: BlocBuilder<CartBloc, Map<Product, int>>(
        builder: (context, cartItems) {
          return cartItems.isEmpty
              ? Center(child: Text('Cart is empty'))
              : ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final product = cartItems.keys.elementAt(index);
              final quantity = cartItems[product]!;
              return ListTile(
                leading: Image.network(product.image, width: 50, height: 50),
                title: Text(product.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                subtitle: Text('\$${product.price} x $quantity'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () {
                        context.read<CartBloc>().removeFromCart(product);
                      },
                    ),
                    Text(
                      '$quantity',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.add_circle, color: Colors.green),
                      onPressed: () {
                        context.read<CartBloc>().addToCart(product);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
