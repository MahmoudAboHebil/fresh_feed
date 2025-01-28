import 'package:equatable/equatable.dart';

class CommentModel extends Equatable {
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
    // comment-*%+-userUid%dataTime
    try {
      List<String> list = letter.split('-*%+-');
      List<String> list2 = list[1].split('%');
      String comment = list[0];
      print('==========================>');
      print(list2[1]);
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

  CommentModel copyWith({
    String? comment,
    DateTime? dateTime,
    String? articleId,
    String? userId,
  }) {
    return CommentModel(
      comment: comment ?? this.comment,
      dateTime: dateTime ?? this.dateTime,
      articleId: articleId ?? this.articleId,
      userId: userId ?? this.userId,
    );
  }

  String toJson(CommentModel model) {
    return '${model.comment}-*%+-${model.userId}%${model.dateTime.toIso8601String()}';
  }

  @override
  // TODO: implement props
  List<Object> get props => [userId, articleId, dateTime, comment];
}
