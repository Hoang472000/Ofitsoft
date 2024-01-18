import 'package:diary_mobile/utils/widgets/empty_widget.dart';
import 'package:diary_mobile/utils/widgets/view_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../data/repository.dart';
import '../../../resource/assets.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/utils.dart';
import '../../../utils/widgets/ofit_app_bar.dart';
import '../../../utils/widgets/dashed_circle.dart';
import '../../utils/widgets/items/item_task.dart';
import '../../view_model/task/task_bloc.dart';
import '../filter/filter_page.dart';
import 'detail_task_page.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({
    super.key,
  });

  @override
  _TaskPageState createState() => _TaskPageState();

  static Route route() {
    return Utils.pageRouteBuilder(TaskPage(), true);
  }
}

class _TaskPageState extends State<TaskPage> {
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
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TaskBloc(context.read<Repository>())..add(GetListTaskEvent()),
      child: Stack(
        children: [
          Scaffold(
            appBar: OfitAppBar(context,
                centerTitle: true,
                hasBottom: true,
                showDefaultBackButton: true,
                callback: [],
                actions: [
                  IconButton(
                    icon: SvgPicture.asset(IconAsset.icFilter),
                    onPressed: () {
                      openFilter();
                    },
                  ),
                ],
                title: Text(
                  "Danh sách nhiệm vụ",
                  style: StyleOfit.textStyleFW700(Colors.white, 20),
                )),
            //resizeToAvoidBottomInset: true,
            backgroundColor: AppColor.background,
            body:
                HomeBackGround(
                  children: [
                    BlocBuilder<TaskBloc, TaskState>(builder: (blocContext, state) {
              return state
                          .isShowProgress /*&& (state.listDiaryActivity.length == 0 || state.listDiaryMonitor.length == 0)*/
                      ? Padding(
                    padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height/3),
                          child: DashedCircle(
                              size: 39, stringIcon: IconAsset.icLoadOtp),
                        )
                      : RefreshIndicator(
                          onRefresh: () async {
                            blocContext.read<TaskBloc>().add(GetListTaskEvent());
                          },
                          child: (state.listTask.isEmpty)
                              ? const EmptyWidget()
                              : SingleChildScrollView(
                                  //physics: const NeverScrollableScrollPhysics(),
                                  child: Column(
                                    children: [
                                      ListView.builder(
                                        itemCount: state.listTask.length,
                                        itemBuilder:
                                            (BuildContext contextBloc, int index) {
                                          return ItemTask(
                                              taskEntity: state.listTask[index],
                                              callbackChooseItem: () async {
                                                Navigator.push(
                                                    context,
                                                    DetailTaskPage.route(
                                                        state.listTask[index],
                                                        state.listTask[index].id ??
                                                            -1,
                                                        () {
                                                          print("HoangCV: khong chay vao day");
                                                          blocContext.read<TaskBloc>().add(GetListTaskEvent());
                                                        }));
                                              },
                                              callbackDelete: () {});
                                        },
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                      ),
                                      SizedBox(
                                        height: 60,
                                      )
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
            left: isFilterOpen
                ? MediaQuery.of(context).size.width * 0.1
                : MediaQuery.of(context).size.width,
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
              child: BlocBuilder<TaskBloc, TaskState>(
                  builder: (contextBloc, state) {
                return state.listTask.length > 0
                    ? FilterPage(
                        list: state.listTask,
                        type: "task",
                        onClose: closeFilter,
                        callBack: (dynamic) {
                          contextBloc.read<TaskBloc>().add(FilterEvent(dynamic));
                        },
                        // Other parameters you might need to pass
                      )
                    : SizedBox();
              }),
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
              child: Icon(icon)),
        ),
      ],
    );
  }
}
