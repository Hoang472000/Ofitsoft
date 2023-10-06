/*
import 'package:diary_mobile/utils/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../../../data/repository.dart';
import '../../../resource/assets.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/utils.dart';
import '../../../utils/widgets/bkav_app_bar.dart';
import '../../../utils/widgets/dashed_circle.dart';
import '../../utils/widgets/items/item_test.dart';
import '../../view_model/report/test_scroll_list_bloc.dart';

class TestScrollList extends StatefulWidget {
  const TestScrollList({super.key});

  @override
  _TestScrollListState createState() => _TestScrollListState();

  static Route route() {
    return Utils.pageRouteBuilder(TestScrollList(), true);
  }
}

class _TestScrollListState extends State<TestScrollList> {
  bool visible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemTestBloc(context.read<Repository>())
        ..add(GetListItemTestEvent()),
      child: GestureDetector(
        onTap: () {
          setState(() {
            visible = true;
          });
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColor.background,
          appBar: OfitAppBar(
            context,
            centerTitle: true,
            showDefaultBackButton: true,
            callback: [false, false],
            title: Text(
              "Chọn hoạt động",
              style: StyleOfit.textStyleFW700(Colors.white, 20),
            ),
            backgroundColor: AppColor.main,
            actions: [],
          ),
          body: BlocConsumer<ItemTestBloc, ItemTestState>(
              listener: (blocContext, state) async {},
              builder: (blocContext, state) {
                return state
                        .isShowProgress */
