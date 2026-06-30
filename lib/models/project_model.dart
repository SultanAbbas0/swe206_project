class ProjectModel {
  late final String name;
  late final String leader;
  final List<String> teams = [];
  final List<String> machines = [];
  ProjectModel.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) { name = ''; leader = ''; return; }
    final Map<String, dynamic> data;
    if (json.containsKey('leader')) {
      name = (json['name'] as String?) ?? '';
      data = json;
    } else {
      name = json.keys.first;
      data = json[json.keys.first] as Map<String, dynamic>;
    }
    leader = (data['leader'] as String?) ?? '';
    for (final team in data['teams'] as List? ?? []) {
      teams.add(team as String);
    }
    for (final machine in data['machines'] as List? ?? []) {
      machines.add(machine as String);
    }
  }
}
