class UserAccount {
  final int id;
  final String username;
  final String group;
  final String accessToken;

  UserAccount({
    required this.id,
    required this.username,
    required this.group,
    required this.accessToken,
  });

  factory UserAccount.fromMap(Map<String, dynamic> map) {
    return UserAccount(
      id: map['id'] ?? 0,
      username: map['username'] ?? '',
      group: map['group'] ?? '',
      accessToken: map['access_token'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'group': group,
      'access_token': accessToken,
    };
  }
}