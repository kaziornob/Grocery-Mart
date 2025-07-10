import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

class CategoryCard extends StatelessWidget {
  final String name;
  final Color color;
  final String imagePath;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.name,
    required this.color,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          child: Row(
            children: [
              // Category Image
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: color.withOpacity(0.2),
                        child: Icon(
                          Icons.category,
                          color: color,
                          size: 25,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: AppConstants.paddingSmall),
              
              // Category Name
              Expanded(
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: color.withOpacity(0.8),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

