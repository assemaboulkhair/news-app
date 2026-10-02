import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;
  final bool imageOnRight;
  final String viewAllText;

  const CategoryCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.onTap,
    required this.viewAllText,
    this.imageOnRight = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        height: 190,
        margin: const EdgeInsets.only(bottom: 16),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: const Color(0xFF131B2E),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.05),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // 1. صورة الـ 3D
            Positioned(
              top: 10,
              bottom: 10,
              left: imageOnRight ? 16 : null,
              right: imageOnRight ? null : 16,
              width: 140,
              child: Image.asset(
                imageUrl,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.category_outlined,
                      size: 36,
                      color: Colors.white38,
                    ),
                  );
                },
              ),
            ),

            // 2. المحتوى (تسنتر الكلمة فوق الزرار)
            Positioned(
              top: 0,
              bottom: 0,
              left: imageOnRight ? null : 20,
              right: imageOnRight ? 20 : null,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center, // يجعل العنوان متسنتر مع الزرار
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildViewAllButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildViewAllButton() {
    const double pillWidth = 145;
    const double pillHeight = 44;
    const double circleSize = 44;
    const double circleOverlap = 4;

    return SizedBox(
      height: circleSize,
      width: pillWidth,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            clipBehavior: Clip.none,
            alignment:
            imageOnRight ? Alignment.centerRight : Alignment.centerLeft,
            children: [
              Container(
                width: pillWidth,
                height: pillHeight,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.15),
                  ),
                ),
              ),
              Positioned(
                left: imageOnRight ? null : circleOverlap + circleSize,
                right: imageOnRight ? circleOverlap + circleSize : null,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Text(
                    viewAllText,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: imageOnRight ? null : 0,
                right: imageOnRight ? 0 : null,
                child: IgnorePointer(
                  child: Container(
                    width: circleSize,
                    height: circleSize,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF1E293B),
                    ),
                    child: Icon(
                      imageOnRight
                          ? Icons.chevron_right
                          : Icons.chevron_left,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}