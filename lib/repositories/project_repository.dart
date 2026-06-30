import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swe206_project/models/project_model.dart';

class ProjectRepository {
  final _db = FirebaseFirestore.instance;

  Future<List<ProjectModel>> getProjects() async {
    final snap = await _db.collection('projects').get();
    return snap.docs
        .where((d) => d.data().isNotEmpty)
        .map((d) => ProjectModel.fromJson(d.data()))
        .toList();
  }

  Future<void> addProject(
      String projectName, String projectLeader, List teams) async {
    final teamsList = teams.cast<String>();
    await _db.collection('projects').add({
      'name': projectName,
      'leader': projectLeader,
      'teams': teamsList,
      'machines': [],
    });
    final teamSnap = await _db.collection('teams').get();
    for (final doc in teamSnap.docs) {
      final data = doc.data();
      if (data.containsKey('leader')) {
        if (teamsList.contains(data['name'] as String?)) {
          await doc.reference.update({'project': projectName});
        }
      } else if (data.isNotEmpty) {
        final teamName = data.keys.first;
        if (teamsList.contains(teamName)) {
          await doc.reference.update({'$teamName.project': projectName});
        }
      }
    }
  }

  Future<void> updateProjectTeams(
      String projectName, List<String> newTeams) async {
    final snap = await _db.collection('projects').get();
    for (final doc in snap.docs) {
      final data = doc.data();
      if (data.containsKey('leader')) {
        if ((data['name'] as String?) == projectName) {
          await doc.reference.update({'teams': newTeams});
          break;
        }
      } else if (data.isNotEmpty) {
        final name = data.keys.first;
        if (name == projectName) {
          await doc.reference.update({'$name.teams': newTeams});
          break;
        }
      }
    }
    final teamSnap = await _db.collection('teams').get();
    for (final doc in teamSnap.docs) {
      final data = doc.data();
      if (data.containsKey('leader')) {
        final teamName = data['name'] as String? ?? '';
        if (newTeams.contains(teamName)) {
          if ((data['project'] as String?) != projectName) {
            await doc.reference.update({'project': projectName});
          }
        } else if ((data['project'] as String?) == projectName) {
          await doc.reference.update({'project': null});
        }
      } else if (data.isNotEmpty) {
        final teamName = data.keys.first;
        final teamData = (data[teamName] as Map?)
                ?.map((k, v) => MapEntry(k.toString(), v)) ??
            {};
        if (newTeams.contains(teamName)) {
          if ((teamData['project'] as String?) != projectName) {
            await doc.reference.update({'$teamName.project': projectName});
          }
        } else if ((teamData['project'] as String?) == projectName) {
          await doc.reference.update({'$teamName.project': null});
        }
      }
    }
  }

  Future<void> reserveForProject(
      String projectName, String machineName, String reservation) async {
    if (projectName.isEmpty) return;
    final snap = await _db.collection('projects').get();
    for (final doc in snap.docs) {
      final data = doc.data();
      if (data.containsKey('leader')) {
        if ((data['name'] as String?) == projectName) {
          await doc.reference.update({
            'machines': FieldValue.arrayUnion([machineName]),
          });
          return;
        }
      } else if (data.containsKey(projectName)) {
        await doc.reference.update({
          '$projectName.machines': FieldValue.arrayUnion([machineName]),
        });
        return;
      }
    }
  }
}
