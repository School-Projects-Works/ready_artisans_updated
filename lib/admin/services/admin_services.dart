import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ready_artisans/models/category_mode.dart';

import '../../models/user_model.dart';

class AdminServices{

  static final  CollectionReference users = FirebaseFirestore.instance.collection('users');
  static final  CollectionReference categories = FirebaseFirestore.instance.collection('categories');
  static final  CollectionReference appointments = FirebaseFirestore.instance.collection('reviews');
  static Stream<List<UserModel>> getArtisans() {
    return users.where('userType', whereIn: ['artisan','Artisan']).snapshots().map((snapshot) => snapshot.docs.map((doc) => UserModel.fromMap(doc.data() as Map<String,dynamic>)).toList());

  }
  static Stream<List<CategoryModel>> getCategories() {
    return categories.snapshots().map((snapshot) => snapshot.docs.map((doc) => CategoryModel.fromMap(doc.data() as Map<String,dynamic>)).toList());

  }

  static Future<bool> addCategory(CategoryModel category) async {
    try {
      await categories.add(category.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

//update user 
  static Future<bool> updateUser(UserModel user) async {
    try {
      await users.doc(user.id).update(user.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  
  static Future<bool> updateCategory(CategoryModel category) async {
    try {
      await categories.doc(category.id).update(category.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteCategory(CategoryModel category) async {
    try {
      await categories.doc(category.id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }


 

}


