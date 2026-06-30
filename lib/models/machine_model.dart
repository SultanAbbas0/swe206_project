class MachineModel {
  late final String name;
  late final DateTime startTime;
  late final DateTime endTime;
  MachineModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> data;
    if (json.containsKey('name')) {
      name = (json['name'] as String?) ?? '';
      data = json;
    } else if (json.isNotEmpty) {
      name = json.keys.first;
      data = (json[json.keys.first] as Map?)
              ?.map((k, v) => MapEntry(k.toString(), v)) ??
          {};
    } else {
      name = '';
      data = {};
    }
    startTime = DateTime.tryParse(data['startTime'] as String? ?? '') ??
        DateTime.now();
    endTime =
        DateTime.tryParse(data['endTime'] as String? ?? '') ?? DateTime.now();
  }
}
