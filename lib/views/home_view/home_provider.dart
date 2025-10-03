import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:ev_bul/models/animals.dart';
import 'package:ev_bul/product/utility/firebase/firebase_utility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeNotifier extends StateNotifier<HomeState> with FirebaseUtility {
  HomeNotifier() : super(const HomeState());

  Future<void> fetchAnimals() async {
    final animalsCollectionReferance = FirebaseFirestore.instance.collection(
      'animals',
    );

    final response = await animalsCollectionReferance
        .withConverter(
          fromFirestore: (snapshot, options) {
            return const Animal().fromFirebase(snapshot);
          },
          toFirestore: (value, options) {
            return value.toJson();
          },
        )
        .get();

    if (response.docs.isNotEmpty) {
      final values = response.docs.map((e) => e.data()).toList();
      state = state.copyWith(animals: values);
    }
  }

  Future<void> fetchAnimalsByCategory(String category) async {
    state = state.copyWith(isLoading: true, selectedCategory: category);
    if (category.toLowerCase() == 'hepsi') {
      await fetchAnimals();
      state = state.copyWith(selectedCategory: category, isLoading: false);
      return;
    }

    final normalizedCategory =
        category[0].toUpperCase() + category.substring(1).toLowerCase();

    final animalsCollectionRef = FirebaseFirestore.instance
        .collection('animals')
        .where('category', isEqualTo: normalizedCategory);

    final response = await animalsCollectionRef
        .withConverter<Animal>(
          fromFirestore: (snapshot, _) => const Animal().fromFirebase(snapshot),
          toFirestore: (animal, _) => animal.toJson(),
        )
        .get();

    final values = response.docs.map((doc) => doc.data()).toList();
    state = state.copyWith(animals: values, isLoading: false);
  }

  Future<void> fetchAndLoad({String? category}) async {
    state = state.copyWith(isLoading: true);

    if (category == null || category == 'random') {
      await fetchAnimals();
    } else {
      await fetchAnimalsByCategory(category);
    }

    state = state.copyWith(isLoading: false);
  }

  void filterAnimalsByText(String query) {
    final originalList = state.animals ?? [];
    if (query.isEmpty) {
      if (state.selectedCategory != null) {
        fetchAnimalsByCategory(state.selectedCategory!);
      } else {
        fetchAnimals();
      }
      return;
    }
    final lowerQuery = query.toLowerCase();
    final filtered = originalList.where((animal) {
      final title = animal.title?.toLowerCase() ?? '';
      final subtitle = animal.subtitle?.toLowerCase() ?? '';
      return title.contains(lowerQuery) || subtitle.contains(lowerQuery);
    }).toList();

    state = state.copyWith(animals: filtered);
  }
}

class HomeState extends Equatable {
  const HomeState({this.animals, this.isLoading, this.selectedCategory});

  final List<Animal>? animals;
  final bool? isLoading;
  final String? selectedCategory;

  @override
  List<Object> get props => [];

  HomeState copyWith({
    List<Animal>? animals,
    bool? isLoading,
    String? selectedCategory,
  }) {
    return HomeState(
      animals: animals ?? this.animals,
      isLoading: isLoading ?? this.isLoading,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}
