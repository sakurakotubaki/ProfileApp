import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:profile_app/extension/extension.dart';
import 'package:profile_app/service/provider.dart';
import 'package:profile_app/ui/auth/signin_page.dart';
import 'package:profile_app/ui/pages/list.dart';
import 'package:profile_app/ui/pages/profile_page.dart';
import 'package:profile_app/ui/pages/upload_page.dart';
import 'package:profile_app/utils/app_state.dart';
import 'package:profile_app/utils/auth_state.dart';

class MyPage extends ConsumerWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = ref.watch(nameProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // AndroidのAppBarの文字を中央寄せ.
        automaticallyImplyLeading: false, //戻るボタンを消す.
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              // ログアウト処理.
              ref.read(authStateProvider.notifier).signOunt();
              context.to(const SignInPage());
            },
          ),
        ],
        title: Text('マイページ'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  context.to(const UploadPage());
                },
                child: Text('プロフィールを作成')),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  context.to(const ListPage());
                },
                child: Text('登録済みユーザー')),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  context.to(const ProfilePage());
                },
                child: Text('プロフィールページ')),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  ref.read(appStateProvider.notifier).deleteImage();
                },
                child: Text('プロフィール情報を削除する'))
          ],
        ),
      ),
    );
  }
}
