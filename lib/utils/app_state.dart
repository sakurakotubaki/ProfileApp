import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profile_app/service/provider.dart';

///画像の保存で使用するStateNotifierProvider.
final appStateProvider = StateNotifierProvider<AppState, dynamic>((ref) {
  return AppState(ref);
});

class AppState extends StateNotifier<dynamic> {
  final Ref _ref;
  AppState(this._ref) : super([]);

  Future<void> fileUpload() async {
    // imagePickerで画像を選択する
    final pickerFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickerFile == null) {
      return;
    }
    File file = File(pickerFile.path);
    try {
      // imagesフォルダを指定してuidと画像を保存.
      final uid = _ref.watch(firebaseAuthProvider).currentUser?.uid ?? '';
      final uploadName = "image.png";
      final snapshot = await _ref
          .read(firebaseStorageProvider)
          .ref()
          .child("images/$uid/$uploadName");
      // 画像をStorageにuploadする処理.
      final task = await snapshot.putFile(file);
      final imageUrl = await snapshot.storage
          .ref()
          .child("images/$uid/$uploadName")
          .getDownloadURL();
      // uploadに成功するとlogが表示される.
      print(imageUrl);
    } catch (e) {
      print(e);
    }
  }

  // FireStoreに画像のURLを保存するメソッド.
  Future<void> sendImage(String name) async {
    // imagesフォルダを指定して画像のURLを取得.
    final uid = _ref.watch(firebaseAuthProvider).currentUser?.uid ?? '';
    final uploadName = "image.png";
    final imageRef = _ref
        .read(firebaseStorageProvider)
        .ref()
        .child("images/$uid/$uploadName");
    // URLをFireStoreに保存する.
    String imageUrl = await imageRef.getDownloadURL();
    // Map方を使う.
    Map<String, dynamic> data = {
      "name": name,
      "image": imageUrl,
    };
    // FireStoreにデータを追加する.
    final user = _ref.watch(firebaseAuthProvider).currentUser;
    final _reference =
        _ref.read(fireStoreProvider).collection('profile').doc(uid);
    // 先ほどのMap型のdata変数を使用する.
    _reference.set(data);
  }

  // プロフィール情報を更新するメソッド.
  Future<void> editImage(String name) async {
    // imagesフォルダを指定して画像のURLを取得.
    final uid = _ref.watch(firebaseAuthProvider).currentUser?.uid ?? '';
    final uploadName = "image.png";
    final imageRef = _ref
        .read(firebaseStorageProvider)
        .ref()
        .child("images/$uid/$uploadName");
    // URLをFireStoreに保存する.
    String imageUrl = await imageRef.getDownloadURL();
    // Map方を使う.
    Map<String, dynamic> data = {
      "name": name,
      "image": imageUrl,
    };
    // FireStoreにデータを追加する.
    final user = _ref.watch(firebaseAuthProvider).currentUser;
    final _reference =
        _ref.read(fireStoreProvider).collection('profile').doc(uid);
    // 先ほどのMap型のdata変数を使用する.
    _reference.update(data);
  }

  // プロフィール情報を削除するメソッド.
  Future<void> deleteImage() async {
    // imagesフォルダを指定して画像のURLを取得.
    final uid = _ref.watch(firebaseAuthProvider).currentUser?.uid ?? '';
    final uploadName = "image.png";
    final imageRef = _ref
        .read(firebaseStorageProvider)
        .ref()
        .child("images/$uid/$uploadName");
    // Storageの画像を削除する.
    final imageUrl = await imageRef.delete();

    // FireStoreのデータを削除する.
    final user = _ref.watch(firebaseAuthProvider).currentUser;
    final _reference =
        _ref.read(fireStoreProvider).collection('profile').doc(uid);
    _reference.delete();
  }
}
