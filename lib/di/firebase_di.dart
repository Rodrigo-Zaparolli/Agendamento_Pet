import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FirebaseModule {
  @preResolve
  Future<FirebaseApp> get initFirebaseApp => Firebase.initializeApp();

  @injectable
  FirebaseAuth get auth => FirebaseAuth.instance;

  @injectable
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
}
