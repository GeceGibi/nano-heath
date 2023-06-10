import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nano/models/models.dart';
import 'package:nano/services/services.dart';

final userPod = StateNotifierProvider<UserPodState, User>(
  (ref) => UserPodState(),
);

class UserPodState extends StateNotifier<User> {
  UserPodState()
      : super(Storage.instance.contains(StorageKeys.user_info)
            ? User.fromJson(Storage.instance.getJsonMap(StorageKeys.user_info))
                .copyWith(isLoggedIn: true)
            : User.loggedOut());

  void login(User user) {
    state = user.copyWith(isLoggedIn: true);
  }

  void logout() {
    state = User.loggedOut();
  }
}
