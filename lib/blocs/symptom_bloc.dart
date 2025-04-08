import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/symptom_repository.dart';
import 'symptom_event.dart';
import 'symptom_state.dart';
import '../models/symptom.dart';

class SymptomBloc extends Bloc<SymptomEvent, SymptomState> {
  final SymptomRepository _repository;

  SymptomBloc(this._repository) : super(SymptomInitial()) {
    on<LoadSymptoms>(_onLoadSymptoms);
    on<SearchSymptoms>(_onSearchSymptoms);
    on<FilterSymptomsByCategory>(_onFilterSymptoms);
    on<ChangePetType>(_onChangePetType);
  }

  Future<void> _onLoadSymptoms(
    LoadSymptoms event,
    Emitter<SymptomState> emit,
  ) async {
    emit(SymptomLoading());
    try {
      final symptoms = await _repository.getSymptomsByCategory(
        'All Symptoms',
        PetType.dog,
      );
      emit(SymptomLoaded(
        symptoms: symptoms,
        selectedPetType: PetType.dog,
        selectedCategory: 'All Symptoms',
      ));
    } catch (e) {
      emit(SymptomError(e.toString()));
    }
  }

  Future<void> _onSearchSymptoms(
    SearchSymptoms event,
    Emitter<SymptomState> emit,
  ) async {
    if (state is SymptomLoaded) {
      final currentState = state as SymptomLoaded;
      try {
        final symptoms = await _repository.searchSymptoms(
          event.query,
          petType: currentState.selectedPetType,
        );
        emit(currentState.copyWith(
          symptoms: symptoms,
          searchQuery: event.query,
        ));
      } catch (e) {
        emit(SymptomError(e.toString()));
      }
    }
  }

  Future<void> _onFilterSymptoms(
    FilterSymptomsByCategory event,
    Emitter<SymptomState> emit,
  ) async {
    if (state is SymptomLoaded) {
      final currentState = state as SymptomLoaded;
      try {
        final symptoms = await _repository.getSymptomsByCategory(
          event.category,
          event.petType,
        );
        emit(currentState.copyWith(
          symptoms: symptoms,
          selectedCategory: event.category,
          selectedPetType: event.petType,
        ));
      } catch (e) {
        emit(SymptomError(e.toString()));
      }
    }
  }

  Future<void> _onChangePetType(
    ChangePetType event,
    Emitter<SymptomState> emit,
  ) async {
    if (state is SymptomLoaded) {
      final currentState = state as SymptomLoaded;
      try {
        final symptoms = await _repository.getSymptomsByCategory(
          currentState.selectedCategory,
          event.petType,
        );
        emit(currentState.copyWith(
          symptoms: symptoms,
          selectedPetType: event.petType,
        ));
      } catch (e) {
        emit(SymptomError(e.toString()));
      }
    }
  }
} 