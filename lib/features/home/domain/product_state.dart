import 'package:equatable/equatable.dart';
import '../../../shared/models/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {
  const ProductInitial();
}

class ProductLoading extends ProductState {
  const ProductLoading();
}

class ProductLoaded extends ProductState {
  final List<Product> featuredProducts;
  final List<Product> bestSellingProducts;
  final List<Product> searchResults;
  final List<Product> categoryProducts;
  final String selectedCategory;
  final String searchQuery;

  const ProductLoaded({
    this.featuredProducts = const [],
    this.bestSellingProducts = const [],
    this.searchResults = const [],
    this.categoryProducts = const [],
    this.selectedCategory = '',
    this.searchQuery = '',
  });

  ProductLoaded copyWith({
    List<Product>? featuredProducts,
    List<Product>? bestSellingProducts,
    List<Product>? searchResults,
    List<Product>? categoryProducts,
    String? selectedCategory,
    String? searchQuery,
  }) {
    return ProductLoaded(
      featuredProducts: featuredProducts ?? this.featuredProducts,
      bestSellingProducts: bestSellingProducts ?? this.bestSellingProducts,
      searchResults: searchResults ?? this.searchResults,
      categoryProducts: categoryProducts ?? this.categoryProducts,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
        featuredProducts,
        bestSellingProducts,
        searchResults,
        categoryProducts,
        selectedCategory,
        searchQuery,
      ];
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object?> get props => [message];
}

