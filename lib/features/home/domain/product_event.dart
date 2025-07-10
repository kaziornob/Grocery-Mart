import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class LoadFeaturedProducts extends ProductEvent {
  const LoadFeaturedProducts();
}

class LoadBestSellingProducts extends ProductEvent {
  const LoadBestSellingProducts();
}

class LoadProductsByCategory extends ProductEvent {
  final String category;

  const LoadProductsByCategory(this.category);

  @override
  List<Object?> get props => [category];
}

class SearchProducts extends ProductEvent {
  final String query;

  const SearchProducts(this.query);

  @override
  List<Object?> get props => [query];
}

class LoadAllProducts extends ProductEvent {
  const LoadAllProducts();
}

