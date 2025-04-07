import 'package:flutter/material.dart';
import '../models/symptom.dart';
import '../repositories/symptom_repository.dart';

class SymptomListScreen extends StatefulWidget {
  const SymptomListScreen({super.key});

  @override
  State<SymptomListScreen> createState() => _SymptomListScreenState();
}

class _SymptomListScreenState extends State<SymptomListScreen> {
  final SymptomRepository _repository = SymptomRepository();
  final TextEditingController _searchController = TextEditingController();
  List<Symptom> _symptoms = [];
  PetType _selectedPetType = PetType.dog;
  String _selectedCategory = 'All Symptoms';
  bool _isLoading = false;
  String? _error;

  final List<String> _categories = [
    'All Symptoms',
    'Digestive',
    'Skin',
    'Movement',
    'Urgent',
  ];

  @override
  void initState() {
    super.initState();
    _loadSymptoms();
  }

  Future<void> _loadSymptoms() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final symptoms = await _repository.getSymptomsByCategory(
        _selectedCategory,
        _selectedPetType,
      );
      setState(() {
        _symptoms = symptoms;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Error loading symptoms: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _searchSymptoms(String query) async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final symptoms = await _repository.searchSymptoms(
        query,
        petType: _selectedPetType,
      );
      setState(() {
        _symptoms = symptoms;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Error searching symptoms: $e';
        _isLoading = false;
      });
    }
  }

  void _changePetType(PetType type) {
    setState(() {
      _selectedPetType = type;
      _searchController.clear();
    });
    _loadSymptoms();
  }

  void _changeCategory(String category) {
    setState(() {
      _selectedCategory = category;
      _searchController.clear();
    });
    _loadSymptoms();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTabletOrDesktop = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pet Symptom Guide',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isTabletOrDesktop ? screenWidth * 0.1 : 16.0,
              vertical: 16.0,
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search symptoms...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: _searchSymptoms,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isTabletOrDesktop ? screenWidth * 0.1 : 16.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final category = _categories[index];
                        final isSelected = category == _selectedCategory;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Text(category),
                            selected: isSelected,
                            onSelected: (selected) {
                              if (selected) {
                                _changeCategory(category);
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
                ToggleButtons(
                  isSelected: [
                    _selectedPetType == PetType.dog,
                    _selectedPetType == PetType.cat,
                  ],
                  onPressed: (index) {
                    _changePetType(index == 0 ? PetType.dog : PetType.cat);
                  },
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(PetType.dog.icon),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(PetType.cat.icon),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                _error!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          if (_isLoading)
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          else
            Expanded(
              child: RefreshIndicator(
                onRefresh: _loadSymptoms,
                child: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isTabletOrDesktop ? screenWidth * 0.1 : 16.0,
                      ),
                      sliver: isTabletOrDesktop
                          ? SliverGrid(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: screenWidth > 1200 ? 3 : 2,
                                childAspectRatio: 2,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (context, index) => _buildSymptomCard(_symptoms[index]),
                                childCount: _symptoms.length,
                              ),
                            )
                          : SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: _buildSymptomCard(_symptoms[index]),
                                ),
                                childCount: _symptoms.length,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSymptomCard(Symptom symptom) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          '/symptom_details',
          arguments: symptom,
        ),
        child: Container(
          height: 160,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      symptom.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: symptom.riskLevel.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      symptom.riskLevel.displayName,
                      style: TextStyle(
                        color: symptom.riskLevel.color,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Text(
                  symptom.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey[600],
                    height: 1.3,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 8,
                      children: symptom.applicableTo.map((type) => 
                        Text(
                          type.icon,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ).toList(),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      '/symptom_details',
                      arguments: symptom,
                    ),
                    icon: const Icon(Icons.info_outline, size: 18),
                    label: const Text('More Info'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColor,
                      side: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      minimumSize: const Size(0, 32),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
} 