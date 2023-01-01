import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:profile_app/service/provider.dart';
import 'package:profile_app/utils/app_state.dart';

class UploadPage extends ConsumerWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = ref.watch(nameProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // AndroidのAppBarの文字を中央寄せ.
        title: Text('プロフィールを作成'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  ref.read(appStateProvider.notifier).fileUpload();
                },
                child: Text('画像をUpload')),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'ユーザー名を入力'),
            ),
            ElevatedButton(
                onPressed: () {
                  ref
                      .read(appStateProvider.notifier)
                      .sendImage(nameController.text);
                },
                child: Text('ユーザーを登録')),
          ],
        ),
      ),
    );
  }
}
