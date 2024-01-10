import 'package:diary_mobile/data/entity/access/detail_product_batch.dart';
import 'package:diary_mobile/utils/status/form_submission_status.dart';
import 'package:diary_mobile/utils/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import '../../data/entity/report/report_result_title.dart';
import '../../utils/widgets/items/item_access_origin.dart';
import '../../view_model/access_origin/access_origin_bloc.dart';
import 'detail_access_origin.dart';


class AccessOriginPage extends StatefulWidget {
  const AccessOriginPage(
      {super.key,});

  @override
  _AccessOriginPageState createState() => _AccessOriginPageState();

  static Route route() {
    return Utils.pageRouteBuilder(
        AccessOriginPage(),
        true);
  }
}

class _AccessOriginPageState extends State<AccessOriginPage> {
  bool visible = true;
  bool updateHarvesting = false;
  List<ReportResult> listCallback = const [];
  OverlayEntry? overlayEntry;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccessOriginBloc(context.read<Repository>())..
      add(GetAccessOriginEvent()),
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, -1);
          return false;
        },
        child: Scaffold(
          appBar: OfitAppBar(context,
              centerTitle: true,
              hasBottom: true,
              showDefaultBackButton: true,
              callback: [],
              title: Text(
                S.of(context).traceability,
                style: StyleOfit.textStyleFW700(Colors.white, 20),
              )),
          //resizeToAvoidBottomInset: true,
          backgroundColor: AppColor.background,
          body: BlocConsumer<AccessOriginBloc, AccessOriginState>(
              listener: (blocContext, state) async {
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
                } else if (formStatus is FormSubmitting) {
                }
              }, builder: (blocContext, state) {
            return state.isShowProgress
                ? const Center(
              child:
              DashedCircle(size: 39, stringIcon: IconAsset.icLoadOtp),
            )
                : RefreshIndicator(
              onRefresh: () async {
                blocContext.read<AccessOriginBloc>().add(
                    GetAccessOriginEvent());
              },
              child: (state.listAccessOrigin.isEmpty)
                  ? const EmptyWidget()
                  : SingleChildScrollView(
                //physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    ListView.builder(
                      itemCount: state.listAccessOrigin.length,
                      itemBuilder: (BuildContext contextBloc, int index) {
                        return ItemAccessOrigin(
                          productBatch: state.listAccessOrigin[index],
                          callbackChooseItem: () {
                            Navigator.of(context)
                                .push(DetailAccessOrigin.route(state.listAccessOrigin[index].id??-1));
                          },);
                      },
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                    SizedBox(
                      height: 60,
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

}
