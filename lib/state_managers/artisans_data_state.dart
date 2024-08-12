import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ready_artisans/models/category_mode.dart';
import 'package:ready_artisans/models/user_model.dart';
import 'package:ready_artisans/services/firestore_services.dart';
import 'package:ready_artisans/state_managers/category_data_state.dart';

final artisanStreamProvider =
    StreamProvider.autoDispose<List<UserModel>>((ref) async* {
  var data = FireStoreServices.getArtisans();
  ref.onDispose(() {
    data.drain();
  });
  List<UserModel> artisans = [];
  await for (var snapshot in data) {
    artisans = snapshot.docs.map((e) => UserModel.fromMap(e.data())).toList();
    yield artisans;
  }
});

final selectedArtisanProvider =
    StateProvider.autoDispose.family<UserModel, String>((ref, id) {
  var artisans = ref.watch(artisanStreamProvider);
  UserModel artisan = UserModel.empty();
  artisans.whenData((value) {
    artisan = value.firstWhere((element) => element.id == id);
  });
  return artisan;
});

final selectedArtisanCategoryProvider =
    StateProvider.autoDispose.family<CategoryModel, String>((ref, id) {
  var categories = ref.watch(categoryStreamProvider);
  CategoryModel category = CategoryModel.empty();
  categories.whenData((value) {
    category = value.firstWhere((element) => element.name == id);
  });
  return category;
});

final artisanSearchQueryProvider = StateProvider.autoDispose<String>((ref) {
  return '';
});
final filteredArtisanStreamProvider =
    StateProvider.autoDispose<List<UserModel>>((ref) {
  String query = ref.watch(artisanSearchQueryProvider);
  var data = ref.watch(artisanStreamProvider);
  if (query.isEmpty) {
    return [];
  } else {
    List<UserModel> artisans = [];
    data.whenData((value) {
      artisans = value
          .where((element) =>
              element.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
    return artisans;
  }
});
