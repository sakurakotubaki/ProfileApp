import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:profile_app/extension/extension.dart';
import 'package:profile_app/service/provider.dart';
import 'package:profile_app/ui/pages/edit_page.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// FutureBuilderで使う変数.
    /// ログインしているユーザーの情報を取得する.
    final uid = ref.watch(firebaseAuthProvider).currentUser?.uid ?? '';
    final docRef =
        ref.watch(fireStoreProvider).collection('profile').doc(uid).get();
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  context.to(const EditPage());
                },
                icon: Icon(Icons.edit))
          ],
          centerTitle: true, // AndroidのAppBarの文字を中央寄せ.
          title: const Text(
            'プロフィールページ',
            style: TextStyle(color: Colors.white),
          )),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10),
        child: FutureBuilder<DocumentSnapshot>(
          future: docRef,
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return const Text("Document does not exist");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 50, //丸のサイズを調整.
                      backgroundColor: Colors.grey, // 画像が非表示の時の色を設定.
                      backgroundImage:
                          NetworkImage(data["image"]), // imageドキュメントを取得.
                    ),
                    SizedBox(width: 20),
                    Text(
                      "${data['name']}", // nameドキュメントを取得.
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              );
            }
            return const Text("loading");
          },
        ),
      ),
    );
  }
}
