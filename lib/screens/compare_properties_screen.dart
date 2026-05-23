import 'package:flutter/material.dart';
import '../utils/constants.dart';

class ComparePropertiesScreen extends StatelessWidget {
  const ComparePropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.close_rounded, color: AppColors.textPrimary),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Compare Properties',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.deepGreen.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      '2 selected',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.deepGreen,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _buildComparisonTable(),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: AppColors.deepGreen,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.deepGreen.withValues(alpha: 0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Text(
                        'Contact Both Landlords',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonTable() {
    final properties = [
      {
        'name': 'Apartment in Bastos',
        'color': 0xFF0F6B4B,
        'price': '150,000 XAF',
        'type': 'Apartment',
        'beds': '2',
        'baths': '1',
        'water': 'Yes',
        'electricity': 'Stable',
        'parking': 'Yes',
        'wifi': 'Yes',
        'furnished': 'Yes',
        'size': '85 m²',
      },
      {
        'name': 'Studio in Bonanjo',
        'color': 0xFF1A8F62,
        'price': '80,000 XAF',
        'type': 'Studio',
        'beds': '1',
        'baths': '1',
        'water': 'Yes',
        'electricity': 'Unstable',
        'parking': 'No',
        'wifi': 'Yes',
        'furnished': 'No',
        'size': '45 m²',
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              children: [
                const SizedBox(width: 100),
                ...properties.map((p) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Column(
                          children: [
                            Container(
                              height: 80,
                              decoration: BoxDecoration(
                                color: Color(p['color'] as int),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Icon(Icons.home_rounded,
                                    size: 32, color: Colors.white.withValues(alpha: 0.5)),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              p['name'] as String,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
          const Divider(height: 32),
          ..._buildCompareRow('Price', properties, 'price'),
          _buildDivider(),
          ..._buildCompareRow('Type', properties, 'type'),
          _buildDivider(),
          ..._buildCompareRow('Bedrooms', properties, 'beds'),
          _buildDivider(),
          ..._buildCompareRow('Bathrooms', properties, 'baths'),
          _buildDivider(),
          ..._buildCompareRow('Water', properties, 'water'),
          _buildDivider(),
          ..._buildCompareRow('Electricity', properties, 'electricity'),
          _buildDivider(),
          ..._buildCompareRow('Parking', properties, 'parking'),
          _buildDivider(),
          ..._buildCompareRow('WiFi', properties, 'wifi'),
          _buildDivider(),
          ..._buildCompareRow('Furnished', properties, 'furnished'),
          _buildDivider(),
          ..._buildCompareRow('Size', properties, 'size'),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      color: Colors.grey.withValues(alpha: 0.1),
    );
  }

  List<Widget> _buildCompareRow(
      String label, List<Map<String, dynamic>> properties, String key) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              child: Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            ...properties.map((p) {
              final isPositive = p[key] == 'Yes' || p[key] == 'Stable';
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    p[key] as String,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isPositive ? AppColors.deepGreen : AppColors.textPrimary,
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    ];
  }
}
