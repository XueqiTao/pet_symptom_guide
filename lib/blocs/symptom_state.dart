import 'package:equatable/equatable.dart';
import '../models/symptom.dart';

abstract class SymptomState extends Equatable {
  const SymptomState();

  @override
  List<Object> get props => [];
}

class SymptomInitial extends SymptomState {}

class SymptomLoading extends SymptomState {}

class SymptomLoaded extends SymptomState {
  final List<Symptom> symptoms;
  final PetType selectedPetType;
  final String selectedCategory;
  final String searchQuery;

  const SymptomLoaded({
    required this.symptoms,
    required this.selectedPetType,
    required this.selectedCategory,
    this.searchQuery = '',
  });

  @override
  List<Object> get props => [symptoms, selectedPetType, selectedCategory, searchQuery];

  SymptomLoaded copyWith({
    List<Symptom>? symptoms,
    PetType? selectedPetType,
    String? selectedCategory,
    String? searchQuery,
  }) {
    return SymptomLoaded(
      symptoms: symptoms ?? this.symptoms,
      selectedPetType: selectedPetType ?? this.selectedPetType,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class SymptomError extends SymptomState {
  final String message;

  const SymptomError(this.message);

  @override
  List<Object> get props => [message];
} 