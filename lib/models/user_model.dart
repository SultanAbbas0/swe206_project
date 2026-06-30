class UserModel {
  late final String name;
  late final String? status;
  late final String? email;
  UserModel.fromJson(Map<String, dynamic> json) {
    name = (json['name'] as String?) ?? '';
    status = json['status'] as String?;
    email = json['email'] as String?;
  }
}
