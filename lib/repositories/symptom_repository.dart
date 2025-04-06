import '../models/symptom.dart';
import '../services/pet_api_service.dart';

class SymptomRepository {
  final PetApiService _apiService = PetApiService();
  
  // Singleton pattern
  static final SymptomRepository _instance = SymptomRepository._internal();
  factory SymptomRepository() => _instance;
  SymptomRepository._internal();

  // In-memory cache of symptoms and additional pet data
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
    ),
  ];

  // Cache for API data
  List<Map<String, dynamic>>? _catFacts;
  List<Map<String, dynamic>>? _dogBreeds;
  String? _currentDogImage;

  // Get all symptoms with enriched data
  Future<List<Symptom>> getAllSymptoms() async {
    await _loadApiData();
    return List.from(_symptoms);
  }

  // Get symptoms by pet type with enriched data
  Future<List<Symptom>> getSymptomsByPetType(PetType petType) async {
    await _loadApiData();
    return _symptoms.where((symptom) => 
      symptom.applicableTo.contains(petType)
    ).toList();
  }

  // Get symptoms by category with enriched data
  Future<List<Symptom>> getSymptomsByCategory(String category, PetType petType) async {
    await _loadApiData();
    if (category == 'All Symptoms') {
      return getSymptomsByPetType(petType);
    }
    
    return _symptoms.where((symptom) => 
      symptom.applicableTo.contains(petType) &&
      _getCategoryForSymptom(symptom.id) == category
    ).toList();
  }

  String _getCategoryForSymptom(String id) {
    if (id.startsWith('dig')) return 'Digestive';
    if (id.startsWith('skin')) return 'Skin';
    if (id.startsWith('mov')) return 'Movement';
    if (id.startsWith('urg')) return 'Urgent';
    return 'All Symptoms';
  }

  // Get symptom by ID with enriched data
  Future<Symptom?> getSymptomById(String id) async {
    await _loadApiData();
    try {
      return _symptoms.firstWhere((symptom) => symptom.id == id);
    } catch (e) {
      return null;
    }
  }

  // Search symptoms with enriched data
  Future<List<Symptom>> searchSymptoms(String query, {PetType? petType}) async {
    await _loadApiData();
    final lowercaseQuery = query.toLowerCase();
    return _symptoms.where((symptom) =>
      (petType == null || symptom.applicableTo.contains(petType)) &&
      (symptom.name.toLowerCase().contains(lowercaseQuery) ||
       symptom.description.toLowerCase().contains(lowercaseQuery))
    ).toList();
  }

  // Load data from APIs
  Future<void> _loadApiData() async {
    try {
      // Load cat facts if not cached
      _catFacts ??= await _apiService.getCatFacts();
      
      // Load dog breeds if not cached
      _dogBreeds ??= await _apiService.getDogBreeds();
      
      // Get a new random dog image
      _currentDogImage = await _apiService.getRandomDogImage();
    } catch (e) {
      print('Error loading API data: $e');
      // Continue with local data if API fails
    }
  }

  // Get additional pet information
  Map<String, dynamic> getAdditionalPetInfo(PetType petType) {
    if (petType == PetType.cat && _catFacts != null) {
      return {
        'facts': _catFacts,
        'title': 'Cat Facts',
      };
    } else if (petType == PetType.dog && _dogBreeds != null) {
      return {
        'breeds': _dogBreeds,
        'currentImage': _currentDogImage,
        'title': 'Dog Breeds',
      };
    }
    return {};
  }
} 