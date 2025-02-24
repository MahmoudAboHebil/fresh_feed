import 'package:equatable/equatable.dart';
import 'package:fresh_feed/utils/utlis.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.uid,
    required this.name,
    this.profileImageUrl,
    this.email,
    this.phoneNumber,
    this.phoneIsoCode,
    this.phoneDialCode,
    required this.emailVerified,
    required this.phoneVerified,
    required this.authProvider,
  });
  final String uid;
  final String name;
  final String? profileImageUrl;
  final String? email;
  final String? phoneNumber;
  final String? phoneIsoCode;
  final String? phoneDialCode;
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
        phoneIsoCode: data['phoneIsoCode'] as String?,
        phoneDialCode: data['phoneDialCode'] as String?,
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
      'phoneIsoCode': phoneIsoCode,
      'phoneDialCode': phoneDialCode,
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
    String? phoneIsoCode,
    String? phoneDialCode,
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
      phoneIsoCode: phoneIsoCode ?? this.phoneIsoCode,
      phoneDialCode: phoneDialCode ?? this.phoneDialCode,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      email: email ?? this.email,
    );
  }

  @override
  String toString() {
    return 'UserModel{\nuid: $uid, name: $name,\nprofileImageUrl: $profileImageUrl, email: $email,\n phoneNumber: $phoneNumber,\n phoneIsoCode: $phoneIsoCode,\n phoneDialCode: $phoneDialCode, emailVerified: $emailVerified, \nphoneVerified: $phoneVerified, authProvider: $authProvider\n}';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        uid,
        name,
        profileImageUrl,
        email,
        phoneNumber,
        phoneIsoCode,
        phoneDialCode,
        emailVerified,
        phoneVerified,
        authProvider,
      ];
}
