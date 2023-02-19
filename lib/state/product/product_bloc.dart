import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jubelio_test/models/product.dart';
import 'package:jubelio_test/services/product_service.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final List<ProductModel> _products = [];

  ProductBloc() : super(ProductInitial()) {
    on<FetchProductEvent>((event, emit) async {
      try {
        emit(ProductLoading());

        final products = await ProductService().fetchProduct(event.page);
        _products.addAll(products);

        emit(
          ProductSuccess(List.from(_products)),
        );
      } catch (e) {
        emit(
          ProductFailed(
            e.toString(),
          ),
        );
      }
    });

    on<SearchProductEvent>((event, emit) async {
      try {
        emit(ProductLoading());

        final products = await ProductService().searchProduct(event.query);

        emit(ProductSuccess(products));
      } catch (e) {
        emit(
          ProductFailed(e.toString()),
        );
      }
    });
  }
}
