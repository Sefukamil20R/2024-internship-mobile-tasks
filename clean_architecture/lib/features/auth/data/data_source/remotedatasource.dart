import 'dart:convert';
import 'package:clean_architecture/core/constant/constants.dart';
import 'package:clean_architecture/features/auth/data/models/usermodel.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  Future<String> loginUser(String email, String password);
  Future<UserModel> registerUser(String name, String email, String password);
  Future<UserModel> getUserProfile(String accessToken);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl( {required this.client} );

  @override
  Future<String> loginUser(String email, String password) async {
    final url = Uri.parse('${Urls.authUrl}/auth/login');
    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final accessToken = data['data']['access_token'];
      return accessToken; 
    } else {
      throw Exception('Failed to login');
    }
  }
 
  @override
  Future<UserModel> registerUser(String name, String email, String password) async {
    final url = Uri.parse('${Urls.authUrl}/auth/register');
    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );
     print(response.statusCode);
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data['data']);
    } else {
      throw Exception('Failed to register');
    }
  }
  



  @override
  Future<UserModel> getUserProfile(String accessToken) async {
    final url = Uri.parse('${Urls.authUrl}/users/me');
    final response = await client.get(
      url,
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(response.body);
      return UserModel.fromJson(data['data']);
    } else {
      throw Exception('Failed to get user profile');
    }
  }

  }




