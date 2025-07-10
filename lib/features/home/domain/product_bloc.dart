import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/services/product_service.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService _productService;

  ProductBloc({ProductService? productService})
      : _productService = productService ?? ProductService(),
        super(const ProductInitial()) {
    on<LoadFeaturedProducts>(_onLoadFeaturedProducts);
    on<LoadBestSellingProducts>(_onLoadBestSellingProducts);
    on<LoadProductsByCategory>(_onLoadProductsByCategory);
    on<SearchProducts>(_onSearchProducts);
    on<LoadAllProducts>(_onLoadAllProducts);
  }

  Future<void> _onLoadFeaturedProducts(
    LoadFeaturedProducts event,
    Emitter<ProductState> emit,
  ) async {
    try {
      emit(const ProductLoading());
      final featuredProducts = await _productService.getFeaturedProducts();
      final bestSellingProducts = await _productService.getBestSellingProducts();
      
      emit(ProductLoaded(
        featuredProducts: featuredProducts,
        bestSellingProducts: bestSellingProducts,
      ));
    } catch (e) {
      emit(ProductError('Failed to load featured products: ${e.toString()}'));
    }
  }

  Future<void> _onLoadBestSellingProducts(
    LoadBestSellingProducts event,
    Emitter<ProductState> emit,
  ) async {
    try {
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        final bestSellingProducts = await _productService.getBestSellingProducts();
        
        emit(currentState.copyWith(bestSellingProducts: bestSellingProducts));
      } else {
        emit(const ProductLoading());
        final bestSellingProducts = await _productService.getBestSellingProducts();
        emit(ProductLoaded(bestSellingProducts: bestSellingProducts));
      }
    } catch (e) {
      emit(ProductError('Failed to load best selling products: ${e.toString()}'));
    }
  }

  Future<void> _onLoadProductsByCategory(
    LoadProductsByCategory event,
    Emitter<ProductState> emit,
  ) async {
    try {
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        final categoryProducts = await _productService.getProductsByCategory(event.category);
        
        emit(currentState.copyWith(
          categoryProducts: categoryProducts,
          selectedCategory: event.category,
        ));
      } else {
        emit(const ProductLoading());
        final categoryProducts = await _productService.getProductsByCategory(event.category);
        emit(ProductLoaded(
          categoryProducts: categoryProducts,
          selectedCategory: event.category,
        ));
      }
    } catch (e) {
      emit(ProductError('Failed to load products by category: ${e.toString()}'));
    }
  }

  Future<void> _onSearchProducts(
    SearchProducts event,
    Emitter<ProductState> emit,
  ) async {
    try {
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        final searchResults = await _productService.searchProducts(event.query);
        
        emit(currentState.copyWith(
          searchResults: searchResults,
          searchQuery: event.query,
        ));
      } else {
        emit(const ProductLoading());
        final searchResults = await _productService.searchProducts(event.query);
        emit(ProductLoaded(
          searchResults: searchResults,
          searchQuery: event.query,
        ));
      }
    } catch (e) {
      emit(ProductError('Failed to search products: ${e.toString()}'));
    }
  }

  Future<void> _onLoadAllProducts(
    LoadAllProducts event,
    Emitter<ProductState> emit,
  ) async {
    try {
      emit(const ProductLoading());
      final featuredProducts = await _productService.getFeaturedProducts();
      final bestSellingProducts = await _productService.getBestSellingProducts();
      
      emit(ProductLoaded(
        featuredProducts: featuredProducts,
        bestSellingProducts: bestSellingProducts,
      ));
    } catch (e) {
      emit(ProductError('Failed to load products: ${e.toString()}'));
    }
  }
}

