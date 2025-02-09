class GeneralFunctions {
  const GeneralFunctions._();
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    if (password.length < 8) {
      return "Password must be at least 8 characters long.";
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return "Password must contain at least one uppercase letter.";
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return "Password must contain at least one lowercase letter.";
    }
    if (!RegExp(r'\d').hasMatch(password)) {
      return "Password must contain at least one digit.";
    }
    if (!RegExp(r'[@$!%*?&]').hasMatch(password)) {
      return "Password must contain at least one special character (@\$!%*?&).";
    }
    return null;
  }

  static String? nameValidator(String? name) {
    final nameRegex = RegExp(
        r"^[A-Za-zÀ-ÖØ-öø-ÿ\u0600-\u06FF\u0400-\u04FF\u4E00-\u9FFF\u3040-\u30FF' -]{2,50}$");
    if (name == null || name.isEmpty || name.trim().isEmpty) {
      return 'Name is required';
    }

    if (name.length < 2) {
      return "Password must be at least 2 characters long.";
    }
    if (name.length > 50) {
      return "Name must be at most 50 characters long.";
    }
    if (!nameRegex.hasMatch(name)) {
      return "Invalid name format. Use only letters, spaces, hyphens, or apostrophes.";
    }
    return null;
  }
}
