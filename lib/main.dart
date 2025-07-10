import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/utils/app_theme.dart';
import 'features/home/domain/product_bloc.dart';
import 'features/cart/domain/cart_bloc.dart';
import 'features/home/domain/product_event.dart';
import 'features/cart/domain/cart_event.dart';
import 'features/home/presentation/home_screen.dart';

void main() {
  runApp(const GroceryMartApp());
}

class GroceryMartApp extends StatelessWidget {
  const GroceryMartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc()..add(const LoadAllProducts()),
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc()..add(const LoadCart()),
        ),
      ],
      child: MaterialApp(
        title: 'GroceryMart',
        theme: AppTheme.lightTheme,
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

