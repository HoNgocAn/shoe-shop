class AppValidator{

  String? validateUser(value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter a username";
    }

    final trimmed = value.trim();

    if (trimmed.length < 6) {
      return "Username must be at least 6 characters";
    }

    if (trimmed.length > 30) {
      return "Username must be at most 30 characters";
    }
    RegExp usernameRegExp = RegExp(
      r'^[a-zA-Z0-9_]+$',
    );
    if (!usernameRegExp.hasMatch(value)) {
      return "Username can only contain letters, numbers, and underscores";
    }
    return null;
  }

  String? validatePassword(value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter a password";
    }

    final trimmed = value.trim();

    if (trimmed.length < 6) {
      return "Password must be at least 6 characters";
    }

    if (trimmed.length > 30) {
      return "Password must be at most 30 characters";
    }
    return null;
  }

  String? validateRePassword(String? rePassword, String originalPassword) {
    final error = validatePassword(rePassword);
    if (error != null) return error;

    if (rePassword != originalPassword) return 'Passwords do not match';
    return null;
  }

  String? isEmptyCheck(String? value) {
    if (value == null || value.isEmpty) {
      return "Please fill details";
    }
    return null;
  }

}