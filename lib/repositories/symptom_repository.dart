import '../models/symptom.dart';
import '../services/infermedica_api_service.dart';

class SymptomRepository {
  final InfermedicaApiService _apiService = InfermedicaApiService();
  
  // Singleton pattern
  static final SymptomRepository _instance = SymptomRepository._internal();
  factory SymptomRepository() => _instance;
  SymptomRepository._internal();

  // In-memory cache of symptoms
  final List<Symptom> _symptoms = [
    // DIGESTIVE SYMPTOMS
    Symptom(
      id: '1',
      name: 'Vomiting',
      description: 'Forceful expulsion of stomach contents through the mouth',
      possibleCauses: [
        'Dietary indiscretion',
        'Gastrointestinal infection',
        'Pancreatitis',
        'Kidney disease',
        'Liver disease'
      ],
      riskLevel: RiskLevel.moderate,
      nextSteps: 'If vomiting persists for more than 24 hours or is accompanied by other symptoms like lethargy or diarrhea, seek veterinary care immediately.',
      relatedSymptoms: ['Diarrhea', 'Lethargy', 'Loss of appetite'],
      applicableTo: [PetType.dog, PetType.cat],
      category: 'Digestive',
      commonConditions: ['Gastroenteritis', 'Pancreatitis', 'Kidney Disease'],
      severity: 'moderate',
    ),
    Symptom(
      id: 'dig1',
      name: 'Diarrhea',
      description: 'Loose or watery stools, may contain blood or mucus',
      possibleCauses: [
        'Dietary changes',
        'Parasites',
        'Bacterial infection',
        'Stress',
        'Inflammatory bowel disease'
      ],
      riskLevel: RiskLevel.moderate,
      nextSteps: 'Ensure access to fresh water to prevent dehydration. If diarrhea persists more than 24 hours or contains blood, seek immediate veterinary care.',
      relatedSymptoms: ['Vomiting', 'Lethargy', 'Dehydration'],
      applicableTo: [PetType.dog, PetType.cat],
      category: 'Digestive',
      commonConditions: ['Gastroenteritis', 'Parasites', 'IBD'],
      severity: 'moderate',
    ),
    
    // DOG-SPECIFIC DIGESTIVE
    Symptom(
      id: 'dig2d',
      name: 'Bloating',
      description: 'Swollen or distended abdomen, may be painful to touch',
      possibleCauses: [
        'Gastric dilatation-volvulus (GDV)',
        'Eating too quickly',
        'Gas accumulation',
        'Intestinal blockage'
      ],
      riskLevel: RiskLevel.urgent,
      nextSteps: 'If abdomen is hard and swollen, especially in large breeds, seek emergency veterinary care immediately as this could be life-threatening GDV.',
      relatedSymptoms: ['Retching without vomiting', 'Restlessness', 'Rapid breathing'],
      applicableTo: [PetType.dog],
      category: 'Digestive',
      commonConditions: ['GDV', 'Bloat', 'Intestinal Blockage'],
      severity: 'severe',
    ),

    // CAT-SPECIFIC DIGESTIVE
    Symptom(
      id: 'dig2c',
      name: 'Hairballs',
      description: 'Difficulty passing hairballs, frequent retching',
      possibleCauses: [
        'Excessive grooming',
        'Long hair',
        'Digestive motility issues',
        'Underlying GI problems'
      ],
      riskLevel: RiskLevel.mild,
      nextSteps: 'Regular grooming and specialized hairball prevention food can help. If cat is repeatedly retching without producing hairballs, consult vet.',
      relatedSymptoms: ['Constipation', 'Loss of appetite', 'Lethargy'],
      applicableTo: [PetType.cat],
      category: 'Digestive',
      commonConditions: ['Hairball Obstruction', 'Gastrointestinal Motility Disorder'],
      severity: 'mild',
    ),

    // SKIN SYMPTOMS
    Symptom(
      id: 'skin1d',
      name: 'Itchy Skin (Dogs)',
      description: 'Persistent scratching, biting, or rubbing against furniture',
      possibleCauses: [
        'Allergies',
        'Fleas or ticks',
        'Food sensitivity',
        'Hot spots',
        'Environmental allergens'
      ],
      riskLevel: RiskLevel.mild,
      nextSteps: 'Check for visible parasites, consider an oatmeal bath. If hot spots develop or scratching is severe, consult a veterinarian.',
      relatedSymptoms: ['Hair loss', 'Skin redness', 'Hot spots'],
      applicableTo: [PetType.dog],
      category: 'Skin',
      commonConditions: ['Allergies', 'Flea Infestation', 'Hot Spots'],
      severity: 'mild',
    ),
    Symptom(
      id: 'skin1c',
      name: 'Itchy Skin (Cats)',
      description: 'Excessive grooming, hair loss, or skin irritation',
      possibleCauses: [
        'Allergies',
        'Fleas',
        'Food sensitivity',
        'Stress',
        'Environmental allergens'
      ],
      riskLevel: RiskLevel.mild,
      nextSteps: 'Check for fleas, monitor grooming habits. If excessive grooming continues or bald spots develop, consult a veterinarian.',
      relatedSymptoms: ['Over-grooming', 'Hair loss', 'Skin lesions'],
      applicableTo: [PetType.cat],
      category: 'Skin',
      commonConditions: ['Allergies', 'Flea Infestation', 'Psychogenic Alopecia'],
      severity: 'mild',
    ),

    // MOVEMENT SYMPTOMS
    Symptom(
      id: 'mov1',
      name: 'Limping',
      description: 'Difficulty walking or bearing weight on a limb',
      possibleCauses: [
        'Injury or trauma',
        'Arthritis',
        'Sprains or strains',
        'Joint problems',
        'Nail/paw injury'
      ],
      riskLevel: RiskLevel.moderate,
      nextSteps: 'Rest and restrict activity. If limping persists more than 24 hours or shows signs of severe pain, seek veterinary care.',
      relatedSymptoms: ['Pain', 'Swelling', 'Reluctance to move'],
      applicableTo: [PetType.dog, PetType.cat],
      category: 'Movement',
      commonConditions: ['Arthritis', 'Ligament Injury', 'Joint Disease'],
      severity: 'moderate',
    ),

    // DOG-SPECIFIC MOVEMENT
    Symptom(
      id: 'mov2d',
      name: 'Hip Problems',
      description: 'Difficulty rising, jumping, or climbing stairs',
      possibleCauses: [
        'Hip dysplasia',
        'Arthritis',
        'Injury',
        'Age-related changes'
      ],
      riskLevel: RiskLevel.moderate,
      nextSteps: 'If you notice persistent mobility issues, especially in large breeds or older dogs, consult your vet for evaluation and treatment options.',
      relatedSymptoms: ['Limping', 'Decreased activity', 'Muscle loss in hind legs'],
      applicableTo: [PetType.dog],
      category: 'Movement',
      commonConditions: ['Hip Dysplasia', 'Osteoarthritis', 'Degenerative Joint Disease'],
      severity: 'moderate',
    ),

    // CAT-SPECIFIC MOVEMENT
    Symptom(
      id: 'mov2c',
      name: 'Jumping Difficulty',
      description: 'Reluctance or inability to jump to usual heights',
      possibleCauses: [
        'Arthritis',
        'Joint pain',
        'Muscle weakness',
        'Neurological issues'
      ],
      riskLevel: RiskLevel.moderate,
      nextSteps: 'Monitor changes in jumping behavior. If your cat shows consistent reluctance to jump or signs of pain, consult your veterinarian.',
      relatedSymptoms: ['Limping', 'Reduced activity', 'Changes in litter box habits'],
      applicableTo: [PetType.cat],
      category: 'Movement',
      commonConditions: ['Arthritis', 'Joint Disease', 'Muscle Atrophy'],
      severity: 'moderate',
    ),

    // URGENT SYMPTOMS
    Symptom(
      id: 'urg1',
      name: 'Difficulty Breathing',
      description: 'Labored breathing, wheezing, or respiratory distress',
      possibleCauses: [
        'Heart disease',
        'Respiratory infection',
        'Asthma (cats)',
        'Foreign object',
        'Allergic reaction'
      ],
      riskLevel: RiskLevel.urgent,
      nextSteps: 'This is an emergency - seek immediate veterinary care. Monitor breathing rate and keep pet calm during transport.',
      relatedSymptoms: ['Coughing', 'Blue gums', 'Lethargy'],
      applicableTo: [PetType.dog, PetType.cat],
      category: 'Urgent',
      commonConditions: ['Heart Failure', 'Asthma', 'Respiratory Infection'],
      severity: 'severe',
    ),
  ];

