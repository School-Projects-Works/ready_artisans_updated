import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ready_artisans/models/user_model.dart';
import 'package:ready_artisans/services/firestore_services.dart';

final artisanStreamProvider =
    StreamProvider.autoDispose<List<UserModel>>((ref) async* {
  var data = FireStoreServices.getArtisans();
  ref.onDispose(() {
    data.drain();
  });
  List<UserModel> artisans = [];
  await for (var snapshot in data) {
    artisans = snapshot.docs.map((e) => UserModel.fromMap(e.data())).toList();
    ref.read(artisansFilterProvider.notifier).setItems(artisans);
    yield artisans;
  }
});


class ArtisansFilter {
  List<UserModel> items;
  List<UserModel> filter;
  ArtisansFilter({
    required this.items,
    required this.filter,
  });

  ArtisansFilter copyWith({
    List<UserModel>? items,
    List<UserModel>? filter,
  }) {
    return ArtisansFilter(
      items: items ?? this.items,
      filter: filter ?? this.filter,
    );
  }
}

final artisansFilterProvider =
    StateNotifierProvider<ArtisansFilterState, ArtisansFilter>((ref) {
  return ArtisansFilterState();
});

class ArtisansFilterState extends StateNotifier<ArtisansFilter> {
  ArtisansFilterState() : super(ArtisansFilter(items: [], filter: []));
  void setItems(List<UserModel> items) {
    state = state.copyWith(items: items, filter: items);
  }

  void filterArtisansByCat(String query) {
    if (query.isNotEmpty) {
      List<UserModel> _filtered = state.items
          .where((element) =>
             
              element.artisanCategory.toLowerCase().contains(query.toLowerCase()))
          .toList();
      state = state.copyWith(filter: _filtered);
    } else {
      state = state.copyWith(filter: state.items);
    }
  }

  void filterArtisansByName(String query) {
    if (query.isNotEmpty) {
      List<UserModel> _filtered = state.items
          .where((element) =>
              element.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      state = state.copyWith(filter: _filtered);
    } else {
      state = state.copyWith(filter: state.items);
    }
  }
}

