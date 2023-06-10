part of 'repos.dart';

class UserRepo {
  UserRepo._();
  static final instance = UserRepo._();

  Future<User> login(String username, String password) async {
    final response = await fetch.post(
      '/auth/login',
      jsonEncode({'username': username, 'password': password}),
    );

    if (!response.isOk) {
      throw response.data;
    }

    final user = User.fromJson(response.data);

    Globals.pc.read(userPod.notifier).login(user);

    Storage.instance.setJson(StorageKeys.user_info, user.toJson());
    Storage.instance.setJson(StorageKeys.auth_data, {
      'username': username,
      'password': password,
    });

    return user;
  }
}
