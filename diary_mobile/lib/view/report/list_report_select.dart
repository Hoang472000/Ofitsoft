import 'package:diary_mobile/utils/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository.dart';
import '../../../resource/assets.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/utils.dart';
import '../../../utils/widgets/ofit_app_bar.dart';
import '../../../utils/widgets/dashed_circle.dart';
import '../../data/entity/report/report_select.dart';
import '../../utils/widgets/items/item_report_select.dart';
import '../../view_model/report/list_report_select_bloc.dart';
import 'add_report.dart';

class ListReportSelect extends StatefulWidget {
  const ListReportSelect({super.key, required this.listReport});

  final List<ReportSelect> listReport;

  @override
  _ListReportSelectState createState() => _ListReportSelectState();

  static Route route(List<ReportSelect> listReport) {
    return Utils.pageRouteBuilder(
        ListReportSelect(listReport: listReport), true);
  }
}

class _ListReportSelectState extends State<ListReportSelect> {
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListReportSelectBloc(context.read<Repository>())
        ..add(GetListReportSelectEvent(widget.listReport,)),
      child: Scaffold(
        appBar: OfitAppBar(context,
            centerTitle: true,
            hasBottom: true,
            showDefaultBackButton: true,
            callback: [false],
            title: Text(
              "Chọn mẫu báo cáo đánh giá",
              style: StyleOfit.textStyleFW700(Colors.white, 20),
            )),
        //resizeToAvoidBottomInset: true,
        backgroundColor: AppColor.background,
        body: BlocConsumer<ListReportSelectBloc, ListReportSelectState>(
          listener: (blocContext, state) async {},
          builder: (blocContext, state) {
            return RefreshIndicator(
              onRefresh: () async {
                print('Refresh triggered');
                blocContext.read<ListReportSelectBloc>().add(
                    GetListReportSelectEvent(const [],
                        checkUpdate: true));
              },
              child: state.isShowProgress
                  ? const Center(
                      child: DashedCircle(
                          size: 39, stringIcon: IconAsset.icLoadOtp),
                    )
                  : (state.listReport.isEmpty)
                      ? const EmptyWidget()
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              ListView.builder(
                                itemCount: widget.listReport.length,
                                itemBuilder:
                                    (BuildContext contextBloc, int index) {
                                  return ItemReportSelect(
                                      report: widget.listReport[index],
                                      callbackChooseItem: () async {
                                        var result = await Navigator.of(context)
                                            .push(AddReportViewPage.route(
                                                widget.listReport[index].id ??
                                                    -1));
                      /*                  var result = await Navigator.of(context)
                                            .push(TestScrollList.route());*/
                                        if (result != null && result[0]) {
                                          Navigator.of(context).pop(result);
                                        }
                                      });
                                },
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                              ),
                            ],
                          ),
                        ),
            );
          },
        ),
      ),
    );
  }

}
