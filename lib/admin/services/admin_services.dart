import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ready_artisans/models/category_mode.dart';

import '../../models/user_model.dart';

class AdminServices {
  static final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  static final CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');
  static final CollectionReference appointments =
      FirebaseFirestore.instance.collection('reviews');
  static Stream<List<UserModel>> getArtisans() {
    try {
      return users.snapshots().map((snapshot) => snapshot.docs.map((doc) {
            var data = doc.data() as Map<String, dynamic>;
           
            return UserModel.fromMap(data);
          }).toList());
    } catch (e) {
      return const Stream.empty();
    }
  }

  static Stream<List<CategoryModel>> getCategories() {
    return categories.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => CategoryModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList());
  }

  static Future<bool> addCategory(CategoryModel category) async {
    try {
      await categories.doc(category.id).set(category.toMap());
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

  static Future<bool> deleteCategory(String id) async {
    try {
      await categories.doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  static String getCategoryId() {
    return categories.doc().id;
  }

  static Future<String> uploadImage(Uint8List byte, String id) async {
    try {
      var ref = FirebaseStorage.instance.ref().child('categories/$id');
      var uploadTask =
          ref.putData(byte, SettableMetadata(contentType: 'image/jpeg'));
      var snapshot = await uploadTask.whenComplete(() => null);
      return await snapshot.ref.getDownloadURL();
    } catch (error) {
      return '';
    }
  }

  static String getUserId() {
    return users.doc().id;
  }

  static createUser(UserModel user) async {
    await users.doc(user.id).set(user.toMap());
  }
}
