import 'package:equatable/equatable.dart';

class ViewModel extends Equatable {
  const ViewModel({required this.articleId, required this.usersId});
  final String articleId;
  final List<dynamic> usersId;

  factory ViewModel.fromJson(Map<String, Object?> json) {
    return ViewModel(
      articleId: json['articleId'] as String,
      usersId: (json['usersId'] as List?) ?? <String>[],
    );
  }

  Map<String, Object> toJson() {
    return {
      'articleId': articleId,
      'usersId': usersId,
    };
  }

  ViewModel copyWith({String? articleId, List<String>? usersId}) {
    return ViewModel(
      articleId: articleId ?? this.articleId,
      usersId: usersId ?? this.usersId,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [usersId, articleId];

  @override
  String toString() {
    return 'userId: $usersId, articleId: $articleId';
  }
}
