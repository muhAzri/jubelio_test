import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jubelio_test/shared/method.dart';
import 'package:jubelio_test/shared/theme.dart';
import 'package:provider/provider.dart';

import '../../models/cart.dart';
import '../../state/cart/cart_provider.dart';

class CartItem extends StatefulWidget {
  final CartModel cart;
  const CartItem({super.key, required this.cart});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.h,
      ),
      margin: EdgeInsets.only(
        bottom: 12.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: blackColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildProduct(),
          _buildButtonRow(),
        ],
      ),
    );
  }

  Widget _buildProduct() {
    return Row(
      children: [
        _buildProductPicture(),
        _buildProductInfo(),
      ],
    );
  }

  Widget _buildProductPicture() {
    if (widget.cart.product.imageUrl!.isNotEmpty) {
      return Container(
        width: 70.w,
        height: 70.h,
        padding: EdgeInsets.symmetric(
          horizontal: 6.8.w,
          vertical: 6.8.h,
        ),
        margin: EdgeInsets.only(
          right: 12.w,
        ),
        decoration: BoxDecoration(
          color: grayColor,
          borderRadius: BorderRadius.circular(6.5.r),
        ),
        child: CachedNetworkImage(
          imageUrl: widget.cart.product.imageUrl!.first,
          fit: BoxFit.cover,
        ),
      );
    }
    return Container(
      width: 70.w,
      height: 70.h,
      padding: EdgeInsets.symmetric(
        horizontal: 6.8.w,
        vertical: 6.8.h,
      ),
      margin: EdgeInsets.only(
        right: 12.w,
      ),
      decoration: BoxDecoration(
        color: grayColor,
        borderRadius: BorderRadius.circular(6.5.r),
      ),
      child: Text(
        "No Image",
        style: primaryTextStyle.copyWith(
          fontSize: 18.sp,
          fontWeight: bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildProductInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductName(),
          _buildPrice(),
        ],
      ),
    );
  }

  Widget _buildProductName() {
    return Text(
      widget.cart.product.name,
      style: primaryTextStyle.copyWith(
        fontSize: 16.sp,
        fontWeight: bold,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildPrice() {
    var price = 0.0;
    if (widget.cart.product.price.isNotEmpty) {
      price = double.tryParse(widget.cart.product.price) ?? 0.0;
    }

    return Container(
      margin: EdgeInsets.only(top: 4.h),
      child: Text(
        formatCurrency(price * widget.cart.quantity),
        style: primaryTextStyle.copyWith(
          fontSize: 16.sp,
          fontWeight: semiBold,
          color: redColor,
        ),
      ),
    );
  }

  Widget _buildButtonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildDeleteButton(),
        _buildQuantityButtons(),
      ],
    );
  }

  Widget _buildDeleteButton() {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    return GestureDetector(
      onTap: () {
        cartProvider.removeCart(widget.cart.id!);
      },
      child: Container(
        margin: EdgeInsets.only(top: 12.h),
        child: Center(
          child: Icon(
            Icons.delete,
            color: redColor,
            size: 24.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildQuantityButtons() {
    return Container(
      margin: EdgeInsets.only(top: 12.h),
      padding: EdgeInsets.symmetric(
        horizontal: 6.w,
        vertical: 4.h,
      ),
      decoration: BoxDecoration(
        color: grayColor,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildMinusButton(),
          _buildQuantityText(),
          _buildPlusButton(),
        ],
      ),
    );
  }

  Widget _buildMinusButton() {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return GestureDetector(
      onTap: () {
        cartProvider.reduceQuantity(widget.cart.id!);
      },
      child: Icon(
        Icons.remove,
        color: whiteColor,
      ),
    );
  }

  Widget _buildQuantityText() {
    return SizedBox(
      width: 30.w,
      height: 18.h,
      child: Center(
        child: Text(
          widget.cart.quantity.toString(),
          style: primaryTextStyle.copyWith(
            fontWeight: semiBold,
            color: whiteColor,
          ),
        ),
      ),
    );
  }

  Widget _buildPlusButton() {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    return GestureDetector(
      onTap: () {
        cartProvider.addQuantity(widget.cart.id!);
      },
      child: Icon(
        Icons.add,
        color: whiteColor,
      ),
    );
  }
}
