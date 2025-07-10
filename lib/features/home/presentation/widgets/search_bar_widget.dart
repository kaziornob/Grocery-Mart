import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/product_bloc.dart';
import '../../domain/product_event.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          // Debounce search to avoid too many API calls
          Future.delayed(const Duration(milliseconds: 500), () {
            if (_searchController.text == value) {
              context.read<ProductBloc>().add(SearchProducts(value));
            }
          });
        },
        decoration: InputDecoration(
          hintText: 'Search Store',
          hintStyle: TextStyle(
            color: AppColors.textSecondary,
            fontSize: AppConstants.fontSizeMedium,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.textSecondary,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: () {
                    _searchController.clear();
                    context.read<ProductBloc>().add(const LoadAllProducts());
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingMedium,
            vertical: AppConstants.paddingMedium,
          ),
        ),
      ),
    );
  }
}

