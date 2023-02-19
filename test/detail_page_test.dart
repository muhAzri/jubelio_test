import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jubelio_test/models/product.dart';
import 'package:jubelio_test/state/cart/cart_provider.dart';
import 'package:jubelio_test/view/pages/detail_page.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('DetailPage displays product details and adds to cart',
      (WidgetTester tester) async {
    // Create a ProductModel to be displayed on the detail page
    const product = ProductModel(
      id: 1,
      name: 'Test Product',
      description: 'This is a test product',
      imageUrl: [
        'https://www.google.com/url?sa=i&url=https%3A%2F%2Fmerchant.id%2Fcontent%2Fproduct-life-cycle-mengenal-lebih-dekat-dari-tahapan-sampai-manajemennya%2Fattachment%2Fexample%2F&psig=AOvVaw194n5LwZ_yHLGwt_XohQbO&ust=1676902947496000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCOin37Xkof0CFQAAAAAdAAAAABAE',
      ],
      price: '10.00',
    );

    // create a mock CartProvider
    final cartProvider = CartProvider();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: cartProvider),
        ],
        child: MaterialApp(
          home: ScreenUtilInit(
            designSize: const Size(375, 812),
            builder: (context, child) {
              return const DetailPage(product: product);
            },
          ),
        ),
      ),
    );

    // verify that the product details are displayed
    expect(find.text('Test Product'), findsOneWidget);
    expect(find.text('This is a test product'), findsOneWidget);
    expect(find.text('Rp 10'), findsOneWidget);

    // verify that the product image is displayed
    expect(find.byType(CachedNetworkImage), findsOneWidget);

    // find the add to cart button and tap it
    final addToCartButton = find.text('Add to Cart');
    expect(addToCartButton, findsOneWidget);
    await tester.tap(addToCartButton);
    await tester.pump();

    // verify that the product is added to the cart
    expect(cartProvider.carts.length, equals(1));
    expect(cartProvider.carts[0].product.id, equals(product.id));
    expect(cartProvider.carts[0].quantity, equals(1));

    await tester.runAsync(() async {
      await Future.delayed(Duration.zero);
    });
  });
}
