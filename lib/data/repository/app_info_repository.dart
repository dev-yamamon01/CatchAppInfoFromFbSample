import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final appInfoRepositoryProvider = Provider((ref) => AppInfoRepository());

final appInfoStreamProvider =
StreamProvider<Map<String, dynamic>?>((ref) {
  return ref.watch(appInfoRepositoryProvider).listenAppInfo();
});


class AppInfoRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  ///firestoreのapp/appInfoドキュメントのスナップショットをリアルタイム取得するメソッド
  Stream<Map<String, dynamic>?> listenAppInfo() {
    return _db.collection('app').doc('appInfo').snapshots().map(
          (snapshot) => snapshot.data(),
    );
  }

  /// app/appInfo ドキュメントにテストデータを書き込む
  Future<void> setData() async {
    final docRef = _db.collection('app').doc('appInfo');
    await docRef.set(
      {
        "testField": "Hello Test",
        "updatedAt": FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true), // 既存フィールドを消さずに追加/更新
    );
    print('setData() done');
  }

}