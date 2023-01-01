import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:profile_app/service/provider.dart';
import 'package:profile_app/utils/auth_state.dart';

class SignUpPage extends ConsumerWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = ref.watch(emailProvider);
    final passwordlController = ref.watch(passwordProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // AndroidのAppBarの文字を中央寄せ.
        title: Text('新規登録'),
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
                  child: const Text('新規登録'),
                  onPressed: () async {
                    final user = ref.read(authStateProvider.notifier).signUp(
                        emailController.text,
                        passwordlController.text,
                        context);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
