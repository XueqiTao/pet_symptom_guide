class Symptom {
  final String id;
  final String name;
  final String description;
  final List<String> possibleCauses;
  final RiskLevel riskLevel;
  final String nextSteps;
  final List<String> relatedSymptoms;
  final List<PetType> applicableTo;

  Symptom({
    required this.id,
    required this.name,
    required this.description,
    required this.possibleCauses,
    required this.riskLevel,
    required this.nextSteps,
    required this.relatedSymptoms,
    required this.applicableTo,
  });
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

  String get color {
    switch (this) {
      case RiskLevel.mild:
        return '#4CAF50'; // Green
      case RiskLevel.moderate:
        return '#FFC107'; // Yellow
      case RiskLevel.urgent:
        return '#F44336'; // Red
    }
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