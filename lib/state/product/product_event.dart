part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchProductEvent extends ProductEvent {
  final int page;

  const FetchProductEvent(
    this.page,
  );

  @override
  List<Object> get props => [page];
}

class SearchProductEvent extends ProductEvent {
  final String query;

  const SearchProductEvent(this.query);

  @override
  List<Object> get props => [query];
}