/*&& (state.listDiaryActivity.length == 0 || state.listDiaryMonitor.length == 0)*/ /*

                    ? const Center(
                        child: DashedCircle(
                            size: 39, stringIcon: IconAsset.icLoadOtp),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          blocContext.read<ItemTestBloc>().add(
                              GetListItemTestEvent());
                        },
                        child: state.listSelected.isEmpty
                            ? const EmptyWidget()
                            : Stack(
                                children: [
                                  SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          controller: state.controller,
                                          itemCount:
                                              state.listSelected.length,
                                          itemBuilder:
                                              (BuildContext contextBloc,
                                                  int index) {
                                            return AutoScrollTag(
                                              controller: state.controller!,
                                              index: index,
                                              key: ValueKey(index),
                                              child: ItemTest(
                                                  index: state.listSelected[index],
                                                  amountSelected: -1,
                                                  isChoose: false,
                                                  callbackChooseItem:
                                                      (isChoose) {
                                                  }),
                                            );
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
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                          boxShadow: const [
                                            BoxShadow(
                                              color: AppColor.gray57,
                                              blurRadius: 1,
                                              offset: Offset(0, 0),
                                            ),
                                          ],
                                          gradient: const LinearGradient(
                                            colors: [
                                              AppColor.main,
                                              AppColor.green99
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: Colors.white),
                                      child: TextButton(
                                        child: Text(
                                          "Thu bán sản phẩm",
                                          style: StyleOfit.textStyleFW500(
                                              AppColor.whiteF2, 16),
                                        ),
                                        onPressed: () {
                                          blocContext
                                              .read<ItemTestBloc>()
                                              .add(AddChooseDiary(15));
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      );
              }),
        ),
      ),
    );
  }
}
*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../data/repository.dart';
import '../../resource/assets.dart';
import '../../resource/color.dart';
import '../../resource/style.dart';
import '../../utils/utils.dart';
import '../../utils/widgets/bkav_app_bar.dart';
import '../../utils/widgets/dashed_circle.dart';
import '../../utils/widgets/empty_widget.dart';
import '../../utils/widgets/items/item_test.dart';
import '../../view_model/report/test_scroll_list_bloc.dart';

class TestScrollList extends StatefulWidget {
  const TestScrollList({Key? key}) : super(key: key);

  @override
  _TestScrollListState createState() => _TestScrollListState();

  static Route route() {
    return Utils.pageRouteBuilder(TestScrollList(), true);
  }
}

class _TestScrollListState extends State<TestScrollList> {
  final AutoScrollController controller = AutoScrollController();

  late List<Widget> items;

  int _currentFocusedIndex = 0;

  @override
  void initState() {
    items = List.generate(
      33,
      (index) => AutoScrollTag(
        key: ValueKey(index),
        controller: controller,
        index: index,
        child: Container(
          height: 100,
          width: 100,
          alignment: Alignment.center,
          color: index.isEven ? Colors.deepOrange : Colors.deepPurple,
          child: Text(index.toString()),
        ),
      ),
    );
    super.initState();
  }

/*  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          IconButton(
            onPressed: () {
              _currentFocusedIndex--;
              if (_currentFocusedIndex < 0) {
                _currentFocusedIndex = items.length - 1;
              }

              controller.scrollToIndex(_currentFocusedIndex,
                  preferPosition: AutoScrollPosition.begin);

              setState(() {});
            },
            icon: const Icon(Icons.arrow_back_ios_new_sharp),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              controller: controller,
              children: items,
            ),
          ),
          IconButton(
            onPressed: () {
              _currentFocusedIndex++;
              if (_currentFocusedIndex > items.length) {
                _currentFocusedIndex = 0;
              }
              controller.scrollToIndex(_currentFocusedIndex,
                  preferPosition: AutoScrollPosition.begin);
              setState(() {});
            },
            icon: const Icon(Icons.arrow_forward_ios_sharp),
          ),
        ],
      ),
    );
  }*/
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ItemTestBloc(context.read<Repository>())..add(GetListItemTestEvent()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColor.background,
        appBar: OfitAppBar(
          context,
          centerTitle: true,
          showDefaultBackButton: true,
          callback: [false, false],
          title: Text(
            "Chọn hoạt động",
            style: StyleOfit.textStyleFW700(Colors.white, 20),
          ),
          backgroundColor: AppColor.main,
          actions: [],
        ),
        body: BlocConsumer<ItemTestBloc, ItemTestState>(
            listener: (blocContext, state) async {},
            builder: (blocContext, state) {
              return state.isShowProgress
                  ? const Center(
                      child: DashedCircle(
                          size: 39, stringIcon: IconAsset.icLoadOtp),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        blocContext
                            .read<ItemTestBloc>()
                            .add(GetListItemTestEvent());
                      },
                      child: state.listSelected.isEmpty
                          ? const EmptyWidget()
                          : Stack(
                              children: [
                                ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  controller: state.controller,
                                  itemCount: state.listSelected.length,
                                  itemBuilder:
                                      (BuildContext contextBloc,
                                          int index) {
                                    return AutoScrollTag(
                                      controller: state.controller!,
                                      index: index,
                                      key: ValueKey(index),
                                      child: ItemTest(
                                          index:
                                              state.listSelected[index],
                                          amountSelected: -1,
                                          isChoose: false,
                                          callbackChooseItem:
                                              (isChoose) {}),
                                    );
                                  },
                                  shrinkWrap: true,
                          /*        physics:
                                      const NeverScrollableScrollPhysics(),*/
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                            color: AppColor.gray57,
                                            blurRadius: 1,
                                            offset: Offset(0, 0),
                                          ),
                                        ],
                                        gradient: const LinearGradient(
                                          colors: [
                                            AppColor.main,
                                            AppColor.green99
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(16),
                                        color: Colors.white),
                                    child: TextButton(
                                      child: Text(
                                        "Thu bán sản phẩm",
                                        style: StyleOfit.textStyleFW500(
                                            AppColor.whiteF2, 16),
                                      ),
                                      onPressed: () {
                                        /*controller.scrollToIndex(15,
                                            preferPosition: AutoScrollPosition.begin);*/
                                        blocContext
                                            .read<ItemTestBloc>()
                                            .add(AddChooseDiary(15));
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    );
            }),
      ),
    );
  }
}
