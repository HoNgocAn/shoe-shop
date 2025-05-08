import 'dart:convert';

import '../../constants/app_constants.dart';
import '../model/login_response.dart';
import "package:http/http.dart" as http;

import '../model/user_account.dart';

abstract interface class DataSource {
  Future<LoginResponse?> login(String username, String password);
  Future<bool> register(String username, String password);
  Future<UserAccount?> getAccount(String token);
  Future<void> logout(String refreshToken);
}

class AuthSource implements DataSource {

  @override
  Future<LoginResponse?> login(String username, String password) async {

    try {
      final String url = '${AppConstants.baseUrl}${AppConstants.loginEndpoint}';
      final uri = Uri.parse(url);
      final rs = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'valueLogin': username,
          'password': password,
        }),
      );

      if (rs.statusCode == 200) {
        final bodyContent = utf8.decode(rs.bodyBytes);
        final Map<String, dynamic> data = jsonDecode(bodyContent);

        if (data['EC'] == 0) {
          print("Login Successful");
          final userMap = data['DT'] as Map<String, dynamic>;
          final loginResponse = LoginResponse.fromMap(userMap);
          return loginResponse;
        } else {
          print("Login failed: ${data['EM']}");
          return null;
        }
      } else {
        print('HTTP Error: ${rs.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error during login: $e');
      return null;
    }
  }


  @override
  Future<bool> register(String username, String password) async {
    try {
      final String url = '${AppConstants.baseUrl}${AppConstants.registerEndpoint}';
      final uri = Uri.parse(url);
      final rs = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (rs.statusCode == 200 || rs.statusCode == 201) {
        final bodyContent = utf8.decode(rs.bodyBytes);
        final Map<String, dynamic> data = jsonDecode(bodyContent);

        if (data['EC'] == 0) {
          print("Create  new account successful");
          return true;
        } else {
          print("Register failed: ${data['EM']}");
          return false;
        }
      } else {
        print('HTTP Error: ${rs.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error during register: $e');
      return false;
    }
  }

  @override
  Future<void> logout(String refreshToken) async {
    try {
      final String url = '${AppConstants.baseUrl}${AppConstants.logoutEndpoint}';
      final uri = Uri.parse(url);
      final response = await http.delete(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'refreshToken': refreshToken,
        }),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(utf8.decode(response.bodyBytes));
        if (body['EC'] == 0) {
          print('Logout successful');
        } else {
          print('Logout fail;: ${body['EM']}');
        }
      } else {
        print('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error : $e');
    }
  }

  @override
  Future<UserAccount?> getAccount(String token) async {
    try {
      final String url = '${AppConstants.baseUrl}${AppConstants.accountEndpoint}';
      final uri = Uri.parse(url);

      final rs = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (rs.statusCode == 200) {
        final bodyContent = utf8.decode(rs.bodyBytes);
        final Map<String, dynamic> data = jsonDecode(bodyContent);

        if (data['EC'] == 0) {
          final accountMap = data['DT'] as Map<String, dynamic>;
          return UserAccount.fromMap(accountMap);
        } else {
          print("Get account failed: ${data['EM']}");
          return null;
        }
      } else {
        print('HTTP Error: ${rs.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error getting account: $e');
      return null;
    }
  }
}