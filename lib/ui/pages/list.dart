import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:profile_app/service/provider.dart';

class ListPage extends ConsumerWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ListViewBuilderで使用するStreamProviderを呼び出す.
    final AsyncValue<QuerySnapshot> list = ref.watch(listProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // AndroidのAppBarの文字を中央寄せ.
        title: Text('ユーザー一覧'),
      ),
      body: list.when(
        data: (QuerySnapshot query) {
          return ListView(
            children: query.docs.map((document) {
              return ListTile(
                title: Text(document['name']), // 名前を表示する.
                leading: Container(
                    // 画像を丸くする設定.
                    clipBehavior: Clip.antiAlias,
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    // Image.networkで画像を画面に表示する
                    child: Image.network('${document['image']}')),
              );
            }).toList(),
          );
        },

        // データの読み込み中（FireStoreではあまり発生しない）
        loading: () {
          return const Text('Loading');
        },

        // エラー（例外発生）時
        error: (e, stackTrace) {
          return Text('error: $e');
        },
      ),
    );
  }
}
