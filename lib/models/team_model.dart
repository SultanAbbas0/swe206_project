import 'package:swe206_project/models/user_model.dart';

class TeamModel {
  late final String name;
  late final String leader;
  late final String? project;
  final List<UserModel> members = [];
  TeamModel.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) { name = ''; leader = ''; project = null; return; }
    final Map<String, dynamic> data;
    if (json.containsKey('leader')) {
      name = (json['name'] as String?) ?? '';
      data = json;
    } else {
      name = json.keys.first;
      data = json[json.keys.first] as Map<String, dynamic>;
    }
    leader = (data['leader'] as String?) ?? '';
    project = data['project'] as String?;
    for (final element in data['members'] as List? ?? []) {
      members.add(UserModel.fromJson(
          (element as Map).map((k, v) => MapEntry(k.toString(), v))));
    }
  }
}
