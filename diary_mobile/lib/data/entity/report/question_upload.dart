class QuestionUpload {
  int? user_input_id;
  int? survey_id;
  int? question_id;
  int? question_sequence;
  int? suggested_answer_id;
  int? matrix_row_id;
  String? answer_type;
  String? value_char_box;
  String? value_date;
  String? value_text_box;
  int? value_numerical_box;
  String? value_datetime;
  String? value_comment_answer;
  String? value_row_table;
  bool? skipped;
  bool? answer_is_correct;
  String? create_date;

  bool? test_entry;// default = false
  String? start_datetime;
  String? end_datetime;
  String? state; // submit upload done or progress
  //
  int? answer_score;
  int? message_main_attachment_id;
  int? last_displayed_page_id;
  String? deadline;
  bool? scoring_percentage;
  int? scoring_total;
  int? scoring_success;
  bool? is_session_answer;
  //
  QuestionUpload({
    this.user_input_id, this.survey_id, this.question_id, this.question_sequence, this.suggested_answer_id,
    this.matrix_row_id, this.answer_type, this.value_char_box, this.value_date, this.value_text_box,
    this.value_numerical_box, this.value_datetime, this.value_comment_answer, this.value_row_table, this.skipped,
    this.answer_is_correct, this.create_date, this.test_entry, this.start_datetime, this.end_datetime, this.state,
    this.answer_score, this.message_main_attachment_id, this.last_displayed_page_id, this.deadline,
    this.scoring_percentage, this.scoring_total, this.scoring_success, this.is_session_answer
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_input_id'] = user_input_id;
    data['survey_id'] = survey_id;
    data['question_id'] = question_id;
    data['question_sequence'] = question_sequence;
    data['suggested_answer_id'] = suggested_answer_id;

    data['matrix_row_id'] = matrix_row_id;
    data['answer_type'] = answer_type;
    data['value_char_box'] = value_char_box;
    data['value_date'] = value_date;
    data['value_text_box'] = value_text_box;

    data['value_numerical_box'] = value_numerical_box;
    data['value_datetime'] = value_datetime;
    data['value_comment_answer'] = value_comment_answer;
    data['value_row_table'] = value_row_table;
    data['skipped'] = skipped;

    data['answer_is_correct'] = answer_is_correct;
    data['create_date'] = create_date;
    data['test_entry'] = test_entry;
    data['start_datetime'] = start_datetime;
    data['end_datetime'] = end_datetime;
    data['state'] = state;

    data['answer_score'] = answer_score;
    data['message_main_attachment_id'] = message_main_attachment_id;
    data['last_displayed_page_id'] = last_displayed_page_id;
    data['deadline'] = deadline;

    data['scoring_percentage'] = scoring_percentage;
    data['scoring_total'] = scoring_total;
    data['scoring_success'] = scoring_success;
    data['is_session_answer'] = is_session_answer;
    return data;
  }
}
