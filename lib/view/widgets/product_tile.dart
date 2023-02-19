import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jubelio_test/models/product.dart';
import 'package:jubelio_test/shared/method.dart';
import 'package:jubelio_test/shared/theme.dart';
import 'package:jubelio_test/view/pages/detail_page.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;

  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(product: product),
          ),
        );
      },
      child: Container(
        width: 327.w,
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(
            color: blackColor,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductImage(),
            _buildProductInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    if (product.imageUrl != null && product.imageUrl!.isNotEmpty) {
      return Container(
        width: 70.w,
        height: 70.h,
        margin: EdgeInsets.only(right: 12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          image: DecorationImage(
            image: CachedNetworkImageProvider(product.imageUrl![0]),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
    return Container(
      width: 70.w,
      height: 70.h,
      margin: EdgeInsets.only(right: 12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Center(
        child: Text(
          'No Image',
          style: primaryTextStyle.copyWith(
            fontSize: 16.sp,
            fontWeight: bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildProductInfo() {
    var price = 0.0;
    if (product.price.isNotEmpty) {
      price = double.tryParse(product.price) ?? 0.0;
    }

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: primaryTextStyle.copyWith(
              fontSize: 16.sp,
              fontWeight: semiBold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          SizedBox(
            height: 6.h,
          ),
          Text(
            formatCurrency(price),
            style: secondaryTextStyle.copyWith(
              fontWeight: semiBold,
              color: redColor,
            ),
          )
        ],
      ),
    );
  }
}
