class FreshFeedException implements Exception {
  const FreshFeedException(
      {required this.message, this.methodInFile, this.details});
  final String message;
  final String? methodInFile;
  final String? details;
}
