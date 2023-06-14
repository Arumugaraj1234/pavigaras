extension StringExt on String? {
  bool isValidMobileNo() => (this ?? "").length == 10;

  bool isValidOtp() => (this ?? "").length == 4;
}

extension NumExtensions on num {
  bool get isInt => (this % 1) == 0;

  String get stringValue {
    if ((this % 1) == 0) {
      return toStringAsFixed(0);
    }
    return toStringAsFixed(2);
  }
}