  // Cache for symptoms to avoid unnecessary API calls
  List<Symptom> _cachedSymptoms = [];

  // Get all symptoms
  Future<List<Symptom>> getAllSymptoms() async {
    return List.from(_symptoms);
  }

  // Get symptoms by pet type
  Future<List<Symptom>> getSymptomsByPetType(PetType petType) async {
    return _symptoms.where((symptom) => 
      symptom.applicableTo.contains(petType)
    ).toList();
  }

  // Get symptoms by category
  Future<List<Symptom>> getSymptomsByCategory(String category, PetType petType) async {
    try {
      // If we have cached data, filter it
      if (_cachedSymptoms.isNotEmpty) {
        if (category == 'All Symptoms') {
          return _cachedSymptoms.where((s) => s.applicableTo.contains(petType)).toList();
        }
        return _cachedSymptoms
            .where((s) => s.category == category && s.applicableTo.contains(petType))
            .toList();
      }

      // If no cached data, load from API
      await _loadSymptoms();
      
      if (category == 'All Symptoms') {
        return _cachedSymptoms.where((s) => s.applicableTo.contains(petType)).toList();
      }
      return _cachedSymptoms
          .where((s) => s.category == category && s.applicableTo.contains(petType))
          .toList();
    } catch (e) {
      throw Exception('Failed to load symptoms: $e');
    }
  }

