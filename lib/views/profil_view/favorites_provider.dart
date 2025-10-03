import 'package:ev_bul/models/animals.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Animal>>((ref) {
      return FavoritesNotifier();
    });

class FavoritesNotifier extends StateNotifier<List<Animal>> {
  FavoritesNotifier() : super([]);

  void addFavorite(Animal animal) {
    if (!state.contains(animal)) {
      state = [...state, animal];
    }
  }

  void removeFavorite(Animal animal) {
    state = state.where((a) => a != animal).toList();
  }

  bool isFavorite(Animal animal) {
    return state.contains(animal);
  }
}
