import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swe206_project/models/user_model.dart';

class UserRepository {
  final _db = FirebaseFirestore.instance;

  Future<List<UserModel>> getMembers() async {
    final snap = await _db.collection('users').get();
    return snap.docs
        .where((d) => d.data().isNotEmpty)
        .map((d) => UserModel.fromJson(d.data()))
        .where((u) => u.name.isNotEmpty)
        .toList();
  }

  Future<UserModel?> getCurrentUserObject(String email) async {
    final members = await getMembers();
    try {
      return members.firstWhere((u) => u.email == email);
    } catch (_) {
      return null;
    }
  }
}
