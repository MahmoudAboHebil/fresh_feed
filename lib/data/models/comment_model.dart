import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CommentModel extends Equatable {
  final String? id;
  final String comment;
  final DateTime dateTime;
  final String? articleId;
  final String userId;
  final DateTime? modifiedDateTime;

  const CommentModel({
    required this.id,
    required this.comment,
    required this.dateTime,
    this.modifiedDateTime,
    required this.articleId,
    required this.userId,
  });

  factory CommentModel.fromJson(dynamic json) {
    try {
      DateTime? modifiedTime =
          (json['modifiedDataTIme'] as Timestamp?)?.toDate();
      DateTime time = (json['dataTime'] as Timestamp).toDate();
      return CommentModel(
        modifiedDateTime: modifiedTime,
        dateTime: time,
        comment: json['comment'],
        id: json['id'],
        articleId: json['articleId'],
        userId: json['userId'],
      );
    } catch (e) {
      rethrow;
    }
  }
  Map<String, Object?> toJson() {
    return {
      "id": id,
      "modifiedDateTime": modifiedDateTime,
      "dateTime": dateTime,
      "comment": comment,
      "articleId": articleId,
      "userId": userId,
    };
  }

  CommentModel copyWith({
    String? comment,
    DateTime? dateTime,
    String? id,
    DateTime? modifiedDateTime,
    String? articleId,
    String? userId,
  }) {
    return CommentModel(
      id: id ?? this.id,
      modifiedDateTime: modifiedDateTime ?? this.modifiedDateTime,
      dateTime: dateTime ?? this.dateTime,
      comment: comment ?? this.comment,
      articleId: articleId ?? this.articleId,
      userId: userId ?? this.userId,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        userId,
        articleId,
        dateTime,
        comment,
        modifiedDateTime,
      ];
}
