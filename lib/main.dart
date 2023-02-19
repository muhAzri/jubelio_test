import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:jubelio_test/state/cart/cart_provider.dart';
import 'package:jubelio_test/state/product/product_bloc.dart';
import 'package:jubelio_test/shared/theme.dart';
import 'package:jubelio_test/view/pages/cart_page.dart';
import 'package:jubelio_test/view/pages/main_page.dart';
import 'package:jubelio_test/view/pages/splash_page.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(),
        ),
      ],
      child: ChangeNotifierProvider<CartProvider>(
        create: (context) => CartProvider(),
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (BuildContext context, Widget? child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                scaffoldBackgroundColor: whiteColor,
              ),
              routes: {
                '/': (context) => const SplashPage(),
                '/main': (context) => const MainPage(),
                '/cart-page': (context) => const CartPage(),
              },
            );
          },
        ),
      ),
    );
  }
}
