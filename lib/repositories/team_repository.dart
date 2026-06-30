import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swe206_project/models/team_model.dart';
import 'package:swe206_project/models/user_model.dart';

class TeamRepository {
  final _db = FirebaseFirestore.instance;

  Future<List<TeamModel>> getTeams() async {
    final snap = await _db.collection('teams').get();
    return snap.docs
        .where((d) => d.data().isNotEmpty)
        .map((d) => TeamModel.fromJson(d.data()))
        .toList();
  }

  Future<List<TeamModel>> getCurrentUserTeams(String email) async {
    final results = await Future.wait([
      _db.collection('users').get(),
      _db.collection('teams').get(),
    ]);

    final allUsers = results[0].docs
        .where((d) => d.data().isNotEmpty)
        .map((d) => UserModel.fromJson(d.data()))
        .where((u) => u.name.isNotEmpty)
        .toList();

    final allTeams = results[1].docs
        .where((d) => d.data().isNotEmpty)
        .map((d) => TeamModel.fromJson(d.data()))
        .toList();

    final UserModel currentUser;
    try {
      currentUser = allUsers.firstWhere((u) => u.email == email);
    } catch (_) {
      return [];
    }

    if (currentUser.status == 'admin') return allTeams;

    return allTeams
        .where((t) => t.members.any((m) => m.name == currentUser.name))
        .toList();
  }

  List<String> getTeamMembers(TeamModel team) {
    return team.members.map((m) => m.name).toList();
  }

  Future<void> addTeam(String name, String leader, List members) async {
    final membersList = members.map((m) => {'name': m as String}).toList();
    await _db.collection('teams').add({
      'name': name,
      'leader': leader,
      'project': null,
      'members': membersList,
    });
  }

  Future<void> updateTeamMembers(String teamName, List<String> members) async {
    final snap = await _db
        .collection('teams')
        .where('name', isEqualTo: teamName)
        .get();
    if (snap.docs.isEmpty) return;
    final membersList = members.map((m) => {'name': m}).toList();
    await snap.docs.first.reference.update({'members': membersList});
  }
}
