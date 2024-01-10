import 'package:diary_mobile/utils/constants/shared_preferences_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../resource/assets.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/utils.dart';
import '../../../utils/widgets/ofit_app_bar.dart';
import '../../data/entity/diary/diary.dart';
import '../../data/entity/task /task_entity.dart';
import '../../data/repository.dart';
import '../../generated/l10n.dart';
import '../../utils/status/form_submission_status.dart';
import '../../utils/widgets/button_widget.dart';
import '../../utils/widgets/dashed_circle.dart';
import '../../utils/widgets/dialog/dialog_manager.dart';
import '../../utils/widgets/input/container_input_widget.dart';
import '../../view_model/task/detail_task_bloc.dart';
import '../diary_activity/activity/add_activity.dart';
import '../diary_activity/activity_writeby/add_activity_writeby.dart';
import 'edit_task.dart';

class DetailTaskPage extends StatefulWidget {
  DetailTaskPage({super.key, required this.id, required this.task, required this.update});
  
  final TaskEntity task;
  final int id;
  final VoidCallback update;

  @override
  _DetailTaskPageState createState() => _DetailTaskPageState();

  static Route route(TaskEntity task, int id, VoidCallback update) {
    return Utils.pageRouteBuilder(
        DetailTaskPage(
            task: task,
            id: id,
            update: update
        ),
        true);
  }
}

class _DetailTaskPageState extends State<DetailTaskPage> {
  bool edit = false;
  String nameFarmer = "";
  bool isFilterOpen = false;

  void openFilter() {
    setState(() {
      isFilterOpen = true;
    });
  }

