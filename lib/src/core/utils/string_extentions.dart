///
extension StringExtension on String {
  ///
  // ignore: avoid_bool_literals_in_conditional_expressions, unnecessary_this
  bool isNullOrEmpty() => (this.isEmpty) ? true : false;

  ///
  bool isNotNullOrEmpty() => !isNullOrEmpty();

  ///
  bool isEmailValid() {
    const String emailRegex =
        r"^[\w-]+(?:\.[\w-]+)*@(?:[\w-]+\.)+[a-zA-Z]{2,7}$";
    return RegExp(emailRegex).hasMatch(this);
  }
}
