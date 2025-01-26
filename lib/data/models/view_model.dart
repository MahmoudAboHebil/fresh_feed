import 'package:equatable/equatable.dart';

class ViewModel extends Equatable {
  const ViewModel({required this.articleId, required this.usersId});
  final String articleId;
  final List<String> usersId;

  factory ViewModel.fromJson(Map<String, Object?> json) {
    final listOfDynamic = json['usersId'] as List?;
    return ViewModel(
      articleId: json['articleId'] as String,
      usersId:
          listOfDynamic != null ? listOfDynamic.cast<String>() : <String>[],
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
  List<Object> get props => [Set.from(usersId), articleId];

  @override
  String toString() {
    return 'userId: $usersId, articleId: $articleId';
  }
}
