import 'package:flutter/material.dart';

class Symptom {
  final String id;
  final String name;
  final String description;
  final List<String> possibleCauses;
  final RiskLevel riskLevel;
  final String nextSteps;
  final List<String> relatedSymptoms;
  final List<PetType> applicableTo;
  final String category;
  final List<String> commonConditions;
  final String severity;

  Symptom({
    required this.id,
    required this.name,
    required this.description,
    required this.possibleCauses,
    required this.riskLevel,
    required this.nextSteps,
    required this.relatedSymptoms,
    required this.applicableTo,
    required this.category,
    required this.commonConditions,
    required this.severity,
  });

  factory Symptom.fromInfermedica(Map<String, dynamic> json) {
    return Symptom(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      possibleCauses: List<String>.from(json['possible_causes'] ?? []),
      riskLevel: _determineRiskLevel(json['severity'] ?? ''),
      nextSteps: json['next_steps'] ?? 'Consult with a veterinarian for proper diagnosis and treatment.',
      relatedSymptoms: List<String>.from(json['related_symptoms'] ?? []),
      applicableTo: [PetType.dog, PetType.cat], // Default to both since Infermedica is for humans
      category: json['category'] ?? 'General',
      commonConditions: List<String>.from(json['common_conditions'] ?? []),
      severity: json['severity'] ?? 'moderate',
    );
  }

  static RiskLevel _determineRiskLevel(String severity) {
    switch (severity.toLowerCase()) {
      case 'mild':
        return RiskLevel.mild;
      case 'moderate':
        return RiskLevel.moderate;
      case 'severe':
        return RiskLevel.urgent;
      default:
        return RiskLevel.moderate;
    }
  }
}

enum RiskLevel {
  mild,
  moderate,
  urgent;

  String get displayName {
    switch (this) {
      case RiskLevel.mild:
        return 'Mild';
      case RiskLevel.moderate:
        return 'Moderate';
      case RiskLevel.urgent:
        return 'Urgent';
    }
  }

  Color get color {
    switch (this) {
      case RiskLevel.mild:
        return const Color(0xFF1E8E3E); // Green
      case RiskLevel.moderate:
        return const Color(0xFFB45309); // Amber
      case RiskLevel.urgent:
        return const Color(0xFFDC2626); // Red
    }
  }

  String get backgroundColor {
    switch (this) {
      case RiskLevel.mild:
        return '#E6F4EA'; // Light green background
      case RiskLevel.moderate:
        return '#FEF3C7'; // Light amber background
      case RiskLevel.urgent:
        return '#FEE2E2'; // Light red background
    }
  }

  String get textColor {
    switch (this) {
      case RiskLevel.mild:
        return '#1E8E3E'; // Dark green text
      case RiskLevel.moderate:
        return '#B45309'; // Dark amber text
      case RiskLevel.urgent:
        return '#DC2626'; // Dark red text
    }
  }

  String get iconColor {
    return textColor; // Using the same color for icons as text
  }
}

enum PetType {
  dog,
  cat;

  String get displayName {
    switch (this) {
      case PetType.dog:
        return 'Dog';
      case PetType.cat:
        return 'Cat';
    }
  }

  String get icon {
    switch (this) {
      case PetType.dog:
        return '🐕';
      case PetType.cat:
        return '🐈';
    }
  }
} 