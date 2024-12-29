import 'app_exception.dart';

enum AuthProviderType {
  email,
  phone,
  google;

  static AuthProviderType stringToAuthProvider(String authProvider) {
    try {
      return AuthProviderType.values
          .firstWhere((auth) => (auth.name == authProvider));
    } catch (e) {
      throw FreshFeedException(
          message: 'Oops! Something went wrong.',
          methodInFile: 'stringToAuthProvider()/AuthProvider',
          details: e.toString());
    }
  }
}
