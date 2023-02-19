import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jubelio_test/models/product.dart';
import 'package:jubelio_test/shared/method.dart';
import 'package:jubelio_test/shared/theme.dart';
import 'package:provider/provider.dart';

import '../../state/cart/cart_provider.dart';

class DetailPage extends StatelessWidget {
  final ProductModel product;

  const DetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context: context),
      floatingActionButton: _buildAddToCartButton(context: context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    Widget buildCartButton() {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/cart-page');
        },
        child: Container(
          margin: EdgeInsets.only(right: 24.w),
          child: Icon(
            Icons.shopping_cart_outlined,
            color: whiteColor,
            size: 24.sp,
          ),
        ),
      );
    }

    return AppBar(
      backgroundColor: grayColor,
      centerTitle: true,
      elevation: 0,
      title: Text(
        "Detail Page",
        style: primaryTextStyle.copyWith(
          fontSize: 18.sp,
          fontWeight: bold,
          color: whiteColor,
        ),
      ),
      actions: [
        buildCartButton(),
      ],
    );
  }

  Widget _buildBody({required BuildContext context}) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      children: [
        _buildProductImage(),
        _buildProductCredential(),
      ],
    );
  }

  Widget _buildProductImage() {
    if (product.imageUrl!.isNotEmpty) {
      return Container(
        margin: EdgeInsets.only(top: 48.h),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: grayColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: CarouselSlider(
          items: product.imageUrl!
              .map((url) => CachedNetworkImage(imageUrl: url))
              .toList(),
          options: CarouselOptions(
            viewportFraction: 1,
            enableInfiniteScroll: false,
            autoPlay: true,
          ),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.only(top: 48.h),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: grayColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Center(
        child: Text(
          'Product Ini Tidak Memiliki Photo',
          style: primaryTextStyle.copyWith(
            fontSize: 16.sp,
            fontWeight: bold,
            color: whiteColor,
          ),
        ),
      ),
    );
  }

  Widget _buildProductCredential() {
    return Container(
      margin: EdgeInsets.only(top: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductName(),
          _buildPrice(),
          _buildDescription(),
        ],
      ),
    );
  }

  Widget _buildProductName() {
    return Text(
      product.name,
      style: primaryTextStyle.copyWith(
        fontSize: 18.sp,
        fontWeight: bold,
      ),
    );
  }

  Widget _buildPrice() {
    var price = 0.0;
    if (product.price.isNotEmpty) {
      price = double.tryParse(product.price) ?? 0.0;
    }

    return Container(
      margin: EdgeInsets.only(top: 12.h),
      child: Text(
        formatCurrency(price),
        style: primaryTextStyle.copyWith(
          fontSize: 16.sp,
          fontWeight: semiBold,
          color: redColor,
        ),
      ),
    );
  }

  Widget _buildDescription() {
    String description =
        product.description.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '');

    return Container(
      margin: EdgeInsets.only(top: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: primaryTextStyle.copyWith(
              fontSize: 16.sp,
              fontWeight: bold,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8.h),
            child: Text(
              product.description.isEmpty
                  ? "Produk Tidak Memiliki Description"
                  : description,
              style: secondaryTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAddToCartButton({required BuildContext context}) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return GestureDetector(
      onTap: () {
        showCustomSnackbar(context, '${product.name} ditambahkan kedalam Cart');

        cartProvider.addProduct(product);
      },
      child: Container(
        height: 50.h,
        margin: EdgeInsets.symmetric(horizontal: 24.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: Colors.orangeAccent,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Add to Cart",
                style: primaryTextStyle.copyWith(
                  fontSize: 16.sp,
                  fontWeight: bold,
                ),
              ),
              SizedBox(
                width: 4.w,
              ),
              Icon(
                Icons.shopping_cart,
                color: blackColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
