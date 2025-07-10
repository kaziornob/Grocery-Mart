# GroceryMart - Online Grocery Shopping App

A Flutter application for online grocery shopping with clean architecture, state management using Bloc pattern, and local data persistence.

## Features

### Core Features
- **Home Screen**: Display featured grocery products with categories
- **Product Categories**: At least 3 categories (Fruits & Vegetables, Cooking Oil & Ghee, Meat & Fish, Bakery & Snacks, Dairy & Eggs, Beverages)
- **Shopping Cart**: Add/remove items, quantity management, persistent cart data
- **Local Data**: All data stored locally with hardcoded JSON data
- **Cart Persistence**: Cart data persists across app restarts using SharedPreferences

### Technical Features
- **Clean Architecture**: Feature-based folder structure
- **State Management**: Bloc pattern for reactive state management
- **Local Storage**: SharedPreferences for cart persistence
- **Responsive Design**: Works on different screen sizes
- **Error Handling**: Proper error states and loading indicators

## Architecture

The app follows clean architecture principles with the following structure:

```
lib/
├── core/
│   ├── constants/          # App constants and configuration
│   ├── utils/              # Utility classes (colors, theme)
│   └── widgets/            # Shared widgets
├── features/
│   ├── home/
│   │   ├── data/           # Data layer
│   │   ├── domain/         # Business logic (Bloc)
│   │   └── presentation/   # UI layer
│   ├── cart/
│   │   ├── domain/         # Cart business logic
│   │   └── presentation/   # Cart UI
│   └── products/
│       └── ...
├── shared/
│   ├── models/             # Data models (Product, CartItem)
│   └── services/           # Services (ProductService, CartService)
└── main.dart               # App entry point
```

## Models

### Product Model
```dart
class Product {
  final String id;
  final String name;
  final double price;
  final String image;
  final String category;
  final String description;
  final String unit;
  final double rating;
  final int reviewCount;
}
```

### CartItem Model
```dart
class CartItem {
  final Product product;
  final int quantity;
  double get totalPrice => product.price * quantity;
}
```

## State Management

The app uses the Bloc pattern for state management:

- **ProductBloc**: Manages product loading, searching, and categorization
- **CartBloc**: Manages cart operations (add, remove, update quantities)

## Setup Instructions

### Prerequisites
- Flutter SDK (3.24.5 or later)
- Dart SDK (3.5.4 or later)
- Android Studio / VS Code with Flutter extensions

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd grocery_mart
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Dependencies

The app uses the following key dependencies:

```yaml
dependencies:
  flutter_bloc: ^8.1.3          # State management
  equatable: ^2.0.5             # Value equality
  shared_preferences: ^2.2.2    # Local storage
  http: ^1.1.0                  # HTTP requests
  cached_network_image: ^3.3.0  # Image caching
```

## Sample Data

The app includes sample data for 16 products across 6 categories:

- **Fruits & Vegetables**: Fresh Apples, Organic Bananas, Bell Pepper Red, Ginger
- **Cooking Oil & Ghee**: Coconut Oil, Olive Oil
- **Meat & Fish**: Beef Bone, Broiler Chicken
- **Bakery & Snacks**: Multigrain Bread, Chocolate Cookies
- **Dairy & Eggs**: Egg Chicken Red, Whole Milk
- **Beverages**: Diet Coke, Sprite Can, Apple & Grape Juice, Orange Juice

## Usage

### Adding Items to Cart
1. Browse products on the home screen
2. Tap the green "+" button on any product card
3. Items are automatically added to the cart with quantity 1

### Managing Cart
1. Tap the "Cart" tab in the bottom navigation
2. Use "+" and "-" buttons to adjust quantities
3. Tap the delete icon to remove items
4. Cart data persists even after closing the app

### Search and Categories
1. Use the search bar to find specific products
2. Tap on category cards to filter products by category

## Testing

Run the test suite:
```bash
flutter test
```

Run static analysis:
```bash
flutter analyze
```

## Design Reference

The UI design follows the Figma reference with:
- Green primary color scheme (#53B175)
- Clean, modern interface
- Product cards with images and pricing
- Category-based navigation
- Shopping cart with quantity controls

## Future Enhancements

- Product detail screens
- User authentication
- Order history
- Payment integration
- Push notifications
- Product reviews and ratings

## License

This project is created for demonstration purposes.

