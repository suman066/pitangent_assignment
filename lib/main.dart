import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/features/home/home_section/repository/home_repo.dart';

import 'common/helper/firebase_helper.dart';
import 'common/helper/navigation_helper.dart';
import 'features/home/cart_section/bloc/cart_bloc.dart';
import 'features/home/home_section/bloc/home_bloc.dart';
import 'features/home/home_section/bloc/home_event.dart';


Future<void> main() async {
  await CustomNavigationHelper.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Ensure this is included
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CartBloc()),
        BlocProvider(create: (context) => ProductBloc(HomeRepo())..add(FetchProducts())),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: CustomNavigationHelper.router,
      ),
    );
  }
}


