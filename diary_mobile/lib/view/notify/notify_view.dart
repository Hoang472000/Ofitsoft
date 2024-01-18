import 'package:diary_mobile/utils/status/form_submission_status.dart';
import 'package:diary_mobile/utils/widgets/empty_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
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
import '../../utils/widgets/items/item_notify.dart';
import '../../utils/widgets/view_page_widget.dart';
import '../../view_model/notify/notify_bloc.dart';

class NotifyView extends StatefulWidget {
  const NotifyView(
      {super.key});


  @override
  _NotifyViewState createState() => _NotifyViewState();

  static Route route() {
    return Utils.pageRouteBuilder(
        NotifyView(),
        true);
  }
}

class _NotifyViewState extends State<NotifyView> {
  bool onchange = false;

  @override
  void initState() {
    FirebaseMessaging.instance.getInitialMessage();
    //HoangCV lang nghe su kien tu firebase dang trong app
    FirebaseMessaging.onMessage.listen((message) {
      if (message.data["flag"] == "1") {
        if (!mounted) return;
        setState(() {
          onchange = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotifyBloc(context.read<Repository>())
        ..add(GetListNotifyEvent()),
      child: GestureDetector(
        onTap: () {
        },
        child: Scaffold(
          appBar: OfitAppBar(context,
              centerTitle: true,
              hasBottom: true,
              showDefaultBackButton: false,
              title: Text(
                S.of(context).notification_list,
                style: StyleOfit.textStyleFW700(Colors.white, 20),
              )),
          //resizeToAvoidBottomInset: true,
          //backgroundColor: AppColor.background,
          body: HomeBackGround(
            children: [
              BlocConsumer<NotifyBloc, NotifyState>(
                  listener: (blocContext, state) async {
                    final formStatus = state.formStatus;
                    if(!state.isShowProgress){
                      setState(() {
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
                  },
                  builder: (blocContext, state) {
                    if (onchange) {
                      context
                          .read<NotifyBloc>()
                          .add(GetListNotifyEvent());
                      onchange = false;
                    }
                return state.isShowProgress /*&& (state.listDiarylistNotify.length == 0 || state.listDiaryMonitor.length == 0)*/
                    ? Padding(
                  padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height/3),
                  child:
                  DashedCircle(size: 39, stringIcon: IconAsset.icLoadOtp),
                )
                    : RefreshIndicator(
                  onRefresh: () async {
                    blocContext.read<NotifyBloc>().add(GetListNotifyEvent());
                  },
                  child: state.listNotify.isEmpty
                      ? const EmptyWidget()
                      : SingleChildScrollView(
                    //physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        ListView.builder(
                          itemCount: state.listNotify.length,
                          itemBuilder: (BuildContext contextBloc, int index) {
                            return ItemNotify(
                                notifyEntity: state.listNotify[index],
                                callbackChooseItem: () async {

                          /*        var result = await Navigator.push(
                                      context,
                                      DetailNotifyView.route(
                                          state.listlistNotify[index].id ?? -1));
                                   if (result != null && result[0]) {*/
                                      contextBloc.read<NotifyBloc>().add(
                                          EditNotificationEvent(
                                              state.listNotify[index].id ?? -1));
                                   // }
                                },
                                callbackDelete: () {
                                });
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
            ],
          ),
        ),
      ),
    );
  }
}
