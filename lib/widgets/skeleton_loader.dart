import 'package:flutter/material.dart';
import '../utils/constants.dart';

class PropertyCardSkeleton extends StatelessWidget {
  const PropertyCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.shimmerBase,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildShimmerLine(width: 0.6, height: 16),
                const SizedBox(height: 8),
                _buildShimmerLine(width: 0.4, height: 12),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildShimmerLine(width: 0.12, height: 14),
                    const SizedBox(width: 12),
                    _buildShimmerLine(width: 0.1, height: 14),
                    const SizedBox(width: 12),
                    _buildShimmerLine(width: 0.15, height: 14),
                    const SizedBox(width: 12),
                    _buildShimmerLine(width: 0.12, height: 14),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerLine({double width = 1.0, double height = 14}) {
    return Container(
      width: width == 1.0 ? double.infinity : null,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.shimmerBase,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

class DetailSkeleton extends StatelessWidget {
  const DetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 300,
            width: double.infinity,
            color: AppColors.shimmerBase,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLine(0.7, 22),
                const SizedBox(height: 4),
                _buildLine(0.4, 14),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(4, (_) => Column(
                    children: [
                      _buildCircle(48),
                      const SizedBox(height: 8),
                      _buildLine(0.4, 12),
                    ],
                  )),
                ),
                const SizedBox(height: 24),
                _buildLine(0.3, 18),
                const SizedBox(height: 12),
                _buildLine(1.0, 14),
                _buildLine(0.9, 14),
                _buildLine(0.8, 14),
                const SizedBox(height: 24),
                _buildLine(0.3, 18),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(4, (_) => _buildLine(0.2, 32)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLine(double width, double height) {
    return Container(
      width: width == 1.0 ? double.infinity : null,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.shimmerBase,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildCircle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: AppColors.shimmerBase,
        shape: BoxShape.circle,
      ),
    );
  }
}

class FilterChipsSkeleton extends StatelessWidget {
  const FilterChipsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Container(
            width: [80, 100, 90, 70, 70, 75][index].toDouble(),
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: AppColors.shimmerBase,
              borderRadius: BorderRadius.circular(20),
            ),
          );
        },
      ),
    );
  }
}
