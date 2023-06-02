import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class StatusService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
 // StrogeService _strogeService = StrogeService();
  String? mediaUrl = "";



  Stream<QuerySnapshot> getStatus(){
    var ref = _firestore.collection("users").snapshots();

    return ref;
  }

}