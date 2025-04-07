import 'package:flutter/material.dart';
import '../models/symptom.dart';

class SymptomDetailScreen extends StatelessWidget {
  final Symptom symptom;

  const SymptomDetailScreen({
    super.key,
    required this.symptom,
  });

  Widget _buildSection({
    required String title,
    required Widget content,
    Color? backgroundColor,
    IconData? icon,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: const Color(0xFF00856A),
                  size: 20,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          content,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          symptom.name,
          style: const TextStyle(
            color: Color(0xFF111827),
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Color(0xFF111827),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Risk Level Indicator
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Color(int.parse(
                    symptom.riskLevel.backgroundColor.substring(1),
                    radix: 16,
                  ) + 0xFF000000),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Color(int.parse(
                      symptom.riskLevel.textColor.substring(1),
                      radix: 16,
                    ) + 0xFF000000).withOpacity(0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_rounded,
                      color: Color(int.parse(
                        symptom.riskLevel.textColor.substring(1),
                        radix: 16,
                      ) + 0xFF000000),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Risk Level: ${symptom.riskLevel.displayName}',
                      style: TextStyle(
                        color: Color(int.parse(
                          symptom.riskLevel.textColor.substring(1),
                          radix: 16,
                        ) + 0xFF000000),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Description
              _buildSection(
                title: 'Description',
                icon: Icons.description_outlined,
                backgroundColor: Colors.white,
                content: Text(
                  symptom.description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF374151),
                  ),
                ),
              ),

              // Possible Causes
              _buildSection(
                title: 'Possible Causes',
                icon: Icons.help_outline,
                backgroundColor: Colors.white,
                content: Column(
                  children: symptom.possibleCauses.map((cause) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          margin: const EdgeInsets.only(top: 8, right: 8),
                          decoration: const BoxDecoration(
                            color: Color(0xFF00856A),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            cause,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF374151),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ),
              ),

              // Next Steps
              _buildSection(
                title: 'Recommended Next Steps',
                icon: Icons.assignment_outlined,
                backgroundColor: const Color(0xFFF3FAFA),
                content: Text(
                  symptom.nextSteps,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF374151),
                  ),
                ),
              ),

              // Common Conditions
              _buildSection(
                title: 'Common Conditions',
                icon: Icons.medical_services_outlined,
                backgroundColor: Colors.white,
                content: Column(
                  children: symptom.commonConditions.map((condition) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          margin: const EdgeInsets.only(top: 8, right: 8),
                          decoration: const BoxDecoration(
                            color: Color(0xFF00856A),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            condition,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF374151),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ),
              ),

              // Related Symptoms
              _buildSection(
                title: 'Related Symptoms',
                icon: Icons.link,
                backgroundColor: Colors.white,
                content: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: symptom.relatedSymptoms.map((related) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3FAFA),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFFE5E7EB),
                      ),
                    ),
                    child: Text(
                      related,
                      style: const TextStyle(
                        color: Color(0xFF00856A),
                        fontSize: 14,
                      ),
                    ),
                  )).toList(),
                ),
              ),

              // Applicable To
              _buildSection(
                title: 'Applicable To',
                icon: Icons.pets,
                backgroundColor: Colors.white,
                content: Row(
                  children: symptom.applicableTo.map((type) => Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Row(
                      children: [
                        Text(
                          type.icon,
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          type.displayName,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF374151),
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ),
              ),
              const SizedBox(height: 80), // Space for bottom bar
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Emergency contact feature coming soon'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(
                  Icons.emergency,
                  color: Colors.white,
                ),
                label: const Text(
                  'Emergency Contact',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDC2626),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
} 