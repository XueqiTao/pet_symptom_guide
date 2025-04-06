import 'package:flutter/material.dart';
import '../models/symptom.dart';
import '../repositories/symptom_repository.dart';

class SymptomDetailScreen extends StatefulWidget {
  final String symptomId;

  const SymptomDetailScreen({super.key, required this.symptomId});

  @override
  State<SymptomDetailScreen> createState() => _SymptomDetailScreenState();
}

class _SymptomDetailScreenState extends State<SymptomDetailScreen> {
  final SymptomRepository _repository = SymptomRepository();
  Symptom? _symptom;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadSymptom();
  }

  Future<void> _loadSymptom() async {
    try {
      final symptom = await _repository.getSymptomById(widget.symptomId);
      setState(() {
        _symptom = symptom;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Error loading symptom: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTabletOrDesktop = screenWidth > 600;
    final horizontalPadding = isTabletOrDesktop ? screenWidth * 0.1 : 16.0;

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Loading...'),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_error != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: Text(
            _error!,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }

    if (_symptom == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Symptom Not Found'),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: const Center(
          child: Text('Symptom information not available'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_symptom!.name),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: _loadSymptom,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                0,
                horizontalPadding,
                120,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRiskLevelCard(_symptom!),
                  const SizedBox(height: 16),
                  _buildDescriptionCard(_symptom!),
                  const SizedBox(height: 16),
                  _buildPossibleCausesCard(_symptom!),
                  const SizedBox(height: 16),
                  _buildNextStepsCard(_symptom!),
                  const SizedBox(height: 16),
                  _buildRelatedSymptomsCard(_symptom!),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SafeArea(
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement emergency vet contact
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Connecting to emergency vet service...'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE57373),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Contact Emergency Vet',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskLevelCard(Symptom symptom) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Color(int.parse('0xFF${symptom.riskLevel.color.substring(1)}')),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                symptom.riskLevel.displayName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),
            const Text(
              'Risk Level',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionCard(Symptom symptom) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(symptom.description),
          ],
        ),
      ),
    );
  }

  Widget _buildPossibleCausesCard(Symptom symptom) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Possible Causes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...symptom.possibleCauses.map((cause) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.blue[300],
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Text(cause)),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildNextStepsCard(Symptom symptom) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recommended Next Steps',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(symptom.nextSteps),
          ],
        ),
      ),
    );
  }

  Widget _buildRelatedSymptomsCard(Symptom symptom) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Related Symptoms',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: symptom.relatedSymptoms.map((relatedSymptom) {
                return Chip(
                  label: Text(relatedSymptom),
                  backgroundColor: Colors.blue[50],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
} 