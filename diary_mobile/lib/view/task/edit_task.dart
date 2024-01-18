import 'package:diary_mobile/data/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/utils.dart';
import '../../data/entity/task /task_entity.dart';
import '../../generated/l10n.dart';
import '../../utils/status/form_submission_status.dart';
import '../../utils/widgets/button_widget.dart';
import '../../utils/widgets/dialog/dialog_manager.dart';
import '../../utils/widgets/input/container_input_widget.dart';
import '../../view_model/task/edit_task_bloc.dart';

class EditTaskPage extends StatefulWidget {
  EditTaskPage({super.key, required this.id, required this.task, required this.onClose, required this.callBack});

  final TaskEntity task;
  final int id;
  final VoidCallback onClose;
  final Function(dynamic) callBack;

  @override
  _EditTaskPageState createState() => _EditTaskPageState();

  static Route route(TaskEntity task, int id, VoidCallback onClose, Function(dynamic) callBack) {
    return Utils.pageRouteBuilder(
        EditTaskPage(
            task: task,
            id: id,
            onClose: onClose,
            callBack: callBack,
        ),
        true);
  }
}

class _EditTaskPageState extends State<EditTaskPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditTaskBloc(context.read<Repository>())
        ..add(GetEditTaskEvent(widget.task, widget.id)),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: KeyboardDismisser(
          child: SafeArea(
            child: BlocConsumer<EditTaskBloc, EditTaskState>(
              listener: (blocContext, state) {
                final formStatus = state.formStatus;
                if(!state.isShowProgress){
                }
                if (formStatus is SubmissionFailed) {
                  DiaLogManager.displayDialog(context, "", formStatus.exception, () {
                    Get.back();
                  }, () {
                    Get.back();
                  }, '', S.of(context).close_dialog);
                } else if (formStatus is SubmissionSuccess) {
                  widget.callBack(true);
                  widget.onClose();
                } else if (formStatus is FormSubmitting) {
                }
              },
                builder: (blocContext, state) {
                  return SizedBox(
                      child: Container(
                        decoration: BoxDecoration(
                    /*      borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12),
                              topLeft: Radius.circular(12)),*/
                          color: AppColor.grayEC,
                        ),
                        padding: const EdgeInsets.all(10),
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.9, // Hoặc giá trị phù hợp với nhu cầu của bạn
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(12),
                                child: Text("Cập nhật nhiệm vụ",
                                    style: StyleOfit.textStyleFW500(AppColor.black22, 18)),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.listWidget.length,
                                  itemBuilder: (_, index) => ContainerInputWidget(
                                    contextParent: context,
                                    inputRegisterModel: state.listWidget[index],
                                    onClick: () {
                                      setState(() {});
                                      blocContext.read<EditTaskBloc>().add(
                                          OnSelectValueEvent(
                                              state.listWidget, index, context));
                                    },
                                    onMutiChoice: (id) {},
                                    onChangeText: (text) {
                                      blocContext.read<EditTaskBloc>().add(
                                          SaveValueTextFieldEvent(
                                              text, state.listWidget[index], index));
                                    },
                                    onEditingComplete: (text) {
                                      blocContext.read<EditTaskBloc>().add(
                                          SaveValueTextFieldEvent(
                                              text, state.listWidget[index], index));
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: OfitButton(
                                    text: "Hoàn Thành",
                                    onPressed: () {
                                      print("${state.resultController!.text} : ${state.completeTimeController!.text}");
                                      blocContext
                                          .read<EditTaskBloc>()
                                          .add(UpdateTaskEvent(state.resultController!.text,
                                          state.completeTimeController!.text));
                                    }),
                              )
                            ],
                          ),
                        ),
                      ));
                }),
          ),
        ),
      ),
    );
  }

}
