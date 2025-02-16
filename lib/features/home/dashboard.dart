import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'account_section/my_account.dart';
import 'cart_section/bloc/cart_bloc.dart';
import 'cart_section/cart_page.dart';
import 'home_section/home_page.dart';
import 'home_section/model/product_model.dart';


class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  final ValueNotifier<int> selectedIndexNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ValueListenableBuilder<int>(
        valueListenable: selectedIndexNotifier,
        builder: (context, selectedIndex, child) {
          return _getScreen(selectedIndex);
        },
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: selectedIndexNotifier,
        builder: (context, selectedIndex, child) {
          return BlocBuilder<CartBloc, Map<Product, int>>(
              builder: (context, cartItems) {
              return BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: selectedIndex,
                onTap: (index) => onItemTapped(context, index),
                backgroundColor: Colors.white,
                selectedItemColor: const Color(0xff00A000),
                unselectedItemColor: const Color(0xff454545),
                iconSize: 24,
                selectedFontSize: 12,
                unselectedFontSize: 12,
                items: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/images/home.svg',
                      color: selectedIndex == 0 ? const Color(0xff00A000) : const Color(0xff454545),
                      width: 24,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        SvgPicture.asset(
                          'assets/images/add_new.svg',
                          color: selectedIndex == 1 ? const Color(0xff00A000) : const Color(0xff454545),
                          width: 22,
                        ),
                        // Badge for count
                        Positioned(
                          right: -7,
                          top: -3,
                          child:
                          cartItems!=null && cartItems.isNotEmpty?
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              "${cartItems.length}", // Replace with your dynamic count value
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ):Container(),
                        ),
                      ],
                    ),
                    label: 'My Cart',
                  ),

                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/images/my_account.svg',
                      color: selectedIndex == 2 ? const Color(0xff00A000) : const Color(0xff454545),
                      width: 22,
                    ),
                    label: 'My account',
                  ),
                ],
              );
            }
          );
        },
      ),
    );
  }

  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return HomePage();
      case 1:
        return CartPage();
      case 2:
        return MyAccountPage();
      default:
        return HomePage();
    }
  }

  Widget onItemTapped(BuildContext context, int index) {
    selectedIndexNotifier.value = index;

    switch (index) {
      case 0:
        return HomePage();
      case 1:
        return CartPage();
      case 2:
        return MyAccountPage();
      default:
        return HomePage();
    }
  }
}
