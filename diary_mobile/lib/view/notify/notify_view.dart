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

class NotifyView extends StatefulWidget {
  const NotifyView({super.key});

  @override
  _NotifyViewState createState() => _NotifyViewState();
}

class _NotifyViewState extends State<NotifyView> {
  String searchString = "";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListDiaryBloc(),
      child: Scaffold(
        backgroundColor: AppColor.background,
        appBar: BkavAppBar(
          context,
          centerTitle: true,
          showDefaultBackButton: false,
          title: Text(
            "Danh sách thông báo",
            style: StyleBkav.textStyleFW700(Colors.white, 20),
          ),
          backgroundColor: AppColor.main,
          actions: [
          ],
        ),
        //endDrawer: AppDrawer(),
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
                        child: Center(child:Text("Tính năng hiện tại đang phát triển", style: StyleBkav.textStyleFW400(AppColor.black22, 18),))),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
