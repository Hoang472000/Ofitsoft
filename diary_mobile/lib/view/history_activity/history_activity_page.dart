import 'package:diary_mobile/data/entity/activity/activity_diary.dart';
import 'package:diary_mobile/data/entity/diary/diary.dart';
import 'package:diary_mobile/data/entity/monitor/monitor_diary.dart';
import 'package:diary_mobile/utils/status/form_submission_status.dart';
import 'package:diary_mobile/utils/widgets/empty_widget.dart';
import 'package:diary_mobile/view/diary_activity/activity/detail_activity.dart';
import 'package:diary_mobile/view/filter/filter_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../data/repository.dart';
import '../../../generated/l10n.dart';
import '../../../resource/assets.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/utils.dart';
import '../../../utils/widgets/ofit_app_bar.dart';
import '../../../utils/widgets/dashed_circle.dart';
import '../../../utils/widgets/dialog/dialog_manager.dart';
import '../../../utils/widgets/items/item_activity_avatar.dart';
import '../../utils/widgets/button_widget.dart';
import '../../utils/widgets/input/container_input_widget.dart';
import '../../utils/widgets/view_page_widget.dart';
import '../../view_model/history_activity/history_activity_bloc.dart';

class HistoryActivityPage extends StatefulWidget {
  const HistoryActivityPage(
      {super.key,
      });


  @override
  _HistoryActivityPageState createState() => _HistoryActivityPageState();

  static Route route() {
    return Utils.pageRouteBuilder(
        const HistoryActivityPage(),
        true);
  }
}

class _HistoryActivityPageState extends State<HistoryActivityPage> {
  List<ActivityDiary> listCallback = const [];
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
    //_initView();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryActivityBloc(context.read<Repository>())
        ..add(GetListHistoryActivityEvent(first: true)),
      child: Stack(
        children: [
          Scaffold(
            appBar: OfitAppBar(context,
                centerTitle: true,
                hasBottom: true,
                showDefaultBackButton: true,
                callback: [listCallback],
                actions: [
                  IconButton(
                    icon: SvgPicture.asset(IconAsset.icFilter),
                    onPressed: () {
                      openFilter();
                    },
                  ),],
                title: Text(
                  S.of(context).history_activity,
                  style: StyleOfit.textStyleFW700(Colors.white, 20),
                )),
            //resizeToAvoidBottomInset: true,
            backgroundColor: AppColor.background,
            body: HomeBackGround(
              children: [
                BlocConsumer<HistoryActivityBloc, HistoryActivityState>(
                    listener: (blocContext, state) async {
                      final formStatus = state.formStatus;
                      if(!state.isShowProgress){
                        setState(() {
                          listCallback = state.listCallback;
                        });
                      }
                      if (formStatus is SubmissionFailed) {
                        DiaLogManager.displayDialog(context, "", formStatus.exception, () {
                          Get.back();
                        }, () {
                          Get.back();
                        }, '', S.of(context).close_dialog);
                      } else if (formStatus is SubmissionSuccess) {
                        DiaLogManager.displayDialog(context, "", formStatus.success ?? "",
                                () {
                              Get.back();
                            }, () {
                              Get.back();
                            }, '', S.of(context).close_dialog);
                      } else if (formStatus is FormSubmitting) {
                        //DiaLogManager.showDialogLoading(context);
                      }
                    }, builder: (blocContext, state) {
                  return state.isShowProgress /*&& (state.listDiaryActivity.length == 0 || state.listDiaryMonitor.length == 0)*/
                      ? Padding(
                    padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height/3),
                    child:
                    DashedCircle(size: 39, stringIcon: IconAsset.icLoadOtp),
                  )
                      : RefreshIndicator(
                    onRefresh: () async {
                      blocContext.read<HistoryActivityBloc>().add(GetListHistoryActivityEvent());
                    },
                    child: SingleChildScrollView(
                      child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
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
                                      blocContext.read<HistoryActivityBloc>().add(
                                          OnSelectValueEvent(
                                              state.listWidget, index, context));
                                    },
                                    onMutiChoice: (id) {},
                                    onChangeText: (text) {},
                                    onEditingComplete: (text) {},
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomCenter,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                                child: OfitButton(
                                  text: "Tra cứu",
                                  onPressed: () {
                                    blocContext.read<HistoryActivityBloc>().add(SubmitEvent());
                                  },
                                ),
                              ),
                              (state.listDiaryActivity.isEmpty)
                                  ? const EmptyWidget()
                                  : SingleChildScrollView(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: state.listDiaryActivity.length,
                                      itemBuilder: (BuildContext contextBloc, int index) {
                                        return ItemActivityAvatar(
                                            diary: Diary(),
                                            activityDiary: state.listDiaryActivity[index],
                                            monitorDiary: MonitorDiary(),
                                            action: "activity",
                                            callbackChooseItem: () async {
                                              //Truyen id de sang man ben goi api hoac DB
                                                var result = await Navigator.push(
                                                    context,
                                                    DetailActivityPage.route(
                                                        state.listDiaryActivity[index],
                                                        Diary(), isEdit: false));
                                                if (result != null && result[0]) {
                                                  contextBloc.read<HistoryActivityBloc>().add(
                                                      GetListHistoryActivityEvent());
                                                }
                                            },
                                            callbackDelete: () {
                                              blocContext.read<HistoryActivityBloc>().add(
                                                  RemoveHistoryActivityEvent(
                                                      state.listDiaryActivity[index].id ?? -1,
                                                      "activity", (callback){}));
                                            }, notDelete: true);
                                      },
                                    ),
                                  ),
                            ],
                          ),
                    ),
                  );
                }),
              ],
            ),
          ),
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
          AnimatedPositioned(
            duration: const Duration(milliseconds: 700),
            left: isFilterOpen ? MediaQuery.of(context).size.width * 0.1 : MediaQuery.of(context).size.width,
            top: 0,
            bottom: 0,
            width: MediaQuery.of(context).size.width * 0.9,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1.0, 0.0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: ModalRoute.of(context)!.animation!,
                curve: Curves.ease,
              )),
              child: BlocBuilder<HistoryActivityBloc, HistoryActivityState>(
                  builder: (contextBloc, state) {
                    return state.listDiaryActivityFilter.length > 0 ? FilterPage(
                      list: state.listDiaryActivityFilter,
                      type: "harvesting",
                      onClose: closeFilter,
                      callBack: (dynamic){
                        contextBloc.read<HistoryActivityBloc>().add(FilterEvent(dynamic, "harvesting"));
                      },
                      // Other parameters you might need to pass
                    ) : SizedBox();
                  }
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget floatingActionButton(String name, IconData icon, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          child: FloatingActionButton(
            //backgroundColor: Colors.transparent,
              onPressed: onTap,
              child: Icon(icon)
          ),
        ),
      ],
    );
  }
}
