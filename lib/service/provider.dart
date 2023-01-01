import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ログイン状態を維持するProvider.
final authStateChangesProvider = StreamProvider.autoDispose<User?>((ref) {
  // 以下のプロバイダからFirebaseAuthを取得します。
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  // Stream<User?> を返すメソッドを呼び出す。
  return firebaseAuth.authStateChanges();
});

// プロバイダを使用して、FirebaseAuth インスタンスにアクセスします。
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

// メールアドレスのテキストを保存するProvider.
final emailProvider = StateProvider.autoDispose((ref) {
  return TextEditingController(text: '');
});

// パスワードのテキストを保存するProvider.
final passwordProvider = StateProvider.autoDispose((ref) {
  return TextEditingController(text: '');
});

// 名前のテキストを保存するProvider.
final nameProvider = StateProvider.autoDispose((ref) {
  return TextEditingController(text: '');
});
// FireStore用のProvider.
final fireStoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

// FirebaseStorage用のProvider.
final firebaseStorageProvider =
    Provider<FirebaseStorage>((ref) => FirebaseStorage.instance);

// FireStoreの値を画面に描画するProvider.
final listProvider = StreamProvider.autoDispose((ref) {
  return ref.watch(fireStoreProvider).collection('profile').snapshots();
});
