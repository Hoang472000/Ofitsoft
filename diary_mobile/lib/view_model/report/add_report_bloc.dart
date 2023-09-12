import 'package:diary_mobile/data/entity/item_default/activity.dart';
import 'package:diary_mobile/data/entity/item_default/tool.dart';
import 'package:diary_mobile/data/entity/item_default/unit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/entity/activity/activity_diary.dart';
import '../../../data/entity/diary/diary.dart';
import '../../../data/entity/item_default/material_entity.dart';
import '../../../data/local_data/diary_db.dart';
import '../../../data/repository.dart';
import '../../data/entity/report/answer.dart';
import '../../data/entity/report/question.dart';
import '../../data/entity/report/report.dart';
import '../../utils/status/form_submission_status.dart';
import '../bloc_event.dart';
import '../bloc_state.dart';

class AddReportBloc extends Bloc<AddReportEvent, AddReportState> {
  final Repository repository;

  AddReportBloc(this.repository) : super(AddReportState()) {
    on<GetAddReportEvent>(_getAddReport);
  }

  void _getAddReport(
      GetAddReportEvent event, Emitter<AddReportState> emitter) async {
    emitter(state.copyWith(isShowProgress: true));
    final report = await repository.getListActivityReport();
    //print("HoangCV: report: result: ${report[0].questionAndPageIds[0].toJson()}");
    /* report[0].questionAndPageIds[0].questionAndPageIds.forEach((element) {

      print("HoangCV: report: elemetn: ${element.toJson()}");
    });*/
    List<List<Select>> listSelected = [];
    if (report.isNotEmpty) {
      listSelected = createSelectLists(report[0].questionAndPageIds);
      listSelected.forEach((element) {
        print("HoangCV:listSelected:  ${element.length} : ${element[0].id}");
      });
    }
    emitter(state.copyWith(
      isShowProgress: false,
      detailDiary: event.diary,
      listReport: report,
      listSelected: listSelected,
    ));
  }

  List<List<Select>> createSelectLists(List<Question> questions) {
    List<List<Select>> selectLists = [];

    for (Question question in questions) {
      List<Select> selectList = [];

      // Thêm Select cho câu hỏi cha
      selectList.add(Select(question.id!, false, question.title!));

      // Gọi hàm đệ quy để thêm Select cho câu hỏi và câu trả lời con
      initSelectValues(question, selectList);

      selectLists.add(selectList);
    }

    return selectLists;
  }

  void initSelectValues(dynamic item, List<Select> selectList) {
    if (item is Question) {
      // Gọi hàm đệ quy cho danh sách câu trả lời con
      for (Answer answer in item.suggestedAnswerIds) {
        print("HoangCV: Question:1 ${item.title} : ${answer.value} : ${answer.id}");
        selectList.add(Select(answer.id!, false, answer.value!)); // Thêm Select cho câu trả lời con
        initSelectValues(answer, selectList);
      }

      // Gọi hàm đệ quy cho danh sách câu hỏi con
      for (Question childQuestion in item.questionAndPageIds) {
        selectList.add(Select(childQuestion.id!, false, childQuestion.title!)); // Thêm Select cho câu hỏi con
        initSelectValues(childQuestion, selectList);
      }
    } else if (item is Answer) {
      // Gọi hàm đệ quy cho danh sách câu hỏi con của câu trả lời con
      for (Question childQuestion in item.questionAndPageIds) {
        selectList.add(Select(childQuestion.id!, false, childQuestion.title!)); // Thêm Select cho câu hỏi con của câu trả lời con
        initSelectValues(childQuestion, selectList);
      }

      // Gọi hàm đệ quy cho danh sách câu trả lời con của câu trả lời con
      for (Answer childAnswer in item.suggestedAnswerIds) {
        print("HoangCV: childAnswer: ${item.value} : ${childAnswer.value} : ${childAnswer.id}");
        selectList.add(Select(childAnswer.id!, false, childAnswer.value!)); // Thêm Select cho câu trả lời con của câu trả lời con
        initSelectValues(childAnswer, selectList);
      }
    }
  }
}

class Select {
  int id;
  bool value;
  String title;

  Select(this.id, this.value, this.title);
}

class AddReportEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetAddReportEvent extends AddReportEvent {
  final Diary diary;

  GetAddReportEvent(this.diary);

  @override
  List<Object?> get props => [diary];
}

class UpdateAvatarEvent extends AddReportEvent {
  //final ImageSource source;
  UpdateAvatarEvent();
}

class AddReportState extends BlocState {
  @override
  List<Object?> get props =>
      [detailDiary, formStatus, isShowProgress, listReport, listSelected];
  final Diary? detailDiary;
  final List<Report> listReport;
  final List<List<Select>> listSelected;
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;

  AddReportState({
    this.detailDiary,
    this.formStatus = const InitialFormStatus(),
    this.isShowProgress = true,
    this.listReport = const [],
    this.listSelected = const [],
  });

  AddReportState copyWith({
    Diary? detailDiary,
    FormSubmissionStatus? formStatus,
    bool? isShowProgress,
    List<Report>? listReport,
    List<List<Select>>? listSelected,
  }) {
    return AddReportState(
      detailDiary: detailDiary ?? this.detailDiary,
      formStatus: formStatus ?? this.formStatus,
      isShowProgress: isShowProgress ?? this.isShowProgress,
      listReport: listReport ?? this.listReport,
      listSelected: listSelected ?? this.listSelected,
    );
  }
}
