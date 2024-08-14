import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ready_artisans/admin/core/custom_dialog.dart';
import 'package:ready_artisans/admin/services/admin_services.dart';
import 'package:ready_artisans/models/category_mode.dart';

final newCategoryProvider =
    StateNotifierProvider<NewCategory, CategoryModel>((ref) => NewCategory());

class NewCategory extends StateNotifier<CategoryModel> {
  NewCategory() : super(CategoryModel.empty());

  void setCategoryName(String name) {
    state = state.copyWith(name: name);
  }

  void setCategoryDescription(String description) {
    state = state.copyWith(description: description);
  }

  void setCategoryImage(String image) {
    state = state.copyWith(image: image);
  }

  void setPricePerHour(double parse) {
    state = state.copyWith(perHourRate: parse);
  }

  void saveCategory(GlobalKey<FormState> formKey, WidgetRef ref) async {
    CustomAdminDialog.showLoading(message: 'Saving Category');
    var id = AdminServices.getCategoryId();
    var image = ref.read(categoryImageProvider)!;
    var byte = await image.readAsBytes();
    var url = await AdminServices.uploadImage(byte, id);
    state = state.copyWith(id: id, image: url);
    var results = await AdminServices.addCategory(state);
    if (results) {
      CustomAdminDialog.dismiss();
      CustomAdminDialog.showToast(
        message: 'Category saved successfully',
      );
      formKey.currentState!.reset();
      ref.read(categoryImageProvider.notifier).state = null;
    } else {
      CustomAdminDialog.dismiss();
      CustomAdminDialog.showToast(message: 'Unable to save category');
    }
  }
}

final categoryImageProvider = StateProvider<XFile?>((ref) => null);