  // Get symptom by ID
  Future<Symptom?> getSymptomById(String id) async {
    try {
      return _symptoms.firstWhere((symptom) => symptom.id == id);
    } catch (e) {
      return null;
    }
  }

  // Search symptoms
  Future<List<Symptom>> searchSymptoms(String query, {required PetType petType}) async {
    try {
      if (_cachedSymptoms.isEmpty) {
        await _loadSymptoms();
      }

      final normalizedQuery = query.toLowerCase();
      return _cachedSymptoms
          .where((symptom) =>
              symptom.applicableTo.contains(petType) &&
              (symptom.name.toLowerCase().contains(normalizedQuery) ||
                  symptom.description.toLowerCase().contains(normalizedQuery) ||
                  symptom.category.toLowerCase().contains(normalizedQuery)))
          .toList();
    } catch (e) {
      throw Exception('Failed to search symptoms: $e');
    }
  }

  // Get symptoms by risk level
  Future<List<Symptom>> getSymptomsByRiskLevel(RiskLevel riskLevel) async {
    return _symptoms.where((symptom) => symptom.riskLevel == riskLevel).toList();
  }

  Future<void> _loadSymptoms() async {
    try {
      // In a real app, this would be an API call
      // For now, we'll use mock data
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
      _cachedSymptoms = _getMockSymptoms();
    } catch (e) {
      throw Exception('Failed to load symptoms from API: $e');
    }
  }

  List<Symptom> _getMockSymptoms() {
    return List.from(_symptoms);  // Return a copy of the existing symptoms list
  }
} 