import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/symptom.dart';
import '../blocs/symptom_bloc.dart';
import '../blocs/symptom_state.dart';
import '../blocs/symptom_event.dart';
import 'symptom_detail_screen.dart';

class SymptomListScreen extends StatelessWidget {
  const SymptomListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pet Symptom Guide',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<SymptomBloc, SymptomState>(
        builder: (context, state) {
          if (state is SymptomLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (state is SymptomError) {
            return Center(child: Text(state.message));
          }
          
          if (state is SymptomLoaded) {
            return Column(
              children: [
                _buildSearchBar(context, state),
                _buildFilters(context, state),
                Expanded(
                  child: _buildSymptomList(context, state),
                ),
              ],
            );
          }
          
          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, SymptomLoaded state) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search symptoms...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),
        onChanged: (query) {
          context.read<SymptomBloc>().add(SearchSymptoms(query));
        },
      ),
    );
  }

  Widget _buildFilters(BuildContext context, SymptomLoaded state) {
    final categories = ['All Symptoms', 'Digestive', 'Skin', 'Movement', 'Urgent'];
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 48,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = category == state.selectedCategory;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          context.read<SymptomBloc>().add(
                            FilterSymptomsByCategory(
                              category: category,
                              petType: state.selectedPetType,
                            ),
                          );
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
              state.selectedPetType == PetType.dog,
              state.selectedPetType == PetType.cat,
            ],
            onPressed: (index) {
              context.read<SymptomBloc>().add(
                ChangePetType(index == 0 ? PetType.dog : PetType.cat),
              );
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
    );
  }

  Widget _buildSymptomList(BuildContext context, SymptomLoaded state) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: state.symptoms.length,
      itemBuilder: (context, index) {
        final symptom = state.symptoms[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SymptomDetailScreen(symptom: symptom),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Text(
                    symptom.description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      ...symptom.applicableTo.map((type) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(type.icon),
                      )),
                      const Spacer(),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SymptomDetailScreen(
                                symptom: symptom,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.info_outline),
                        label: const Text('More Info'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
} 