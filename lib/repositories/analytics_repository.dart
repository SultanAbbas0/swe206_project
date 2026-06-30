import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swe206_project/models/machine_model.dart';
import 'package:swe206_project/models/project_model.dart';
import 'package:swe206_project/models/team_model.dart';

class AnalyticsRepository {
  final _db = FirebaseFirestore.instance;

  Future<Map<String, int>> getMostActiveMembers() async {
    final snap = await _db.collection('teams').get();
    final allTeams = snap.docs
        .where((d) => d.data().isNotEmpty)
        .map((d) => TeamModel.fromJson(d.data()))
        .toList();
    final counts = <String, int>{};
    for (final team in allTeams) {
      for (final member in team.members) {
        counts[member.name] = (counts[member.name] ?? 0) + 1;
      }
    }
    return _sortedByValueDesc(counts);
  }

  Future<Map<String, int>> getMostActiveTeams() async {
    final snap = await _db.collection('teams').get();
    final allTeams = snap.docs
        .where((d) => d.data().isNotEmpty)
        .map((d) => TeamModel.fromJson(d.data()))
        .toList();
    return _sortedByValueDesc(
        {for (final t in allTeams) t.name: t.members.length});
  }

  Future<Map<String, int>> getMostActiveProjects() async {
    final snap = await _db.collection('projects').get();
    final allProjects = snap.docs
        .where((d) => d.data().isNotEmpty)
        .map((d) => ProjectModel.fromJson(d.data()))
        .toList();
    return _sortedByValueDesc(
        {for (final p in allProjects) p.name: p.teams.length});
  }

  Future<Map<String, int>> getMostActiveMachines() async {
    final snap = await _db.collection('machines').get();
    final allMachines =
        snap.docs.map((d) => MachineModel.fromJson(d.data())).toList();
    final counts = <String, int>{};
    for (final machine in allMachines) {
      counts[machine.name] = (counts[machine.name] ?? 0) + 1;
    }
    return _sortedByValueDesc(counts);
  }

  Map<String, int> _sortedByValueDesc(Map<String, int> map) {
    final entries = map.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return Map.fromEntries(entries);
  }
}
