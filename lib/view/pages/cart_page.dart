import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jubelio_test/shared/method.dart';
import 'package:jubelio_test/view/widgets/cart_item.dart';
import 'package:provider/provider.dart';

import '../../shared/theme.dart';
import '../../state/cart/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildCheckoutButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: _buildAppBar(),
      body: _buildCartList(
        context: context,
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: grayColor,
      centerTitle: true,
      elevation: 0,
      title: Text(
        "Cart Page",
        style: primaryTextStyle.copyWith(
          fontSize: 18.sp,
          fontWeight: bold,
          color: whiteColor,
        ),
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Text(
        "Your Cart Empty",
        style: primaryTextStyle.copyWith(fontSize: 24.sp, fontWeight: semiBold),
      ),
    );
  }

  Widget _buildCartList({required BuildContext context}) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    if (cartProvider.carts.isEmpty) {
      return _buildEmptyCart();
    }

    return ListView(
      padding: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        top: 24.h,
        bottom: 96.h,
      ),
      children: cartProvider.carts
          .map((cart) => CartItem(
                cart: cart,
              ))
          .toList(),
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    if (cartProvider.carts.isEmpty) {
      return const SizedBox();
    }
    return GestureDetector(
      onTap: () {
        showCustomSnackbar(context, 'Checkout Berhasil');
        cartProvider.removeAllCart();
      },
      child: Container(
        height: 50.w,
        margin: EdgeInsets.symmetric(horizontal: 24.w),
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 6.h,
        ),
        decoration: BoxDecoration(
          color: redColor,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Center(
          child: Text(
            "Checkout",
            style: primaryTextStyle.copyWith(
              fontSize: 18.sp,
              fontWeight: semiBold,
              color: whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
