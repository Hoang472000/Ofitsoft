import 'package:diary_mobile/data/entity/report/question.dart';

class Answer {
  int? id;
  int? questionId;
  int? parentColId;
  String? value;
  bool? commentAnswer;
  List<Question> questionAndPageIds;
  List<Answer> suggestedAnswerIds;

  Answer({
    this.id,
    this.questionId,
    this.parentColId,
    this.value,
    this.commentAnswer,
    this.questionAndPageIds = const [],
    this.suggestedAnswerIds = const [],
  });

  Answer.copy(Answer other)
      : id = other.id,
        questionId = other.questionId,
        parentColId = other.parentColId,
        value = other.value,
        commentAnswer = other.commentAnswer,
        questionAndPageIds = List.of(other.questionAndPageIds ?? []),
        suggestedAnswerIds = List.of(other.suggestedAnswerIds ?? []);

  factory Answer.fromJson(Map<String, dynamic> json,
      {List<Question> questionAndPageIds = const [],
      List<Answer> suggestedAnswerIds = const []}) {
    return Answer(
      id: json['id'] ?? -1,
      questionId: json['question_id'] ?? -1,
      parentColId: json['parent_col_id'] ?? -1,
      value: json['value'] ?? '',
      commentAnswer: json['comment_answer'] ?? false,
      questionAndPageIds: questionAndPageIds,
      suggestedAnswerIds: suggestedAnswerIds,
    );
  }

  factory Answer.fromJson11(Answer json,
      {List<Question> questionAndPageIds = const [],
      List<Answer> suggestedAnswerIds = const []}) {
    return Answer(
      id: json.id,
      questionId: json.questionId,
      parentColId: json.parentColId,
      value: json.value,
      commentAnswer: json.commentAnswer,
      questionAndPageIds: questionAndPageIds,
      suggestedAnswerIds: suggestedAnswerIds,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question_id'] = questionId;
    data['parent_col_id'] = parentColId;
    data['value'] = value;
    data['comment_answer'] = commentAnswer;
    data['questionAndPageIds'] = questionAndPageIds;
    data['suggestedAnswerIds'] = suggestedAnswerIds;
    return data;
  }
}