import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:profile_app/extension/extension.dart';
import 'package:profile_app/service/provider.dart';
import 'package:profile_app/ui/auth/signup_page.dart';
import 'package:profile_app/utils/auth_state.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = ref.watch(emailProvider);
    final passwordlController = ref.watch(passwordProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // AndroidのAppBarの文字を中央寄せ.
        automaticallyImplyLeading: false, //戻るボタンを消す.
        title: Text('ログインページ'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'メールアドレス'),
              ),
              TextField(
                controller: passwordlController,
                decoration: const InputDecoration(labelText: 'パスワード'),
                obscureText: true,
              ),
              ElevatedButton(
                  child: const Text('ログイン'),
                  onPressed: () async {
                    final user = ref.read(authStateProvider.notifier).signIn(
                        emailController.text,
                        passwordlController.text,
                        context);
                  }),
              TextButton(
                  onPressed: () {
                    context.to(const SignUpPage());
                  },
                  child: Text('新規登録'))
            ],
          ),
        ),
      ),
    );
  }
}
