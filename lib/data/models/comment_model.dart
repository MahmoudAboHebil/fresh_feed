class CommentModel {
  final String comment;
  final DateTime dateTime;
  final String articleId;
  final String userId;

  const CommentModel({
    required this.comment,
    required this.dateTime,
    required this.articleId,
    required this.userId,
  });

  factory CommentModel.fromJson(String letter, String articleId) {
    // comment-*%+-userUid-dataTime
    try {
      List<String> list = letter.split('-*%+-');
      List<String> list2 = list[1].split('-');
      String comment = list[0];
      DateTime dateTime = DateTime.parse(list2[1]);
      String userId = list2[0];
      return CommentModel(
        comment: comment,
        dateTime: dateTime,
        articleId: articleId,
        userId: userId,
      );
    } catch (e) {
      rethrow;
    }
  }
  String toJson(CommentModel model) {
    return '${model.comment}-*%+-${model.userId}-${model.dateTime.toIso8601String()}';
  }
}
