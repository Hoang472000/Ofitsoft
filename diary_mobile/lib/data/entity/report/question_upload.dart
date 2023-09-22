class QuestionUpload {
  int? user_input_id;
  int? survey_id;
  int? question_id;
  int? question_sequence;
  int? suggested_answer_id;
  int? matrix_row_id;
  String? answer_type;
  String? value_text;
  int? value_number;
  bool? skipped;
  bool? answer_is_correct;
  String? create_date;

  bool? test_entry; // default = false
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
  bool? is_answer_exist;
  bool? value_check_box;
  int? table_row_id;
  List<int>? list_id_suggested;

  //
  int? farmer_id;
  int? farmer_code;
  int? internal_inspector_id;
  String? monitoring_visit_type;
  String? visit_date;

  QuestionUpload({
    this.user_input_id, this.survey_id, this.question_id, this.question_sequence, this.suggested_answer_id,
    this.matrix_row_id, this.answer_type, this.value_text, this.value_number, this.skipped,
    this.answer_is_correct, this.create_date, this.test_entry, this.start_datetime, this.end_datetime, this.state,
    this.answer_score, this.message_main_attachment_id, this.last_displayed_page_id, this.deadline,
    this.scoring_percentage, this.scoring_total, this.scoring_success, this.is_session_answer,
    this.is_answer_exist, this.value_check_box, this.table_row_id, this.list_id_suggested,
    this.farmer_id, this.farmer_code, this.internal_inspector_id, this.monitoring_visit_type, this.visit_date
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
    data['value_text'] = value_text;
    data['value_number'] = value_number;
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
    data['is_answer_exist'] = is_answer_exist;

    data['value_check_box'] = true;
    data['table_row_id'] = table_row_id;
    data['list_id_suggested'] = list_id_suggested;

    //
    data['farmer_id'] = farmer_id;
    data['farmer_code'] = farmer_code;
    data['internal_inspector_id'] = internal_inspector_id;
    data['monitoring_visit_type'] = monitoring_visit_type;
    data['visit_date'] = visit_date;
    return data;
  }
}

class FarmerInspectorUpload {
  int? id;
  int? farmer_id;
  int? farmer_code;
  int? internal_inspector_id;
  String? monitoring_visit_type;
  String? visit_date;

  FarmerInspectorUpload(
      {this.id,
      this.farmer_id,
      this.farmer_code,
      this.internal_inspector_id,
      this.monitoring_visit_type,
      this.visit_date});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['farmer_id'] = farmer_id;
    data['farmer_code'] = farmer_code;
    data['internal_inspector_id'] = internal_inspector_id;
    data['monitoring_visit_type'] = monitoring_visit_type;
    data['visit_date'] = visit_date;
    return data;
  }

}
