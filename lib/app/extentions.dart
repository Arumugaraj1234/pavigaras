extension StringExt on String? {
  bool isValidMobileNo() => (this ?? "").length == 10;

  bool isValidOtp() => (this ?? "").length == 4;
}
