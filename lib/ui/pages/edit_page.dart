import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:profile_app/extension/extension.dart';
import 'package:profile_app/service/provider.dart';
import 'package:profile_app/ui/pages/mypage.dart';
import 'package:profile_app/utils/app_state.dart';

class EditPage extends ConsumerWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = ref.watch(nameProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // AndroidのAppBarの文字を中央寄せ.
        title: Text('プロフィールを編集'),
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
              decoration: const InputDecoration(labelText: 'ユーザー名を変更'),
            ),
            ElevatedButton(
                onPressed: () {
                  ref
                      .read(appStateProvider.notifier)
                      .editImage(nameController.text);
                  context.to(const MyPage());
                },
                child: Text('ユーザーを更新')),
          ],
        ),
      ),
    );
  }
}
