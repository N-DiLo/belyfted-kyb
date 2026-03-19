class Validators {
  static String? isValidEmail(String? email) {
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    if (email == null || email.isEmpty) {
      return 'Email cannot be empty';
    }
    if (!emailRegex.hasMatch(email)) {
      return 'Email address is not valid';
    }
    return null;
  }

  static String? isNotEmpty(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? isValidPhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    final regex = RegExp(r'^\+?[0-9]{7,15}$');
    if (!regex.hasMatch(value.trim())) return 'Enter a valid phone number';
    return null;
  }

  static bool isValidUrl(String value) {
    final regex = RegExp(
      r'^(https?:\/\/)?([\w-]+(\.[\w-]+)+)(\/[\w\-./?%&=]*)?$',
      caseSensitive: false,
    );
    return regex.hasMatch(value.trim());
  }
}
