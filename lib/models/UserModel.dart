class UserModel {
  String username;
  String uid;
  String email;
  bool admin;

  UserModel({
    required this.username,
    required this.uid,
    required this.email,
    required this.admin,
  });

  String get getUsername => username;
  String get getEmail => email;
  // from map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] ?? '',
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      admin: map['admin'] ?? false,
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "username": username,
      "uid": uid,
      "email": email,
    };
  }
}
