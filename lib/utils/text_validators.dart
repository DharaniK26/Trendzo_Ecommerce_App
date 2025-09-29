class TextFieldValidation {
  static String? mailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    } else if (value.trim().isNotEmpty &&
        !RegExp(
          r"^[a-z0-9.a-z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-z0-9]+\.[a-z]+",
        ).hasMatch(value)) {
      return 'Please enter a valid email';
    } else {
      return null;
    }
  }

}