  void closeFilter() {
    setState(() {
      isFilterOpen = false;
    });
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFarmer();
  }
   void getFarmer() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      nameFarmer = sharedPreferences.getString(SharedPreferencesKey.fullName) ?? "";
    });
   }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailTaskBloc(context.read<Repository>())
        ..add(GetDetailTaskEvent(widget.task, widget.id)),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColor.background,
        appBar: OfitAppBar(
          context,
          centerTitle: true,
          showDefaultBackButton: true,
          callback: [false],
          title: Text(
            "Chi tiết nhiệm vụ",
            style: StyleOfit.textStyleFW700(Colors.white, 20),
          ),
          backgroundColor: AppColor.main,
          actions: [],
        ),
        body: SafeArea(
          child: BlocConsumer<DetailTaskBloc, DetailTaskState>(
            listener: (blocContext, state) async {
              final formStatus = state.formStatus;
              if (formStatus is SubmissionFailed) {
                DiaLogManager.displayDialog(context, "", formStatus.exception, () {
                  Get.back();
                }, () {
                  Get.back();
                }, '', S.of(context).close_dialog);
              } else if (formStatus is SubmissionSuccess) {
                widget.update();
              } else if (formStatus is FormSubmitting) {
                DiaLogManager.showDialogLoading(context);
              }
            },
              builder: (blocContext, state) {
                return state.isShowProgress ?
                const Center(
                  child: DashedCircle(size: 39, stringIcon: IconAsset.icLoadOtp),)
                    : Stack(
                      children: [
                        Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 20),
                        child: SingleChildScrollView(
                          //physics: const NeverScrollableScrollPhysics(),
                          child: state.taskEntity !=null ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CardTile(
                                  label: "Nhiệm vụ",
                                  value: "${state.taskEntity!.name}",
                                  image: ImageAsset.imageDiary),
                              CardTile(
                                  label: "Tên nông hộ",
                                  value: nameFarmer,
                                  image: ImageAsset.imageFarmerProfile),
                              CardTile(
                                  label: "Mùa vụ lô trồng",
                                  value: "${state.seasonFarmIds}",
                                  image: ImageAsset.imageManagement),
                              CardTile(
                                  label: "Hoạt động",
                                  value: "${state.taskEntity!.activityName}",
                                  image: ImageAsset.imageActivityFarm),
                              CardTile(
                                  label: "Miêu tả",
                                  value: "${state.taskEntity!.description}",
                                  image: ImageAsset.imageFile),
                              CardTile(
                                  label: "Ngày bắt đầu",
                                  value: Utils.formatTime("${state.taskEntity!.startDate}"),
                                  image: ImageAsset.imageCalendarBegin),
                              CardTile(
                                  label: "Ngày kết thúc",
                                  value: Utils.formatTime("${state.taskEntity!.endDate}"),
                                  image: ImageAsset.imageCalendarEnd),
                              ((state.taskEntity!.status??'').compareTo("done") == 0)?CardTile(
                                  label: "Ngày hoàn thành",
                                  value: Utils.formatTime("${state.taskEntity!.completeDate}"),
                                  image: ImageAsset.imageCalendarEnd): Container(),
                              ((state.taskEntity!.status??'').compareTo("done") == 0)?CardTile(
                                  label: "Kết quả",
                                  value: "${state.taskEntity!.result}",
                                  image: ImageAsset.imageFile): Container(),
                              //draft//processing//done//cancelled//
                              CardTile(
                                  label: "Trạng thái",
                                  value: (state.taskEntity!.status ?? '' ).compareTo("draft")==0?"Lên kế hoạch":
                                  (state.taskEntity!.status ?? '' ).compareTo("pending")==0?"Chờ xử lý":
                                  (state.taskEntity!.status ?? '' ).compareTo("processing")==0?"Đang diễn ra":
                                  (state.taskEntity!.status ?? '' ).compareTo("done")==0?"Hoàn thành":
                                  (state.taskEntity!.status ?? '' ).compareTo("cancelled")==0?"Đã hủy": "",
                                  image: ImageAsset.imageStatus),
                              Visibility(
                                visible: !((state.taskEntity!.status ?? '' ).compareTo("done") ==0 || (state.taskEntity!.status ?? '' ).compareTo("cancelled") ==0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: OfitButton(
                                            text: "Hoàn thành",
                                            onPressed: () {
                                              openFilter();
                                              //getBottomSheet(blocContext, state);
                                            }),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                        child: OfitButton(
                                            text: "Thực hiện",
                                            onPressed: () async {
                                              if((state.taskEntity ?? TaskEntity())
                                                  .seasonFarmIds.length > 1) {
                                                List<Diary> diaryList = (state.taskEntity ?? TaskEntity())
                                                    .seasonFarmIds.map((item)
                                                => Diary(id: item.id)).toList();

                                                var result = await Navigator.of(context)
                                                    .push(AddActWriteByPage.route(diaryList, activityId: widget.task
                                                    .activityId ?? -1));
                                              } else {
                                                Navigator.of(context)
                                                    .push(AddActivityPage.route(
                                                    (state.taskEntity ?? TaskEntity())
                                                        .seasonFarmIds.first.id ?? -1,
                                                    Diary(),
                                                    "activity",
                                                    activityId: widget.task
                                                        .activityId ?? -1));
                                              }
                                            }),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ) : Container(),
                        )),
                        if (isFilterOpen)
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 700),
                            color: Colors.black.withOpacity(0.5),
                            child: GestureDetector(
                              onTap: () {
                                closeFilter();
                              },
                              child: Container(
                                color: Colors.transparent,
                              ),
                            ),
                          ),

// Sliding filter screen
                        Align(
                          alignment: Alignment.center,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 700),
                            height: isFilterOpen ? MediaQuery.of(context).size.height * 0.4 : 0,
                            width: MediaQuery.of(context).size.width,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: Offset(-1.0, 0.0), // Bắt đầu từ phải sang trái
                                end: Offset.zero,
                              ).animate(CurvedAnimation(
                                parent: ModalRoute.of(context)!.animation!,
                                curve: Curves.ease,
                              )),
                              child: BlocBuilder<DetailTaskBloc, DetailTaskState>(
                                  builder: (contextBloc, state) {
                                    return EditTaskPage(
                                      task: widget.task,
                                      id: widget.id,
                                      onClose: closeFilter,
                                      callBack: (result){
                                        if (result) {
                                          contextBloc
                                              .read<DetailTaskBloc>()
                                              .add(GetDetailTaskEvent(widget.task, widget.id, update: true));
                                        }
                                      },
                                      // Other parameters you might need to pass
                                    );
                                  }
                              ),
                            ),
                          ),
                        )
                      ],
                    );
              }),
        ),
      ),
    );
  }

  Widget CardTile(
      {required String image,
        required String label,
        required String value}) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4,right: 8.0),
            child: Image(
              image: AssetImage(image),
              width: 40,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    label,
                    style: StyleOfit.textStyleFW400(AppColor.black22, 16, overflow: TextOverflow.visible,),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    value,
                    style: StyleOfit.textStyleFW400(AppColor.black22, 16),
                    maxLines: 1000,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cardUrl(
      {required String image,
        required String label,
        required String value}) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4,right: 8.0),
            child: Image(
              image: AssetImage(image),
              width: 40,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    label,
                    style: StyleOfit.textStyleFW400(AppColor.black22, 16, overflow: TextOverflow.visible,),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(4),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.centerLeft),
                  child: Text(
                      value,
                      style: StyleOfit.textStyleFW400(AppColor.black22, 16),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  onPressed: () {
                    Utils.launchBrowserUrl(value);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget CardTileDouble(
      {required String label1,
        required String value1,
        required String value2,
        required String image,}) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4,right: 8.0),
            child: Image(
              image: AssetImage(image),
              width: 40,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    label1,
                    style: StyleOfit.textStyleFW400(AppColor.black22, 16),
                  ),
                ),
                Text(
                  "$value1 $value2",
                  style: StyleOfit.textStyleFW400(AppColor.black22, 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget itemAccount(BuildContext context,
      {required String image,
        required String text,
        required VoidCallback voidCallback,
        String? iconRight}) {
    return InkWell(
      onTap: () {
        voidCallback();
      },
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 4),
            child: Image(
              image: AssetImage(image),
              width: 40,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 8, bottom: 8),
              padding: const EdgeInsets.only(left: 6, right: 6),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFB2B8BB),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        text,
                        style: StyleOfit.textStyleFW400(AppColor.black22, 16),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      voidCallback();
                    },
                    icon: SvgPicture.asset(
                      iconRight ?? IconAsset.icArrowRight,
                      color: AppColor.main,
                    ),
                    padding: const EdgeInsets.only(
                        left: 8, right: 0, top: 10, bottom: 10),
                    constraints: const BoxConstraints(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getBottomSheet(BuildContext blocContext, DetailTaskState state){
    Get.bottomSheet(
      SizedBox(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  topLeft: Radius.circular(12)),
              color: Colors.white,
            ),
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.9, // Hoặc giá trị phù hợp với nhu cầu của bạn
            ),
            child: Center(
              child: Column(
                children: [
                  Container(
                    height: 44,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            topLeft: Radius.circular(12)),
                        color: Theme.of(context)
                            .primaryColor),
                    child: Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(
                              left: 10,
                              top: 8,
                              bottom: 8),
                          child: Text(
                              "Cập nhật nhiệm vụ",
                              style: StyleOfit
                                  .textStyleFW700(
                                  Colors.white, 18)),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: Colors.white,
                            size: 20.0,
                          ),
                          onPressed: () {
                            Get.back();
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
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
                          blocContext.read<DetailTaskBloc>().add(
                              OnSelectValueEvent(
                                  state.listWidget, index, context));
                        },
                        onMutiChoice: (id) {},
                        onChangeText: (text) {
                          blocContext.read<DetailTaskBloc>().add(
                              SaveValueTextFieldEvent(
                                  text, state.listWidget[index], index));
                        },
                        onEditingComplete: (text) {
                          blocContext.read<DetailTaskBloc>().add(
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
                          blocContext
                              .read<DetailTaskBloc>()
                              .add(UpdateTaskEvent());
                        }),
                  )
                ],
              ),
            ),
          )),
      // barrierColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
    );
  }
}
