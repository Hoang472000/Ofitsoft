import 'dart:convert';
import 'package:diary_mobile/data/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../generated/l10n.dart';
import '../../../resource/assets.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/status/form_submission_status.dart';
import '../../../utils/utils.dart';
import '../../../utils/widgets/bkav_app_bar.dart';
import '../../../utils/widgets/button_widget.dart';
import '../../../utils/widgets/dialog/dialog_manager.dart';
import '../../../utils/widgets/input/container_input_widget.dart';
import '../../../utils/widgets/input/text_form_input_text.dart';
import '../../../utils/widgets/media/image_widget.dart';
import '../../../utils/widgets/media/video_widget.dart';
import '../../../view_model/setting/feedback/detail_feedback_bloc.dart';

class DetailFeedbackPage extends StatefulWidget {
  const DetailFeedbackPage({super.key, required this.id});

  final int id;

  @override
  _DetailFeedbackPageState createState() => _DetailFeedbackPageState();

  static Route route(int id) {
    return Utils.pageRouteBuilder(
        DetailFeedbackPage(
          id: id
        ),
        true);
  }
}

class _DetailFeedbackPageState extends State<DetailFeedbackPage> {
  FocusNode focusNode = FocusNode();
  FocusNode focusNodeReply = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailFeedbackBloc(context.read<Repository>())
        ..add(InitDetailFeedbackEvent(widget.id)),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColor.background,
        appBar: OfitAppBar(
          context,
          centerTitle: true,
          showDefaultBackButton: true,
          callback: const [false],
          title: Text(
            "Chi tiết ý kiến phản hồi",
            style: StyleOfit.textStyleFW700(Colors.white, 20),
          ),
          backgroundColor: AppColor.main,
          actions: [],
        ),
        body: SafeArea(
          child: BlocConsumer<DetailFeedbackBloc, DetailFeedbackState>(
              listener: (context, state) async {
                final formStatus = state.formStatus;
                if (formStatus is SubmissionFailed) {
                  DiaLogManager.displayDialog(context, "", formStatus.exception, () {
                    Get.back();
                  }, () {
                    Get.back();
                  }, '', S.of(context).close_dialog);
                } else if (formStatus is SubmissionSuccess) {
                  if(Get.isDialogOpen == true){
                    Get.back();
                  }
                  /*DiaLogManager.displayDialog(context, "", formStatus.success ?? "",
                          () {
                        Get.back();
                        Navigator.pop(context, [true]);
                      }, () {
                      }, '', S.of(context).close_dialog, dismissible: false);*/
                } else if (formStatus is FormSubmitting) {
                  DiaLogManager.showDialogLoading(context);
                }
              }, builder: (blocContext, state) {
            return Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: SingleChildScrollView(
                  child: state.listWidget.length >0 ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ContainerInputWidget(
                        contextParent: context,
                        inputRegisterModel: state.listWidget[0],
                        onClick: () {
                          setState(() {});
                          blocContext.read<DetailFeedbackBloc>().add(
                              OnSelectValueEvent(
                                  state.listWidget, 0, context));
                        },
                        onMutiChoice: (id) {},
                        onChangeText: (text) {
                          blocContext.read<DetailFeedbackBloc>().add(
                              SaveValueTextFieldEvent(
                                  text, state.listWidget[0], 0));
                        },
                        onEditingComplete: (text) {
                          blocContext.read<DetailFeedbackBloc>().add(
                              SaveValueTextFieldEvent(
                                  text, state.listWidget[0], 0));
                        },
                      ),
                      //Text("Nhập nội dung ý kiến phản hồi"),
                      Container(
                        //margin: const EdgeInsets.only(top: 25),
                          child: TextFormFieldInputText(
                            noBorder: false,
                            underLine: false,
                            isNotEdit: false,
                            "Ý kiến phản hồi:",
                            state.moTaController ?? TextEditingController(),
                            false,
                            false,
                            focusNode,
                            (state.formStatus is ValidatePassFail) ? "ý kiến phản hồi không được để trống" : "",
                                (lostFocus) {
                              /*blocContext.read<DetailFeedbackBloc>().add(
                                  SaveValueTextFieldEvent(
                                      state.titleController!.text, state.listWidget[1], 1));
                              if (!lostFocus) {
                                //_focusNodePassNew.requestFocus();

                              }*/
                            },
                            true,
                            //icons: '',
                            onChangeCallBack: (text) {
                              print("text: onchangeCallback: $text");
                              //onchangePassOld = text;
                              blocContext.read<DetailFeedbackBloc>().add(
                                  SaveValueTextFieldEvent(
                                      text, state.listWidget[1], 1));
                            },// textCapitalization: false,
                            // false
                          )),
                      ContainerInputWidget(
                        contextParent: context,
                        inputRegisterModel: state.listWidget[2],
                        onClick: () {
                          setState(() {});
                          blocContext.read<DetailFeedbackBloc>().add(
                              OnSelectValueEvent(
                                  state.listWidget, 2, context));
                        },
                        onMutiChoice: (id) {},
                        onChangeText: (text) {
                          blocContext.read<DetailFeedbackBloc>().add(
                              SaveValueTextFieldEvent(
                                  text, state.listWidget[2], 2));
                        },
                        onEditingComplete: (text) {
                          blocContext.read<DetailFeedbackBloc>().add(
                              SaveValueTextFieldEvent(
                                  text, state.listWidget[2], 2));
                        },
                      ),

                      SizedBox(
                        height:
                        state.listImage.isNotEmpty ? state.imageHeight + 50 : 0,
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: state.listImage.length,
                            itemBuilder: (context, index) {
                              print("HoangCV: type: ${state.listImage[index].type}");
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Column(
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          child: GestureDetector(
                                            onTap: () {
                                              state.listImage[index].type != "2" ?
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => ImagePlayerWidget(state.listImage[index]
                                                      .contentView ?? ''),
                                                ),
                                              ) : null;
                                            },
                                            child: Image.memory(
                                              gaplessPlayback: true,
                                              base64Decode(state.listImage[index]
                                                  .contentView ??
                                                  ""),
                                              height: state.imageHeight,
                                              width: state.imageWidth,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: state.listImage[index].type == "2",
                                          child: Positioned(
                                            child: IconButton(
                                                onPressed: () {
                                                  print("HoangCV: state.listImage[index].filePath: ${state.listImage[index].filePath}");
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => VideoPlayerWidget(state.listImage[index].filePath??''),
                                                    ),
                                                  );
                                                },
                                                icon: Transform.scale(
                                                  scale: (state.imageWidth/4)/30,
                                                  child: Image(
                                                    image:
                                                    AssetImage(ImageAsset.imageYoutube),
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text("Phản hồi:", style: StyleOfit.textStyleFW500(AppColor.black22, 14),),
                        ),
                      ),
                      SizedBox(
                        child: Container(
                          width: double.infinity,
                          //height: 300,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFFB2B8BB),
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              color: AppColor.whiteF2),
                          padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                          child: Container(
                            child: SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              child: Column(
                                children: [
                                  ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: state.listReply.length,
                                      itemBuilder: (context, index) {
                                        print("HoangCV: type: ${state.listReply.length}");
                                        return Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: Container(
                                            child: Column(
                                              //crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                index > 0 && DateFormat("yyyy-MM-dd").format(DateTime.parse(state.listReply[index].createDate ?? "" ))
                                                    == DateFormat("yyyy-MM-dd").format(DateTime.parse(state.listReply[index - 1].createDate ?? "" ))
                                                    ? /*Text("${Utils.formatDateDay("${state.listReply[index].createDate}")}")*/SizedBox()
                                                    : Container(
                                                    padding:EdgeInsets.only(bottom: 4),
                                                    child: Text("${Utils.formatDateMonth("${state.listReply[index].createDate}")}",
                                                      style: StyleOfit.textStyleFW400(AppColor.black22, 13,),)),
                                                state.userId != state.listReply[index].userId ?
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Admin: "),
                                                    Flexible(
                                                      child: Container(
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                color: AppColor.cyanDisible, width: 1,),
                                                              borderRadius: BorderRadius.all(Radius.circular(5)),
                                                              color: AppColor.whiteF2),
                                                          padding: EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 4),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text("${state.listReply[index].description}",
                                                                style: StyleOfit.textStyleFW400(AppColor.black22, 14,),
                                                              //maxLines: 5,
                                                              overflow: TextOverflow.visible,),
                                                              SizedBox(height: 10,),
                                                              Text("${Utils.formatDateDay("${state.listReply[index].createDate}")}",
                                                                style: StyleOfit.textStyleFW400(AppColor.back09, 10),)
                                                            ],
                                                          )),
                                                    )
                                                  ],
                                                ) : Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Flexible(
                                                      child: Container(
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                color: AppColor.cyanDisible, width: 1,),
                                                              borderRadius: BorderRadius.all(Radius.circular(5)),
                                                              color: AppColor.whiteF2),
                                                          padding: EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 4),
                                                          alignment: Alignment.topRight,
                                                          child: Flexible(
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text("${state.listReply[index].description}",
                                                                  style: StyleOfit.textStyleFW400(AppColor.black22, 14),
                                                                overflow: TextOverflow.visible,),
                                                                SizedBox(height: 10,),
                                                                Container(
                                                                  //alignment: Alignment.centerRight,
                                                                  child: Text("${Utils.formatDateDay("${state.listReply[index].createDate}")}",
                                                                    style: StyleOfit.textStyleFW400(AppColor.back09, 10),),
                                                                )
                                                              ],
                                                            ),
                                                          )),
                                                    ),
                                                  ],
                                                ),

                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                  Container(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            //margin: const EdgeInsets.only(top: 25),
                                              child: TextFormFieldInputText(
                                                noBorder: false,
                                                underLine: false,
                                                isNotEdit: false,
                                                isNotValidStart: true,
                                                minLine: 1,
                                                "",
                                                state.replyController ?? TextEditingController(),
                                                false,
                                                false,
                                                focusNodeReply,
                                                (state.formStatus is ValidatePassFail) ? "" : "",
                                                    (lostFocus) {
                                                },
                                                false,
                                                //icons: '',
                                                onChangeCallBack: (text) {
                                                  print("text: SaveReplyEvent: $text");
                                                  blocContext.read<DetailFeedbackBloc>().add(
                                                      SaveReplyEvent(text));
                                                },// textCapitalization: false,
                                              )),
                                        ),
                                        IconButton(
                                            onPressed: (){
                                              blocContext.read<DetailFeedbackBloc>().add(
                                                  AddReplyEvent());
                                            },
                                            icon: Icon(Icons.send, color: AppColor.blue15, size: 30,))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ) :
                  SizedBox(),
                ));
          }),
        ),
      ),
    );
  }

  Widget itemAccount(BuildContext context,
      {required String image,
        required String text,
        required VoidCallback voidCallback,
        String? iconRight}) {
    return InkWell(
      onTap: () {
        voidCallback();
      },
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 4),
            child: Image(
              image: AssetImage(image),
              width: 40,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 8, bottom: 8),
              padding: const EdgeInsets.only(left: 6, right: 6),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFB2B8BB),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        text,
                        style: StyleOfit.textStyleFW400(AppColor.black22, 16),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      voidCallback();
                    },
                    icon: SvgPicture.asset(
                      iconRight ?? IconAsset.icArrowRight,
                      color: AppColor.main,
                    ),
                    padding: const EdgeInsets.only(
                        left: 8, right: 0, top: 10, bottom: 10),
                    constraints: const BoxConstraints(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
