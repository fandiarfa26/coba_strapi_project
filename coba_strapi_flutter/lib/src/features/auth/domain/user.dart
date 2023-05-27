import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class UserResponse with _$UserResponse {
  factory UserResponse({
    required String jwt,
    required UserModel user,
  }) = _UserResponse;

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
}

@freezed
class UserModel with _$UserModel {
  factory UserModel({
    required int id,
    required String username,
    required String email,
    required String provider,
    required bool confirmed,
    required bool blocked,
    required String createdAt,
    required String updatedAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
