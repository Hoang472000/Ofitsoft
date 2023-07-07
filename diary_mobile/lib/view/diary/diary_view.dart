import 'package:diary_mobile/view/diary_activity/activity/activity_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';

import '../../data/entity/diary/diary.dart';
import '../../resource/assets.dart';
import '../../resource/color.dart';
import '../../resource/style.dart';
import '../../utils/utils.dart';
import '../../utils/widgets/bkav_app_bar.dart';
import '../../view_model/list_diary/list_diary_bloc.dart';
import 'add_diary/add_diary_page.dart';
import 'detail_diary/detail_diary_page.dart';

class DiaryView extends StatefulWidget {
  const DiaryView({super.key});
  static Route route() {
    return Utils.pageRouteBuilder(DiaryView(), true);
  }
  @override
  _DiaryViewState createState() => _DiaryViewState();
}

class _DiaryViewState extends State<DiaryView> {
  String searchString = "";

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
    List<String> distinctMonthsAndYears = getDistinctMonthsAndYears();
    return BlocProvider(
      create: (context) => ListDiaryBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: BkavAppBar(
          context,
          centerTitle: true,
          showDefaultBackButton: false,
          title: Text(
            "Danh sách nhật ký",
            style: StyleBkav.textStyleFW700(Colors.white, 20),
          ),
          backgroundColor: AppColor.main,
          actions: [
       /*     TextButton(
              onPressed: () {
                Navigator.of(context).push(AddDiaryView.route());
              },
              child: Icon(
                Icons.add_circle_outline,
                color: Colors.white,
                size: 35,
              ),
            )*/
          ],
        ),
        body: BlocConsumer<ListDiaryBloc, ListDiaryState>(
            listener: (context, state) async {},
            builder: (blocContext, state) {
              return Center(
                child: Column(
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
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: 'Tìm kiếm',
                          suffixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const Divider(
                      height: 10.0,
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemCount: distinctMonthsAndYears.length,
                      itemBuilder: (context, index) {
                        String monthAndYear = distinctMonthsAndYears[index];
                        List<Task> tasksForMonthAndYear =
                            getTasksForMonthAndYear(monthAndYear);

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                monthAndYear,
                                style: StyleBkav.textStyleFW500(AppColor.gray57, 20),
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: tasksForMonthAndYear.length,
                              itemBuilder: (context, index) {
                                Task task = tasksForMonthAndYear[index];
                                return GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, DetailDiaryPage.route());
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        top: 8,
                                        bottom: 8,
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
                                            color: AppColor.gray57,
                                            blurRadius: 1,
                                            offset: Offset(0, 0),
                                          ),
                                        ],
                                        borderRadius:
                                        BorderRadius.circular(8),
                                        color: Colors.white),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              Padding(
                                                padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                                                child: Text(Utils.formatDateToString(tasksForMonthAndYear[index].date),
                                                style: StyleBkav.textStyleFW400(AppColor.black22, 14),),
                                              ),
                                              Text(tasksForMonthAndYear[index].name.toString(),
                                                style: StyleBkav.textStyleFW500(AppColor.main, 16),),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                                                child: Text(tasksForMonthAndYear[index].activity.toString(),
                                                  style: StyleBkav.textStyleFW400(AppColor.black22, 14),maxLines: 3,overflow: TextOverflow.visible,),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 8),
                                                child: RichText(
                                                  text: Utils.convertText(
                                                      "Thực hiện: ",
                                                      "Cao Văn Hoàng",
                                                      AppColor.blue15),
                                                  maxLines: 1,
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Image(image: AssetImage(ImageAsset.imageOfitsoftText),
                                         width: 75, fit: BoxFit.contain,),
                                        //Icon(tasksForMonthAndYear[index].icon, color: AppColor.main,),
                                      ],
                                    ),
                                  ),
                                )
                                  /*ListTile(
                                  title: Text(task.name),
                                  subtitle: Text(
                                      '${task.date.day}/${task.date.month}/${task.date.year}'),
                                )*/;
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 4),
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
                ),
              );
            }),
      ),
    );
  }

  final List<Task> tasks = [
    Task(name: 'Sản xuất rau', date: DateTime(2022, 12, 25), activity: "Mùa vụ sản xuất rau bắp cải năm 2022", icon: Icons.spa),
    Task(name: 'Sản xuất lúa', date: DateTime(2022, 1, 10), activity: "Mùa vụ sản xuất lúa đông xuân năm 2022", icon: Icons.spa_outlined),
    Task(name: 'Sản xuất lúa', date: DateTime(2023, 3, 5), activity: "Mùa vụ sản xuất lúa hè thu năm 2023", icon: Icons.spa),
    Task(name: 'Sản xuất cải thảo', date: DateTime(2023, 3, 15), activity: "Mùa vụ sản xuất rau cải thảo năm 2023", icon: Icons.spa),
    Task(name: 'Sản xuất hạt điều', date: DateTime(2021, 3, 8), activity: "Mùa vụ sản xuất hạt điều năm 2023", icon: Icons.local_cafe),
    Task(name: 'Sản xuất cà phê', date: DateTime(2023, 3, 12), activity: "Mùa vụ sản xuất cà phê năm 2023", icon: Icons.local_cafe),
  ];

  List<String> getDistinctMonthsAndYears() {
    List<String> distinctMonthsAndYears = [];
    tasks.sort((a, b) => b.date.compareTo(a.date));
    for (var task in tasks) {
      String monthAndYear = '${task.date.month}/${task.date.year}';
      if (!distinctMonthsAndYears.contains(monthAndYear)) {
        distinctMonthsAndYears.add(monthAndYear);
      }
    }
    return distinctMonthsAndYears;
  }

  List<Task> getTasksForMonthAndYear(String monthAndYear) {
    List<Task> tasksForMonthAndYear = [];
    tasks.sort((a, b) => b.date.compareTo(a.date));
    for (var task in tasks) {
      String taskMonthAndYear = '${task.date.month}/${task.date.year}';
      if (taskMonthAndYear == monthAndYear) {
        tasksForMonthAndYear.add(task);
      }
    }
    return tasksForMonthAndYear;
  }

}

class Task {
  final String name;
  final String activity;
  final IconData icon;
  final DateTime date;

  Task({required this.name, required this.date, required this.activity, required this.icon});
}