import 'package:diary_mobile/data/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../data/entity/diary/diary.dart';
import '../../resource/assets.dart';
import '../../resource/color.dart';
import '../../resource/style.dart';
import '../../utils/utils.dart';
import '../../utils/widgets/bkav_app_bar.dart';
import '../../utils/widgets/dashed_circle.dart';
import '../../utils/widgets/empty_widget.dart';
import '../../view_model/diary/list_diary_bloc.dart';
import '../diary_activity/activity_writeby/add_activity_writeby.dart';
import '../filter/filter_page.dart';
import 'detail_diary/detail_diary_page.dart';
import '../../utils/widgets/items/item_diary.dart';

class DiaryView extends StatefulWidget {
  const DiaryView({super.key});

  static Route route() {
    return Utils.pageRouteBuilder(const DiaryView(), true);
  }

  @override
  _DiaryViewState createState() => _DiaryViewState();
}

class _DiaryViewState extends State<DiaryView> {
  String searchString = "";
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

  Future<List<Diary>> fetchDiaries() async {
/*    var  _client = new OdooClient(ApiPath.base_url);
    //OdooResponse result = await _client.callController(ApiPath.get_diaries_monitor + globalSessionData!.User!.uid.toString(),{});

    OdooResponse result = await _client.callController(ApiPath.search_diaries_monitor, _searchDiary.toJson());

    if (!result.hasError()) {
      var response = result.getResult()['response'];
      return response.map<Diary>((json) =>Diary.fromJson(json)).toList();
    } else {
      print(result.getError());
      throw Exception('Failed to load diaries from API');
      //return null;
    }*/
    return [];
  }

  @override
  Widget build(BuildContext context) {
/*    List<String> distinctMonthsAndYears = getDistinctMonthsAndYears();*/
    return BlocProvider(
      create: (context) =>
      ListDiaryBloc(context.read<Repository>())
        ..add(GetListDiaryEvent()),
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: AppColor.background,
            appBar: OfitAppBar(
              context,
              centerTitle: true,
              showDefaultBackButton: false,
              title: Text(
                "Danh sách nhật ký",
                style: StyleOfit.textStyleFW700(Colors.white, 20),
              ),
              backgroundColor: AppColor.background,
              actions: [
                IconButton(
                icon: SvgPicture.asset(IconAsset.icFilter),
                onPressed: () {
                  openFilter();
                },
              ),],
            ),
            body: BlocConsumer<ListDiaryBloc, ListDiaryState>(
                listener: (context, state) async {},
                builder: (blocContext, state) {
                  return state
                      .isShowProgress ? const Center(
                    child:
                    DashedCircle(size: 39, stringIcon: IconAsset.icLoadOtp),
                  )
                      /*: state.listDate.isEmpty ? const EmptyWidget()*/
                      : Column(
                    children: [
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: TextField(
                          onChanged: (value) {
                            if ((value.length >= 2) || (value.length == 0)) {
                              setState(() {
                                searchString = value.toLowerCase();
                              });
                              blocContext.read<ListDiaryBloc>().add(
                                  SearchListDiaryEvent(value));
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: 'Tìm kiếm',
                            suffixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.all(8),
                          ),
                        ),
                      ),
                      const Divider(
                        height: 10.0,
                      ),
                      Visibility(
                        visible: (state.amountSelected > 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                blocContext.read<ListDiaryBloc>().add(
                                    AddChooseAllDiary(
                                        state.amountSelected == state.lengthDiary));
                              },
                              child: Row(
                                children: [
                                  SizedBox(width: 1,),
                                  IconButton(
                                      onPressed: () {
                                        blocContext.read<ListDiaryBloc>().add(
                                            AddChooseAllDiary(
                                                state.amountSelected ==
                                                    state.lengthDiary));
                                      },
                                      icon: state.amountSelected ==
                                          state.lengthDiary
                                          ? const Icon(
                                        Icons.check_box_outlined,
                                        color: AppColor.main,
                                        size: 20,
                                      )
                                          : const Icon(
                                        Icons.check_box_outline_blank,
                                        color: AppColor.main,
                                        size: 20,
                                      ),
                                      padding: EdgeInsets.zero),
                                  Text(state.amountSelected == state.lengthDiary
                                      ? "Bỏ chọn tất cả"
                                      : "Chọn tất cả",
                                      style: StyleOfit.textStyleFW500(
                                          AppColor.gray57, 14)),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                blocContext.read<ListDiaryBloc>().add(
                                    GetListDiarySelected(context));
                              },
                              child: Row(
                                children: [
                                  Text("Thêm nhiều",
                                      style: StyleOfit.textStyleFW500(
                                          AppColor.gray57, 14)),
                                  IconButton(
                                      onPressed: () {
                                        blocContext.read<ListDiaryBloc>().add(
                                            GetListDiarySelected(context));
                                      },
                                      icon: const Icon(
                                        Icons.edit_note_outlined,
                                        color: AppColor.main,
                                        size: 30,
                                      ),
                                      padding: EdgeInsets.zero),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      state.listDate.isEmpty ? const EmptyWidget() : Expanded(
                          child: ListView.builder(
                            itemCount: state.listDate.length,
                            itemBuilder: (context, indexParent) {
                              String monthAndYear = state.listDate[indexParent];
                              /*                    List<Diary> tasksForMonthAndYear =
                                getTasksForMonthAndYear(
                                    monthAndYear, state.listDiary);*/

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          monthAndYear,
                                          style: StyleOfit.textStyleFW500(
                                              AppColor.gray57, 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: state.listDiary[indexParent].length,
                                    itemBuilder: (context, index) {
                                      return ItemDiary(diary: state
                                          .listDiary[indexParent][index],
                                          amountSelected: state.amountSelected,
                                          isChoose: state
                                              .listSelected[indexParent][index],
                                          callbackChooseItem: (isChoose, diary) {
                                            setState(() {
                                              //selectAll=false;
                                            });
                                            blocContext.read<ListDiaryBloc>().add(
                                                AddChooseDiary(
                                                    indexParent, index, !isChoose,
                                                    diary));
                                          });
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 70, vertical: 4),
                                    child: Divider(
                                      height: 1,
                                      thickness: 1,
                                      indent: 1,
                                      color: Colors.black26,
                                    ),
                                  )
                                ],
                              );
                            },
                          )),
                    ],
                  );
                }),
          ),
          if (isFilterOpen)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
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
              child: BlocBuilder<ListDiaryBloc, ListDiaryState>(
                  builder: (contextBloc, state) {
                    return state.listDiaryFilter.length > 0 ? FilterPage(
                      list: state.listDiaryFilter,
                      type: "diary",
                      onClose: closeFilter,
                      callBack: (dynamic){
                        contextBloc.read<ListDiaryBloc>().add(FilterEvent(dynamic));
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
}

