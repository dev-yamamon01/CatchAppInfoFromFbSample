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
}