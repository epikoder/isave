RegExp emailRegExp =
    RegExp(r"^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
RegExp numberRegExp = RegExp(r'^[0-9]+$');

String? emailValidator(String? value) {
  return value!.isEmpty
      ? 'Email required'
      : !emailRegExp.hasMatch(value.trim())
          ? 'Invalid email address'
          : null;
}

String? nameValidator(String? value) {
  return value!.isEmpty
      ? 'Name required'
      : value.trim().length < 4
          ? 'Invalid Name'
          : null;
}

String? passwordValidator(String? value) {
  return value!.isEmpty
      ? 'Password required'
      : value.trim().length < 4
          ? 'Password too short'
          : null;
}

String? kinValidator(String? value) {
  return value!.isEmpty
      ? 'Kin required'
      : value.trim().length < 4
          ? 'Kin too short'
          : null;
}

String? bvnValidator(String? value) {
  return value!.isEmpty
      ? 'BVN required'
      : !numberRegExp.hasMatch(value.trim())
          ? "Invalid BVN"
          : value.trim().length != 11
              ? 'BVN wrong length'
              : null;
}

String? ninValidator(String? value) {
  return value!.isEmpty
      ? 'NIN required'
      : !numberRegExp.hasMatch(value.trim())
          ? "Invalid NIN"
          : value.trim().length != 10
              ? 'NIN wrong length'
              : null;
}

String? addressValidator(String? value) {
  return value!.isEmpty
      ? 'Address required'
      : value.trim().length < 2
          ? 'Address too short'
          : null;
}

String? numberValidator(String? value) {
  return value!.isEmpty
      ? 'required'
      : !numberRegExp.hasMatch(value.trim())
          ? 'invalid character'
          : null;
}
