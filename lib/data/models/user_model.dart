import 'package:equatable/equatable.dart';
import 'package:fresh_feed/utils/utlis.dart';

class UserModel extends Equatable {
  const UserModel({
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
    try {
      return UserModel(
        name: data['name'] as String,
        email: data['email'] as String?,
        profileImageUrl: data['profileImageUrl'] as String?,
        authProvider: AuthProviderType.stringToAuthProvider(
            data['authProvider'] as String),
        emailVerified: data['emailVerified'] as bool? ?? false,
        phoneVerified: data['phoneVerified'] as bool? ?? false,
        phoneNumber: data['phoneNumber'] as String?,
        uid: data['uid'] as String,
      );
    } catch (e) {
      rethrow;
    }
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

  UserModel copyWith({
    String? uid,
    String? name,
    String? profileImageUrl,
    String? email,
    String? phoneNumber,
    bool? emailVerified,
    bool? phoneVerified,
    AuthProviderType? authProvider,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      emailVerified: emailVerified ?? this.emailVerified,
      phoneVerified: phoneVerified ?? this.phoneVerified,
      authProvider: authProvider ?? this.authProvider,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      email: email ?? this.email,
    );
  }

  @override
  String toString() {
    return 'UserModel{\nuid: $uid, name: $name,\nprofileImageUrl: $profileImageUrl, email: $email,\n phoneNumber: $phoneNumber, emailVerified: $emailVerified, \nphoneVerified: $phoneVerified, authProvider: $authProvider\n}';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        uid,
        name,
        profileImageUrl,
        email,
        phoneNumber,
        emailVerified,
        phoneVerified,
        authProvider,
      ];
}
