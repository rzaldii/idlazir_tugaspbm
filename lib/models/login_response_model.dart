import 'user_model.dart';

class LoginResponseModel {
  final String token;
  final UserModel? user;

  LoginResponseModel({
    required this.token,
    this.user,
  });

  factory LoginResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return LoginResponseModel(
      token: json['data']['token'] ?? '',
      user: json['data']['user'] != null
          ? UserModel.fromJson(json['data']['user'])
          : null,
    );
  }
}