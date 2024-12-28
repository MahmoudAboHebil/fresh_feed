class User {
  const User({
    required this.name,
    required this.isLoggedByPhoneNum,
    this.email,
    this.profileImageUrl,
  });
  final String name;
  final String? email;

  // final String? password; not recommended for security
  final String? profileImageUrl;
  final bool isLoggedByPhoneNum;

  factory User.fromJson(Map<String, Object?> data) {
    return User(
      name: data['name'] as String,
      isLoggedByPhoneNum: data['isLoggedByPhoneNum'] as bool,
      email: data['email'] as String?,
      profileImageUrl: data['profileImageUrl'] as String?,
    );
  }
  Map<String, Object?> toJson() {
    return {
      'name': name,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'isLoggedByPhoneNum': isLoggedByPhoneNum,
    };
  }
}
