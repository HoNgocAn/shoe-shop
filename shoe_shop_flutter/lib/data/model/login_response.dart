class LoginResponse {
  final String accessToken;
  final String refreshToken;
  final String username;
  final int id;
  final int? group;

  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.username,
    required this.id,
    required this.group,
  });

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      accessToken: map['access_token'],
      refreshToken: map['refresh_token'],
      username: map['username'],
      id: map['id'],
      group: map['group'] is int ? map['group'] : null,
    );
  }
}