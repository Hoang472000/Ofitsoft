import 'package:diary_mobile/view/diary/diary_view.dart';
import 'package:diary_mobile/view/diary_activity/activity/detail_activity.dart';
import 'package:diary_mobile/view/diary_activity/monitor/add_monitor.dart';
import 'package:diary_mobile/view_model/diary_activity/activity/activity_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../data/repository.dart';
import '../../../resource/assets.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/extenstion/extenstions.dart';
import '../../../utils/extenstion/input_register_model.dart';
import '../../../utils/extenstion/service_info_extension.dart';
import '../../../utils/utils.dart';
import '../../../utils/widgets/bkav_app_bar.dart';
import '../../../utils/widgets/button_widget.dart';
import '../../../utils/widgets/input/container_input_widget.dart';
import '../../../view_model/diary/list_diary_bloc.dart';
import 'add_activity.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key, required this.action, required this.seasonFarmId});
  final String action;
  final int seasonFarmId;

  @override
  _ActivityPageState createState() => _ActivityPageState();

  static Route route(String action, int seasonFarmId) {
    return Utils.pageRouteBuilder(ActivityPage(action: action, seasonFarmId: seasonFarmId,), true);
  }
}

class _ActivityPageState extends State<ActivityPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_initView();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActivityBloc(context.read<Repository>())..add(GetListActivityEvent(widget.seasonFarmId)),
      child: Scaffold(
        //resizeToAvoidBottomInset: true,
        backgroundColor: AppColor.background,
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.green99,
          child: Icon(Icons.add),
          onPressed: () {
            widget.action.compareTo("activity")==0 ?
            Navigator.of(context).push(AddActivityPage.route(widget.seasonFarmId)) :
            Navigator.of(context).push(AddMonitorPage.route());
          },
        ),
        body: BlocConsumer<ActivityBloc, ActivityState>(
            listener: (context, state) {},
            builder: (blocContext, state) {
              return ListView.builder(
                  itemCount:  state.listDiaryActivity.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        //Truyen id de sang man ben goi api hoac DB
                        Navigator.push(context, DetailActivityPage.route(state.listDiaryActivity[index]));
                      },
                      onLongPress: () {},
                      child: Container(
                        padding: const EdgeInsets.only(top: 8),
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 12,
                              bottom: 12,
                              left: 24,
                              right: 16),
                          margin: const EdgeInsets.only(
                              left: 20,
                              right: 16,
                              top: 4,
                              bottom: 4),
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColor.green53,
                                  blurRadius: 0,
                                  offset: Offset(-5.0, 0),
                                ),
                              ],
                              borderRadius:
                              BorderRadius.circular(8),
                              color: /*widget.isChoose ? Colors.red[100] :*/
                              Colors.white),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin:
                                    const EdgeInsets.only(
                                        bottom: 5),
                                    child: Text(
                                      state.listDiaryActivity[index].activity ?? "",
                                      style:
                                      StyleBkav.textStyleFW700(
                                          AppColor.gray500, 16),
                                    ),
                                  ),
                                  Container(
                                      alignment:
                                      Alignment.centerLeft,
                                      margin:
                                      const EdgeInsets.only(
                                          bottom: 5, top: 5),
                                      child: /*Text(
                                        "Thời gian thực hiện: ${state.listDiaryActivity[index].actionTime}",
                                        style: StyleBkav
                                            .textStyleFW400(
                                            AppColor.gray57,
                                            14),
                                        maxLines: 1,
                                        overflow:
                                        TextOverflow.ellipsis,
                                      )*/RichText(
                                  text: Utils.convertText(
                                  "Thời gian thực hiện: ",
                                      "${state.listDiaryActivity[index].actionTime}",
                                      AppColor.blue15, 14),
                        maxLines: 1,
                        overflow: TextOverflow
                            .ellipsis,
                      )),
                                  SizedBox(
                                    child: Container(
                                        alignment:
                                        Alignment.centerLeft,
                                        margin:
                                        const EdgeInsets.only(
                                            top: 5),
                                        child: RichText(
                                          text: Utils.convertText(
                                              "Diện tích: ",
                                              "${state.listDiaryActivity[index].actionArea} ${state.listDiaryActivity[index].actionAreaUnit}",
                                              AppColor.blue15, 14),
                                          maxLines: 1,
                                          overflow: TextOverflow
                                              .ellipsis,
                                        )),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                                width: 30,
                                child: Image(
                                  image: AssetImage(ImageAsset.imageBin),
                                  //width: 40,
                                  fit: BoxFit.contain,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }),
      ),
    );
  }

}
