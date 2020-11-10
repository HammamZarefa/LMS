import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/models/auth.dart';
import 'package:masterstudy_app/data/network/api_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthRepository {
  Future authUser(String login, String password);

  Future register(String login, String email, String password);

  Future<String> getToken();

  Future<bool> isSigned();

  Future logout();
}

@provide
@singleton
class AuthRepositoryImpl extends AuthRepository {
  final UserApiProvider provider;
  final SharedPreferences _sharedPreferences;
  static const tokenKey = "apiToken";

  AuthRepositoryImpl(this.provider, this._sharedPreferences);

  @override
  Future authUser(String login, String password) async {
    AuthResponse response = await provider.authUser(login, password);
    _saveToken(response.token);
  }

  @override
  Future register(String login, String email, String password) async {
    AuthResponse response = await provider.signUpUser(login, email, password);
    _saveToken(response.token);
  }

  @override
  Future<String> getToken() {
    return Future.value(_sharedPreferences.getString(tokenKey));
  }

  void _saveToken(String token) {
    _sharedPreferences.setString(tokenKey, token);
  }

  @override
  Future<bool> isSigned() {
    var token = _sharedPreferences.getString(tokenKey);
    if (token != null && token.isNotEmpty) return Future.value(true);
    return Future.value(false);
  }

  @override
  Future logout() async{
    _sharedPreferences.setString("apiToken", "");
  }
}
