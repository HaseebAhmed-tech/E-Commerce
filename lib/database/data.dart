// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Data {
  String? uid;
  Data({this.uid});
  static CollectionReference _getUserCollection() {
    return FirebaseFirestore.instance.collection("users");
  }

  static CollectionReference _getCarouselImagesCollection() {
    return FirebaseFirestore.instance.collection("carousel_images");
  }

  static CollectionReference _getProductsCollection() {
    return FirebaseFirestore.instance.collection("products");
  }

  static CollectionReference getProductsSnapshots() {
    return _getProductsCollection();
  }

  Future<void> createUserData(String username, String contact) async {
    return _getUserCollection().doc(uid).set(
      {
        "username": username,
        "contact": contact,
      },
    );
  }

  static Future<QuerySnapshot> accessCarouselImages() async {
    return await _getCarouselImagesCollection().get();
  }

  static Future<QuerySnapshot> accessProductsInfo() async {
    return await _getProductsCollection().get();
  }

  static User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }
}
