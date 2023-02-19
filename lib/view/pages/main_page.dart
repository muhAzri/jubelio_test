import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jubelio_test/models/product.dart';
import 'package:jubelio_test/state/product/product_bloc.dart';
import 'package:jubelio_test/shared/theme.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../widgets/product_tile.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController =
      TextEditingController(text: '');
  int _page = 1;

  late ProductBloc productBloc;

  @override
  void initState() {
    super.initState();

    productBloc = context.read<ProductBloc>()
      ..add(
        FetchProductEvent(_page),
      );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: grayColor,
      centerTitle: true,
      elevation: 0,
      title: Text(
        "Home Page",
        style: primaryTextStyle.copyWith(
          fontSize: 18.sp,
          fontWeight: bold,
          color: whiteColor,
        ),
      ),
      actions: [
        _buildCartButton(context),
      ],
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        _buildSearchField(),
        _searchController.text.isEmpty
            ? _buildProductList()
            : _buildSearchResult(),
      ],
    );
  }

  Widget _buildSearchField() {
    return Container(
      height: 50.h,
      margin: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: blackColor,
        ),
      ),
      child: Center(
        child: TextFormField(
          controller: _searchController,
          style: primaryTextStyle,
          decoration: InputDecoration.collapsed(
            hintText: 'Search',
            hintStyle: secondaryTextStyle,
          ),
          onFieldSubmitted: _handleSearch,
        ),
      ),
    );
  }

  void _handleSearch(String value) {
    if (value.isNotEmpty) {
      productBloc.add(SearchProductEvent(value));
    } else {
      productBloc.add(FetchProductEvent(_page));
    }
    setState(() {});
  }

  Widget _buildSearchResult() {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductSuccess) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              children: state.products
                  .map(
                    (product) => ProductTile(product: product),
                  )
                  .toList(),
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildProductList() {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductSuccess) {
          return _buildProductListView(state.products);
        } else if (state is ProductFailed) {
          return _buildErrorView(state.e);
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildProductListView(List<ProductModel> products) {
    bool isEndOfList = false;
    return LazyLoadScrollView(
      onEndOfPage: () {
        if (!isEndOfList) {
          _loadMoreProducts();
        }
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: ListView.builder(
          itemCount: products.length + 1,
          controller: _scrollController,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h)
              .add(EdgeInsets.only(bottom: 240.h)),
          itemBuilder: (context, index) {
            if (index < products.length) {
              final product = products[index];
              return ProductTile(product: product);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildErrorView(String errorMessage) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(errorMessage),
          Container(
            margin: EdgeInsets.only(top: 24.h),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: grayColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
              onPressed: () => _refreshProductList(),
              child: Text(
                "Refresh",
                style: primaryTextStyle.copyWith(
                  fontSize: 16.sp,
                  fontWeight: bold,
                  color: whiteColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _loadMoreProducts() {
    _page++;
    BlocProvider.of<ProductBloc>(context).add(FetchProductEvent(_page));
    Timer(
      const Duration(milliseconds: 700),
      () => _scrollController.jumpTo(
        _scrollController.position.maxScrollExtent - 812.h,
      ),
    );
  }

  void _refreshProductList() {
    Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
  }

  Widget _buildCartButton(BuildContext context) {
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
}
