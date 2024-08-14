import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ready_artisans/services/firestore_services.dart';
import '../models/category_mode.dart';

final categoryStreamProvider = StreamProvider<List<CategoryModel>>(
  (ref) async* {
    var data = FireStoreServices.getCategories();
    ref.onDispose(() {
      data.drain();
    });
    List<CategoryModel> categories = [];
    await for (var snapshot in data) {
      categories =
          snapshot.docs.map((e) => CategoryModel.fromMap(e.data())).toList();
      yield categories;
    }
  },
);


