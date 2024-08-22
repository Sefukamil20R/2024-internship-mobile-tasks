import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDataSource {
  Future<void> saveAccessToken( String token);
  Future<String?> getAccessToken();
  Future<void> deleteAccessToken();
}
class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserLocalDataSourceImpl({ required this.sharedPreferences});

  @override
  Future<void> saveAccessToken( String token) async {
    await sharedPreferences.setString('access_token', token);
  }

  @override
  Future<String?> getAccessToken() async {
    return sharedPreferences.getString('access_token');
  }

  @override
  Future<void> deleteAccessToken() async {
    await sharedPreferences.remove('access_token');
  }
}