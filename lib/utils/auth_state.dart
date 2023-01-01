import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:profile_app/extension/extension.dart';
import 'package:profile_app/service/provider.dart';
import 'package:profile_app/ui/pages/mypage.dart';

/// 認証で使用するStateNotifierProvider.
final authStateProvider = StateNotifierProvider<AuthState, dynamic>((ref) {
  // Riverpod2.0はここの引数にrefを書かなければエラーになる!
  return AuthState(ref);
});

class AuthState extends StateNotifier<dynamic> {
  // readメソッド使えるようにする.
  final Ref _ref;

  AuthState(this._ref) : super([]);
  // ユーザーの新規作成をするメソッド
  Future<void> signUp(
      String email, String password, BuildContext context) async {
    try {
      final ref = await _ref
          .read(firebaseAuthProvider)
          .createUserWithEmailAndPassword(email: email, password: password);
      // ユーザーが作成できたら画面遷移する.
      await context.to(const MyPage());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // パスワードが６桁以上入力されていないとエラーのDialogが出る!
        _passwordSignUpDialog(context);
      } else if (e.code == 'email-already-in-use') {
        // メールアドレスが入力されていないとエラーのDialogが出る!
        _emailSignUpDialog(context);
      }
    } catch (e) {
      print(e);
    }
  }

  // ログインをするメソッド.
  Future<void> signIn(
      String emailAddress, String password, BuildContext context) async {
    final user = await _ref.read(firebaseAuthProvider);
    try {
      final credential = await _ref
          .read(firebaseAuthProvider)
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      await context.to(const MyPage());
    } on FirebaseAuthException catch (e) {
      // メールアドレスのエラーDialog
      if (e.code == 'user-not-found') {
        _signinEmailDialog(context);
      } else if (e.code == 'invalid-email') {
        // メールアドレスのエラーDialog
        _signinEmailDialog(context);
      } else if (e.code == 'wrong-password') {
        // パスワードのエラーDialog
        _signInPasswordDialog(context);
      }
    }
  }

  Future<void> signOunt() async {
    await _ref.read(firebaseAuthProvider).signOut();
  }
}

// ログインのメールアドレスのエラーを表示するDialog
void _signinEmailDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text('メールアドレスのフォーマットが正しくありません。'),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.pop(dialogContext);
            },
          ),
        ],
      );
    },
  );
}

// ログインのパスワードのエラーを表示するDialog
void _signInPasswordDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text('パスワードが正しく入力されてません!'),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.pop(dialogContext);
            },
          ),
        ],
      );
    },
  );
}

void _emailSignUpDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text('指定したメールアドレスは登録済みです'),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.pop(dialogContext);
            },
          ),
        ],
      );
    },
  );
}

void _passwordSignUpDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text('パスワードは６桁以上入力が必要です!'),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.pop(dialogContext);
            },
          ),
        ],
      );
    },
  );
}
