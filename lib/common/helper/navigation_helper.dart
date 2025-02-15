import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/features/auth/view/otp_verification_page.dart';
import 'package:test_project/features/auth/view/signin_page.dart';
import 'package:test_project/features/welcome/splash_screen.dart';
import '../../core/common/constants/common_constants.dart';
import '../../features/home/account_section/my_account.dart';
import '../../features/home/cart_section/cart_page.dart';
import '../../features/home/dashboard.dart';
import '../../features/home/home_section/home_page.dart';


class CustomNavigationHelper {
  static final CustomNavigationHelper _instance = CustomNavigationHelper._internal();

  static CustomNavigationHelper get instance => _instance;
  static late final GoRouter router;
  static final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
  static bool _isInitialized = false;
  static  String splashScreenPath = '/splashScreen';
  static  String loginPath = '/signin';
  static  String otpScreenPath = '/otpScreen';
  static  String dashboardPath = '/dashboard';
  static const String homePath = '/home';
  static const String cartPath = '/cart';
  static const String accountPath = '/account';
  static  bool? otpVerified = false;
  static  bool? registered = false;
  static  String? phoneNumber = '';



  CustomNavigationHelper._internal();
  factory CustomNavigationHelper() {
    return _instance;
  }
  getPreferences() async{

    final prefs = await SharedPreferences.getInstance();
    otpVerified = prefs.getBool('otpVerified');
    registered = prefs.getBool('registered');
    phoneNumber = prefs.getString('phoneNumber');


  }
  Future<String> getToken() async {
    String token = '';
    return token;
  }

  static Future<void> initialize() async {
    if (_isInitialized) return; // Prevent multiple initializations
    _isInitialized = true;
    var routerConfigVal = splashScreenPath;

    router = GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: routerConfigVal,
      debugLogDiagnostics: true,
      routes: <RouteBase>[
        GoRoute(
          parentNavigatorKey: rootNavigatorKey,
          path: splashScreenPath,
          pageBuilder: (context, state) {
            return getPage(
              child: SplashScreen(),
              state: state,
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: rootNavigatorKey,
          path: loginPath,
          pageBuilder: (context, state) {
            return getPage(
              child: MobileNumberPage(title: '',),
              state: state,
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: rootNavigatorKey,
          path: otpScreenPath,
          pageBuilder: (context, state) {
            return getPage(
              child: OTPScreen(phoneNumber: number),
              state: state,
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: rootNavigatorKey,
          path: dashboardPath,
          pageBuilder: (context, state) {
            return getPage(
              child: MainPage(),
              state: state,
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: rootNavigatorKey,
          path: homePath,
          pageBuilder: (context, state) => getPage(child: HomePage(), state: state),
        ),
        GoRoute(
          parentNavigatorKey: rootNavigatorKey,
          path: cartPath,
          pageBuilder: (context, state) => getPage(child: CartPage(), state: state),
        ),
        GoRoute(
          parentNavigatorKey: rootNavigatorKey,
          path: accountPath,
          pageBuilder: (context, state) => getPage(child: MyAccountPage(), state: state),
        ),

      ],
    );
  }

  static Page getPage({
    required Widget child,
    required GoRouterState state,
  }) {
    return MaterialPage(
      key: state.pageKey,
      child: child,
    );
  }

}