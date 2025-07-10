import '../models/product.dart';

class ProductService {
  static final ProductService _instance = ProductService._internal();
  factory ProductService() => _instance;
  ProductService._internal();

  // Sample product data
  final List<Product> _products = [
    // Fruits & Vegetables
    const Product(
      id: '1',
      name: 'Fresh Apples',
      price: 2.99,
      image: 'assets/images/apples.png',
      category: 'Fruits & Vegetables',
      description: 'Fresh red apples, perfect for snacking or baking.',
      unit: 'kg',
      rating: 4.5,
      reviewCount: 25,
    ),
    const Product(
      id: '2',
      name: 'Organic Bananas',
      price: 1.99,
      image: 'assets/images/bananas.png',
      category: 'Fruits & Vegetables',
      description: 'Organic bananas, rich in potassium and vitamins.',
      unit: 'kg',
      rating: 4.3,
      reviewCount: 18,
    ),
    const Product(
      id: '3',
      name: 'Bell Pepper Red',
      price: 3.49,
      image: 'assets/images/bell_pepper.png',
      category: 'Fruits & Vegetables',
      description: 'Fresh red bell peppers, great for cooking.',
      unit: 'kg',
      rating: 4.7,
      reviewCount: 32,
    ),
    const Product(
      id: '4',
      name: 'Ginger',
      price: 4.99,
      image: 'assets/images/ginger.png',
      category: 'Fruits & Vegetables',
      description: 'Fresh ginger root, perfect for cooking and tea.',
      unit: 'kg',
      rating: 4.6,
      reviewCount: 15,
    ),

    // Cooking Oil & Ghee
    const Product(
      id: '5',
      name: 'Coconut Oil',
      price: 8.99,
      image: 'assets/images/coconut_oil.png',
      category: 'Cooking Oil & Ghee',
      description: 'Pure coconut oil for healthy cooking.',
      unit: 'L',
      rating: 4.8,
      reviewCount: 42,
    ),
    const Product(
      id: '6',
      name: 'Olive Oil',
      price: 12.99,
      image: 'assets/images/olive_oil.png',
      category: 'Cooking Oil & Ghee',
      description: 'Extra virgin olive oil, cold pressed.',
      unit: 'L',
      rating: 4.9,
      reviewCount: 67,
    ),

    // Meat & Fish
    const Product(
      id: '7',
      name: 'Beef Bone',
      price: 15.99,
      image: 'assets/images/beef_bone.png',
      category: 'Meat & Fish',
      description: 'Fresh beef bone, perfect for making broth.',
      unit: 'kg',
      rating: 4.4,
      reviewCount: 28,
    ),
    const Product(
      id: '8',
      name: 'Broiler Chicken',
      price: 12.99,
      image: 'assets/images/chicken.png',
      category: 'Meat & Fish',
      description: 'Fresh broiler chicken, farm raised.',
      unit: 'kg',
      rating: 4.6,
      reviewCount: 35,
    ),

    // Bakery & Snacks
    const Product(
      id: '9',
      name: 'Multigrain Bread',
      price: 3.99,
      image: 'assets/images/bread.png',
      category: 'Bakery & Snacks',
      description: 'Healthy multigrain bread, freshly baked.',
      unit: 'piece',
      rating: 4.5,
      reviewCount: 22,
    ),
    const Product(
      id: '10',
      name: 'Chocolate Cookies',
      price: 5.99,
      image: 'assets/images/cookies.png',
      category: 'Bakery & Snacks',
      description: 'Delicious chocolate chip cookies.',
      unit: 'pack',
      rating: 4.7,
      reviewCount: 45,
    ),

    // Dairy & Eggs
    const Product(
      id: '11',
      name: 'Egg Chicken Red',
      price: 4.99,
      image: 'assets/images/eggs.png',
      category: 'Dairy & Eggs',
      description: 'Fresh chicken eggs, farm raised.',
      unit: 'dozen',
      rating: 4.8,
      reviewCount: 38,
    ),
    const Product(
      id: '12',
      name: 'Whole Milk',
      price: 3.49,
      image: 'assets/images/milk.png',
      category: 'Dairy & Eggs',
      description: 'Fresh whole milk, rich in calcium.',
      unit: 'L',
      rating: 4.6,
      reviewCount: 29,
    ),

    // Beverages
    const Product(
      id: '13',
      name: 'Diet Coke',
      price: 1.99,
      image: 'assets/images/diet_coke.png',
      category: 'Beverages',
      description: 'Refreshing diet cola drink.',
      unit: 'can',
      rating: 4.2,
      reviewCount: 56,
    ),
    const Product(
      id: '14',
      name: 'Sprite Can',
      price: 1.99,
      image: 'assets/images/sprite.png',
      category: 'Beverages',
      description: 'Crisp lemon-lime soda.',
      unit: 'can',
      rating: 4.4,
      reviewCount: 41,
    ),
    const Product(
      id: '15',
      name: 'Apple & Grape Juice',
      price: 4.99,
      image: 'assets/images/juice.png',
      category: 'Beverages',
      description: 'Natural apple and grape juice blend.',
      unit: 'bottle',
      rating: 4.7,
      reviewCount: 33,
    ),
    const Product(
      id: '16',
      name: 'Orange Juice',
      price: 3.99,
      image: 'assets/images/orange_juice.png',
      category: 'Beverages',
      description: 'Fresh squeezed orange juice.',
      unit: 'bottle',
      rating: 4.5,
      reviewCount: 27,
    ),
  ];

  // Get all products
  Future<List<Product>> getAllProducts() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _products;
  }

  // Get products by category
  Future<List<Product>> getProductsByCategory(String category) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _products.where((product) => product.category == category).toList();
  }

  // Get featured products (first 6 products)
  Future<List<Product>> getFeaturedProducts() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _products.take(6).toList();
  }

  // Get best selling products (products with high ratings)
  Future<List<Product>> getBestSellingProducts() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final bestSelling = _products.where((product) => product.rating >= 4.5).toList();
    bestSelling.sort((a, b) => b.rating.compareTo(a.rating));
    return bestSelling.take(6).toList();
  }

  // Search products
  Future<List<Product>> searchProducts(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (query.isEmpty) return _products;
    
    return _products.where((product) =>
        product.name.toLowerCase().contains(query.toLowerCase()) ||
        product.category.toLowerCase().contains(query.toLowerCase())).toList();
  }

  // Get product by ID
  Future<Product?> getProductById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get all categories
  List<String> getCategories() {
    return _products.map((product) => product.category).toSet().toList();
  }
}

