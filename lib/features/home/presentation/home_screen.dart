import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../domain/product_bloc.dart';
import '../domain/product_state.dart';
import '../domain/product_event.dart';
import '../../cart/presentation/cart_screen.dart';
import '../../cart/domain/cart_bloc.dart';
import '../../cart/domain/cart_state.dart';
import 'widgets/product_card.dart';
import 'widgets/category_card.dart';
import 'widgets/search_bar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: _selectedIndex == 0 ? _buildHomeContent() : const CartScreen(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHomeContent() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: AppConstants.paddingLarge),
            const SearchBarWidget(),
            const SizedBox(height: AppConstants.paddingLarge),
            _buildExclusiveOfferSection(),
            const SizedBox(height: AppConstants.paddingLarge),
            _buildBestSellingSection(),
            const SizedBox(height: AppConstants.paddingLarge),
            _buildGroceriesSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Image.asset(
          'assets/images/apples.png',
          width: 30,
          height: 30,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.shopping_cart, size: 30, color: AppColors.primaryGreen);
          },
        ),
        const SizedBox(width: AppConstants.paddingSmall),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'GroceryMart',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.primaryGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildExclusiveOfferSection() {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Exclusive Offer',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See all',
                      style: TextStyle(color: AppColors.primaryGreen),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.paddingMedium),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.featuredProducts.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: AppConstants.paddingMedium),
                      child: ProductCard(product: state.featuredProducts[index]),
                    );
                  },
                ),
              ),
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildBestSellingSection() {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Best Selling',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See all',
                      style: TextStyle(color: AppColors.primaryGreen),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.paddingMedium),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.bestSellingProducts.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: AppConstants.paddingMedium),
                      child: ProductCard(product: state.bestSellingProducts[index]),
                    );
                  },
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildGroceriesSection() {
    final categories = [
      {'name': 'Fruits & Vegetables', 'color': AppColors.fruitVegetableColor, 'image': 'assets/images/apples.png'},
      {'name': 'Cooking Oil & Ghee', 'color': AppColors.cookingOilColor, 'image': 'assets/images/coconut_oil.png'},
      {'name': 'Meat & Fish', 'color': AppColors.meatFishColor, 'image': 'assets/images/beef_bone.png'},
      {'name': 'Bakery & Snacks', 'color': AppColors.bakeryColor, 'image': 'assets/images/bread.png'},
      {'name': 'Dairy & Eggs', 'color': AppColors.dairyColor, 'image': 'assets/images/eggs.png'},
      {'name': 'Beverages', 'color': AppColors.beverageColor, 'image': 'assets/images/sprite.png'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Groceries',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'See all',
                style: TextStyle(color: AppColors.primaryGreen),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.paddingMedium),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2.5,
            crossAxisSpacing: AppConstants.paddingMedium,
            mainAxisSpacing: AppConstants.paddingMedium,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return CategoryCard(
              name: category['name'] as String,
              color: category['color'] as Color,
              imagePath: category['image'] as String,
              onTap: () {
                context.read<ProductBloc>().add(LoadProductsByCategory(category['name'] as String));
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, cartState) {
        int cartItemCount = 0;
        if (cartState is CartLoaded) {
          cartItemCount = cartState.itemCount;
        }

        return BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primaryGreen,
          unselectedItemColor: AppColors.textSecondary,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  const Icon(Icons.shopping_cart),
                  if (cartItemCount > 0)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: AppColors.orangeAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '$cartItemCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              label: 'Cart',
            ),
          ],
        );
      },
    );
  }
}

