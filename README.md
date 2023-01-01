# Zennの本のサンプルコード
プロフィール画像アプリの作成チュートリアルを出版
## overview(概要)
Riverpodを使用して、画像のuploadを行う。
作者は、画像の機能を実装するのが、苦手だったので、
今回、動くソースコードを参考に試行錯誤して、
サンプルアプリを作成した。

## 今回使用した技術

| 使用する技術 |  Version |
|--------------|----------|
|Flutter       |3.3.1     |
|Dart          |2.18.0    |
|firebase_core |^2.4.1    |
|firebase_auth |^4.2.4    |
|cloud_firestore |^4.3.1  |
|flutter_riverpod|^2.1.1  |
|firebase_storage     |^11.0.10    |
|image_picker     |^0.8.5+3    |

## getting started(入門)
FlutterでFirebaseの環境構築と学習はこちらのサイトがおすすめです。
最初は、ドキュメントとUdemyやYouTubeで簡単アプリを作って、
知識のInputをすることから、始めましょう。
https://firebase.flutter.dev/
- 技術を学習した手順
  1. StatefulWidgeでアプリを作成して仕組みを理解する.
  2. Riverpodにリファクタリングして状態管理をする.

## summary(要点、手短な)
技術記事やドキュメントを見て、仕組みを理解して自分の
使いたい機能を作れるようになるのが目的。

## implement(実行する、実装する)
1. まずは、動くコードを見て、仕組みを理解する.
2. その後に状態管理をする。
3. 写経すれば理解できる訳ではない!