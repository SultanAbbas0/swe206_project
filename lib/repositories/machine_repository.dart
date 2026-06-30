import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swe206_project/models/machine_model.dart';

class MachineRepository {
  final _db = FirebaseFirestore.instance;

  Future<List<MachineModel>> getMachines() async {
    final snap = await _db.collection('machines').get();
    return snap.docs.map((d) => MachineModel.fromJson(d.data())).toList();
  }

  Future<List<String>> getExistingMachines() async {
    final snap = await _db.collection('existingMachines').get();
    return snap.docs.map((d) {
      final data = d.data();
      if (data.containsKey('name')) return (data['name'] as String?) ?? '';
      if (data.isNotEmpty) return data.keys.first;
      return '';
    }).where((name) => name.isNotEmpty).toSet().toList();
  }

  Future<bool> checkReserved(
      String machineName, DateTime newStart, DateTime newEnd) async {
    final snap = await _db
        .collection('machines')
        .where('name', isEqualTo: machineName)
        .get();
    for (final doc in snap.docs) {
      final data = doc.data();
      final start = DateTime.tryParse(data['startTime'] as String? ?? '');
      final end = DateTime.tryParse(data['endTime'] as String? ?? '');
      if (start == null || end == null) continue;
      if (newStart.isBefore(end) && newEnd.isAfter(start)) return true;
    }
    return false;
  }

  Future<void> reserveMachine(
      String machineName, DateTime start, DateTime end) async {
    await _db.collection('machines').add({
      'name': machineName,
      'startTime': start.toIso8601String(),
      'endTime': end.toIso8601String(),
    });
  }
}
