import 'dart:io';

import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/models/account.dart';
import 'package:masterstudy_app/data/network/api_provider.dart';

abstract class AccountRepository {
  Future<Account> getUserAccount();

  Future<Account> getAccountById(int userId);

  Future editProfile(String firstName, String lastName, String password,
      String description, String position, String facebook, String twitter,
      String instagram,
      {File photo});
}

@provide
class AccountRepositoryImpl implements AccountRepository {
  final UserApiProvider _apiProvider;

  AccountRepositoryImpl(this._apiProvider);

  @override
  Future<Account> getAccountById(int accountId) {
    return _apiProvider.getAccount(accountId: accountId);
  }

  @override
  Future<Account> getUserAccount() {
    return _apiProvider.getAccount();
  }

  @override
  Future editProfile(String firstName, String lastName, String password,
      String description, String position, String facebook, String twitter,String instagram,
      {File photo}) async {
    await _apiProvider.editProfile(firstName, lastName, password, description,
        position, facebook, instagram, twitter);
    if (photo != null) await _apiProvider.uploadProfilePhoto(photo);
  }
}
