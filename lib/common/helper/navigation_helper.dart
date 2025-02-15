import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_project/features/auth/view/signin_page.dart';


class CustomNavigationHelper {
  static final CustomNavigationHelper _instance = CustomNavigationHelper._internal();

  static CustomNavigationHelper get instance => _instance;
  static late final GoRouter router;
  static final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
  static bool _isInitialized = false;
  static const String loginPath = '/signin';
  static const String dashboardPath = '/dashboard';



  CustomNavigationHelper._internal();
  factory CustomNavigationHelper() {
    return _instance;
  }

  Future<String> getToken() async {
    String token = '';
    return token;
  }

  static Future<void> initialize() async {
    if (_isInitialized) return; // Prevent multiple initializations
    _isInitialized = true;
    var token = await _instance.getToken();
    //print('token in helper:::: $token +++++ ${token.length}');
    var routerConfigVal = loginPath;
    if (token.isEmpty) {
      routerConfigVal = loginPath;
    } else {
      routerConfigVal = dashboardPath;
    }
    router = GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: routerConfigVal,
      debugLogDiagnostics: true,
      routes: <RouteBase>[
        GoRoute(
          parentNavigatorKey: rootNavigatorKey,
          path: loginPath,
          pageBuilder: (context, state) {
            return getPage(
              child: PhoneAuthScreen(),
              state: state,
            );
          },
        ),
        /*GoRoute(
          parentNavigatorKey: rootNavigatorKey,
          path: dashboardPath,
          pageBuilder: (context, state) {
            return getPage(
              child: const Dashboard(),
              state: state,
            );
          },
        ),*/

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