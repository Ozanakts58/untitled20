import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';

Reference get firebaseStorage => FirebaseStorage.instance.ref();

class FirebaseStrogeService extends GetxService {
  getImage(String? imgName) {
    if (imgName == null) {
      return null;
    }
    try {
      firebaseStorage.child("book_images")
          .child('${imgName.toLowerCase()}.png');
    } catch (e) {
      return null;
    }
  }
}