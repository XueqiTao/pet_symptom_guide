import 'dart:convert';
import 'package:http/http.dart' as http;

class InfermedicaApiService {
  static const String _baseUrl = 'https://api.infermedica.com/v3';
  static const String _appId = 'YOUR_APP_ID'; // You'll need to replace this with your actual App ID
  static const String _appKey = 'YOUR_APP_KEY'; // You'll need to replace this with your actual App Key
  
  // Singleton pattern
  static final InfermedicaApiService _instance = InfermedicaApiService._internal();
  factory InfermedicaApiService() => _instance;
  InfermedicaApiService._internal();

  Map<String, String> get _headers => {
    'App-Id': _appId,
    'App-Key': _appKey,
    'Content-Type': 'application/json',
  };

  Future<List<Map<String, dynamic>>> getSymptoms() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/symptoms'),
        headers: _headers,
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> symptoms = json.decode(response.body);
        return symptoms.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load symptoms: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error connecting to Infermedica API: $e');
    }
  }

  Future<Map<String, dynamic>> getSymptomDetails(String symptomId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/symptoms/$symptomId'),
        headers: _headers,
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load symptom details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error connecting to Infermedica API: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getConditions() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/conditions'),
        headers: _headers,
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> conditions = json.decode(response.body);
        return conditions.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load conditions: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error connecting to Infermedica API: $e');
    }
  }

  Future<Map<String, dynamic>> getConditionDetails(String conditionId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/conditions/$conditionId'),
        headers: _headers,
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load condition details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error connecting to Infermedica API: $e');
    }
  }
} 