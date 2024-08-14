import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ready_artisans/admin/core/custom_dialog.dart';
import 'package:ready_artisans/admin/core/funnnctions/sms_functions.dart';

import 'package:ready_artisans/models/user_model.dart';

import '../../models/category_mode.dart';
import '../services/admin_services.dart';

final userStream = StreamProvider<List<UserModel>>((ref) async* {
  var data = AdminServices.getArtisans();
  await for (var value in data) {
    var artisans =
        value.where((element) => element.userType == 'artisan').toList();
    ref.read(artisansFilterProvider.notifier).setArtisans(artisans);
    var clients =
        value.where((element) => element.userType == 'client').toList();
    ref.read(clientFilterProvider.notifier).setClients(clients);
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

final artisansFilterProvider =
    StateNotifierProvider<ArtisansProvider, UserFilter>((ref) {
  return ArtisansProvider();
});

class ArtisansProvider extends StateNotifier<UserFilter> {
  ArtisansProvider() : super(UserFilter(items: [], filter: []));

  void filterArtisans(String query) {
    state = state.copyWith(
        filter: state.items
            .where((element) =>
                element.name.toLowerCase().contains(query.toLowerCase()))
            .toList());
  }

  void setArtisans(List<UserModel> items) {
    state = state.copyWith(items: items, filter: items);
  }

  void updateStatus(UserModel copyWith) async {
    CustomAdminDialog.dismiss();
    CustomAdminDialog.showLoading(message: 'Updating User Status');
    var results = await AdminServices.updateUser(copyWith);
    await sendMessage(copyWith.phone,
        'Your account has been ${copyWith.status == 'active' ? 'activated, login to start using the platform.' : 'banned. Contact admin for more information'}');
    CustomAdminDialog.dismiss();
    if (results) {
      CustomAdminDialog.showToast(message: 'User Status Updated');
    } else {
      CustomAdminDialog.showToast(message: 'Unable to update user status');
    }
  }
}

final clientFilterProvider =
    StateNotifierProvider<ClientsProvider, UserFilter>((ref) {
  return ClientsProvider();
});

class ClientsProvider extends StateNotifier<UserFilter> {
  ClientsProvider() : super(UserFilter(items: [], filter: []));

  void filterClients(String query) {
    state = state.copyWith(
        filter: state.items
            .where((element) =>
                element.name.toLowerCase().contains(query.toLowerCase()))
            .toList());
  }

  void setClients(List<UserModel> items) {
    state = state.copyWith(items: items, filter: items);
  }

  void updateStatus(UserModel copyWith) async {
    CustomAdminDialog.dismiss();
    CustomAdminDialog.showLoading(message: 'Updating User Status');
    var results = await AdminServices.updateUser(copyWith);
    //send user sms
    await sendMessage(copyWith.phone,
        'Your account has been ${copyWith.status == 'active' ? 'activated, login to start using the platform.' : 'banned. Contact admin for more information'}');
    CustomAdminDialog.dismiss();
    if (results) {
      CustomAdminDialog.showToast(message: 'User Status Updated');
    } else {
      CustomAdminDialog.showToast(message: 'Unable to update user status');
    }
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

final categoriesFilterProvider =
    StateNotifierProvider<CategoriesProvider, CategoryFilter>((ref) {
  return CategoriesProvider();
});

class CategoriesProvider extends StateNotifier<CategoryFilter> {
  CategoriesProvider() : super(CategoryFilter(items: [], filter: []));

  void filterCategories(String query) {
    state = state.copyWith(
        filter: state.items
            .where((element) =>
                element.name.toLowerCase().contains(query.toLowerCase()))
            .toList());
  }

  void setCategories(List<CategoryModel> items) {
    state = state.copyWith(items: items, filter: items);
  }

  void deleteCategory(String id) async {

    CustomAdminDialog.dismiss();
    CustomAdminDialog.showLoading(message: 'Deleting Category');
    var results = await AdminServices.deleteCategory(id);

    CustomAdminDialog.dismiss();
    if (results) {
      CustomAdminDialog.showToast(message: 'Category Deleted');
    } else {
      CustomAdminDialog.showToast(message: 'Unable to delete category');
    }
  }
}
