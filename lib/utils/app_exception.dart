class FreshFeedException implements Exception {
  const FreshFeedException(
      {required this.message, this.methodInFile, this.details});
  final String message;
  final String? methodInFile;
  final String? details;

  @override
  String toString() {
    return 'FreshFeedException{\nmessage: $message, \nmethodInFile: $methodInFile, \ndetails: $details}';
  }
  // @override
  // String toString() {
  //   return message;
  // }
}
