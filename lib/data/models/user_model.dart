import 'package:fresh_feed/utils/utlis.dart';

class UserModel {
  UserModel({
    required this.uid,
    required this.name,
    this.profileImageUrl,
    this.email,
    this.phoneNumber,
    required this.emailVerified,
    required this.phoneVerified,
    required this.authProvider,
  });
  final String uid;
  final String name;
  final String? profileImageUrl;
  final String? email;
  final String? phoneNumber;
  final bool emailVerified;
  final bool phoneVerified;
  final AuthProviderType authProvider;

  factory UserModel.fromJson(Map<String, Object?> data) {
    return UserModel(
      name: data['name'] as String,
      email: data['email'] as String?,
      profileImageUrl: data['profileImageUrl'] as String?,
      authProvider:
          AuthProviderType.stringToAuthProvider(data['authProvider'] as String),
      emailVerified: data['emailVerified'] as bool? ?? false,
      phoneVerified: data['phoneVerified'] as bool? ?? false,
      phoneNumber: data['phoneNumber'] as String?,
      uid: data['uid'] as String,
    );
  }
  Map<String, Object?> toJson() {
    return {
      'uid': uid,
      'name': name,
      'profileImageUrl': profileImageUrl,
      'email': email,
      'phoneNumber': phoneNumber,
      'emailVerified': emailVerified,
      'phoneVerified': phoneVerified,
      'authProvider': authProvider.name,
    };
  }
}
