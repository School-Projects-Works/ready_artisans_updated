import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class CloudStorageServices {
  static final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  // save user image cloud storage
  static Future<String> saveUserImage(File image, String userImage) async {
    final Reference storageReference =
        _firebaseStorage.ref().child('userImage/$userImage');
    final UploadTask uploadTask = storageReference.putFile(image);
    final TaskSnapshot taskSnapshot = await uploadTask;
    final String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }



  static Future<String> sendFile(File file, String folder) async{
    final Reference storageReference =
    _firebaseStorage.ref().child('$folder/${file.path.split('/').last}');
    final UploadTask uploadTask = storageReference.putFile(file);
    final TaskSnapshot taskSnapshot = await uploadTask;
    final String url = await taskSnapshot.ref.getDownloadURL();
    return url;

  }
}
