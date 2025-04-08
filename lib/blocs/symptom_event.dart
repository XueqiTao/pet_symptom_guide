import 'package:equatable/equatable.dart';
import '../models/symptom.dart';

abstract class SymptomEvent extends Equatable {
  const SymptomEvent();

  @override
  List<Object> get props => [];
}

class LoadSymptoms extends SymptomEvent {}

class SearchSymptoms extends SymptomEvent {
  final String query;
  
  const SearchSymptoms(this.query);

  @override
  List<Object> get props => [query];
}

class FilterSymptomsByCategory extends SymptomEvent {
  final String category;
  final PetType petType;

  const FilterSymptomsByCategory({
    required this.category,
    required this.petType,
  });

  @override
  List<Object> get props => [category, petType];
}

class ChangePetType extends SymptomEvent {
  final PetType petType;

  const ChangePetType(this.petType);

  @override
  List<Object> get props => [petType];
} 