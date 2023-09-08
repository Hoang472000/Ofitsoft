import 'package:diary_mobile/data/entity/report/question.dart';

class Answer {
  int? id;
  int? questionId;
  String? value;
  bool? commentAnswer;
  List<Question> questionAndPageIds;

  Answer(
      {this.id,
      this.questionId,
      this.value,
      this.commentAnswer,
      this.questionAndPageIds = const []});

  Answer.copy(Answer other)
      : id = other.id,
        questionId = other.questionId,
        value = other.value,
        commentAnswer = other.commentAnswer,
        questionAndPageIds = List.of(other.questionAndPageIds??[]);

  factory Answer.fromJson(Map<String, dynamic> json,
      {List<Question> questionAndPageIds = const []}) {
    return Answer(
        id: json['id'] ?? -1,
        questionId: json['question_id'] ?? -1,
        value: json['value'] ?? '',
        commentAnswer: json['comment_answer'] ?? false,
        questionAndPageIds: questionAndPageIds);
  }

  factory Answer.fromJson11(Answer json,
      {List<Question> questionAndPageIds = const []}) {
    return Answer(
        id: json.id,
        questionId: json.questionId,
        value: json.value,
        commentAnswer: json.commentAnswer,
        questionAndPageIds: questionAndPageIds);
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question_id'] = questionId;
    data['value'] = value;
    data['comment_answer'] = commentAnswer;
    data['questionAndPageIds'] = questionAndPageIds;
    return data;
  }
}
