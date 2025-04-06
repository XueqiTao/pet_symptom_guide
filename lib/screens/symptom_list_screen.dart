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

  Widget _buildAdditionalInfo() {
    final petInfo = _repository.getAdditionalPetInfo(_selectedPetType);
    if (petInfo.isEmpty) return const SizedBox.shrink();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              petInfo['title'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            if (_selectedPetType == PetType.dog && petInfo['currentImage'] != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  petInfo['currentImage'],
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            if (_selectedPetType == PetType.cat && petInfo['facts'] != null)
              ...(petInfo['facts'] as List).take(3).map((fact) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  "• ${fact['text'] ?? 'No fact available'}",
                  style: const TextStyle(fontSize: 14),
                ),
              )),
          ],
        ),
      ),
    );
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
                      sliver: SliverToBoxAdapter(
                        child: _buildAdditionalInfo(),
                      ),
                    ),
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
                                (context, index) => _buildSymptomCard(_symptoms[index]),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPetType.index,
        onTap: (index) => _changePetType(PetType.values[index]),
        items: [
          BottomNavigationBarItem(
            icon: Text(
              '🐕',
              style: TextStyle(
                fontSize: isTabletOrDesktop ? 32 : 24,
              ),
            ),
            label: PetType.dog.displayName,
          ),
          BottomNavigationBarItem(
            icon: Text(
              '🐈',
              style: TextStyle(
                fontSize: isTabletOrDesktop ? 32 : 24,
              ),
            ),
            label: PetType.cat.displayName,
          ),
        ],
      ),
    );
  }

  Widget _buildSymptomCard(Symptom symptom) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          symptom.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          symptom.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: Color(int.parse(
                '0xFF${symptom.riskLevel.color.substring(1)}')),
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
        onTap: () {
          Navigator.pushNamed(
            context,
            '/symptom-detail',
            arguments: symptom.id,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
} 