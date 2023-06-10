import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.g.dart';
part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    String? token,

    ///
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(false)
    bool isLoggedIn,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.loggedOut() => const _User(token: '', isLoggedIn: false);
}
