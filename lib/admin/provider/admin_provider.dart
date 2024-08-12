import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ready_artisans/models/user_model.dart';

import '../../models/category_mode.dart';
import '../services/admin_services.dart';

final artisanStreamProvider = StreamProvider<List<UserModel>>((ref) async* {
  var data = AdminServices.getArtisans();
  await for (var value in data) {
    ref.read(artisansFilterProvider.notifier).setArtisans(value);
    yield value;
  }
});

class UserFilter {
  List<UserModel> items;
  List<UserModel> filter;
  UserFilter({
    required this.items,
    required this.filter,
  });

  UserFilter copyWith({
    List<UserModel>? items,
    List<UserModel>? filter,
  }) {
    return UserFilter(
      items: items ?? this.items,
      filter: filter ?? this.filter,
    );
  }
}


final artisansFilterProvider = StateNotifierProvider<ArtisansProvider, UserFilter>((ref) {
  return ArtisansProvider();
});


class ArtisansProvider extends StateNotifier<UserFilter> {
  ArtisansProvider() : super(UserFilter(items: [], filter: []));

  void filterArtisans(String query) {
    state = state.copyWith(filter: state.items.where((element) => element.name.toLowerCase().contains(query.toLowerCase())).toList());
  }

  void setArtisans(List<UserModel> items) {
    state = state.copyWith(items: items, filter: items);
  }
}


final categoriesStream = StreamProvider<List<CategoryModel>>((ref) async* {
  var data = AdminServices.getCategories();
  await for (var value in data) {
    ref.read(categoriesFilterProvider.notifier).setCategories(value);
    yield value;
  }
});

class CategoryFilter {
  List<CategoryModel> items;
  List<CategoryModel> filter;
  CategoryFilter({
    required this.items,
    required this.filter,
  });

  CategoryFilter copyWith({
    List<CategoryModel>? items,
    List<CategoryModel>? filter,
  }) {
    return CategoryFilter(
      items: items ?? this.items,
      filter: filter ?? this.filter,
    );
  }
}


final categoriesFilterProvider = StateNotifierProvider<CategoriesProvider, CategoryFilter>((ref) {
  return CategoriesProvider();
});


class CategoriesProvider extends StateNotifier<CategoryFilter> {
  CategoriesProvider() : super(CategoryFilter(items: [], filter: []));

  void filterCategories(String query) {
    state = state.copyWith(filter: state.items.where((element) => element.name.toLowerCase().contains(query.toLowerCase())).toList());
  }

  void setCategories(List<CategoryModel> items) {
    state = state.copyWith(items: items, filter: items);
  }
}

