import 'dart:convert';
import 'package:http/http.dart' as http;

class PetApiService {
  static const String _catFactsBaseUrl = 'https://cat-fact.herokuapp.com';
  static const String _dogApiBaseUrl = 'https://api.thedogapi.com/v1';
  
  // Singleton pattern
  static final PetApiService _instance = PetApiService._internal();
  factory PetApiService() => _instance;
  PetApiService._internal();

  Future<List<Map<String, dynamic>>> getCatFacts() async {
    try {
      final response = await http.get(Uri.parse('$_catFactsBaseUrl/facts'));
      if (response.statusCode == 200) {
        final List<dynamic> facts = json.decode(response.body);
        return facts.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load cat facts');
      }
    } catch (e) {
      throw Exception('Error connecting to cat facts API: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getDogBreeds() async {
    try {
      final response = await http.get(Uri.parse('$_dogApiBaseUrl/breeds'));
      if (response.statusCode == 200) {
        final List<dynamic> breeds = json.decode(response.body);
        return breeds.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load dog breeds');
      }
    } catch (e) {
      throw Exception('Error connecting to dog API: $e');
    }
  }

  Future<String> getRandomDogImage() async {
    try {
      final response = await http.get(Uri.parse('$_dogApiBaseUrl/images/random'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['url'] as String;
      } else {
        throw Exception('Failed to load dog image');
      }
    } catch (e) {
      throw Exception('Error connecting to dog API: $e');
    }
  }
} 