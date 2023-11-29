import 'dart:convert';
import 'package:diary_mobile/resource/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../data/repository.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/utils.dart';
import '../../../utils/widgets/bkav_app_bar.dart';
import '../../../utils/widgets/dashed_circle.dart';
import '../../../view_model/diary_activity/activity/workflow_bloc.dart';

class WorkflowPage extends StatefulWidget {
  const WorkflowPage({super.key, required this.id});
  final int id;

  @override
  _WorkflowPageState createState() => _WorkflowPageState();

  static Route route(int id) {
    return Utils.pageRouteBuilder(WorkflowPage(id: id), true);
  }
}

class _WorkflowPageState extends State<WorkflowPage> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WorkflowBloc(context.read<Repository>())..add(GetWorkflowEvent(widget.id)),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColor.background,
        appBar: OfitAppBar(
          context,
          centerTitle: true,
          showDefaultBackButton: true,
          title: Text(
            "QUY TRÌNH LÀM VIỆC",
            style: StyleOfit.textStyleFW700(Colors.white, 20),
          ),
          backgroundColor: AppColor.background,
          actions: [],
        ),
        body: BlocBuilder<WorkflowBloc, WorkflowState>(
            builder: (blocContext, state) {
              return state.isShowProgress ?
              const Center(
                child: DashedCircle(size: 39, stringIcon: IconAsset.icLoadOtp),)
                  : Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 40),
                  child: SingleChildScrollView(
                    //physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        cardTile(
                            label: "Tên quy trình",
                            value: "${state.workflow!.name}",
                            image: ImageAsset.imageWorkProcess),
                        cardTileDouble(
                            label1: "Loại vật nuôi/cây trồng",
                            value1:  "${state.workflow!.cropName}",
                            value2: "${state.workflow!.productName}",
                            image: ImageAsset.imageTree),
                        cardTile(
                            label: "Tiêu chuẩn",
                            value: "${state.workflow!.standard}",
                            image: ImageAsset.imageFile),
                        cardTile(
                            label: "Mô tả",
                            value: "${state.workflow!.description}",
                            image: ImageAsset.imageDiary),
                        ExpansionTile(
                          title: Text(state.workflow!.name ?? ""),
                          children:  List.generate(state.workflow!.processStageIds.length, (index) {
                            final processStage = state.workflow!.processStageIds[index];
                            final romanNumeral = convertToRoman(index + 1);
                            return ExpansionTile(
                              title: Text(" $romanNumeral. ${processStage.name ?? ""}"),
                              children: List.generate(processStage.processStageTaskIds.length, (taskIndex) {
                                final processStageTask = processStage.processStageTaskIds[taskIndex];
                                return ExpansionTile(
                                  title: Text("   ${taskIndex + 1}. ${processStageTask.activityName}" ?? '',),
                                  children: [
                                          Container(
                                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                                            child: Text("Mô tả: ${processStageTask.description}" ?? '',
                                              style: StyleOfit.textStyleFW400(AppColor.black22, 16),),
                                          ),
                                          (processStageTask.image ?? "").isNotEmpty ?
                                          Container(
                                                padding: const EdgeInsets.only(top: 8,  bottom: 8),
                                            child: Image.memory(
                                              gaplessPlayback: true,
                                              base64Decode(processStageTask.image ?? ""),
                                              height: 240,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error,
                                                  stackTrace) {
                                                return const Image(
                                                  image: AssetImage(
                                                      ImageAsset
                                                          .imageEmptyData),
                                                  height: 240,
                                                  // width: 360,
                                                  fit: BoxFit.contain,
                                                );
                                              },
                                            ),
                                          ) : SizedBox(),
                                        ],

                                );
                              }).toList(),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ));
            }),
      ),
    );
  }
  String convertToRoman(int value) {
    if (value < 1 || value > 3999) {
      return "Invalid"; // Limitation of the Roman numeral system
    }

    final List<String> romanNumerals = [
      "", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "XI",
      "XII", "XIII", "XIV", "XV", "XVI", "XVII", "XVIII", "XIX", "XX", "XXI",
      "XXII", "XXIII", "XXIV", "XXV", "XXVI", "XXVII", "XXVIII", "XXIX", "XXX"
    ]; // Extend this list as needed

    return romanNumerals[value];
  }
  Widget cardTile(
      {required String image,
        required String label,
        required String value}) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4,right: 8.0),
            child: Image(
              image: AssetImage(image),
              width: 40,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    label,
                    style: StyleOfit.textStyleFW400(AppColor.black22, 16, overflow: TextOverflow.visible,),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    value,
                    style: StyleOfit.textStyleFW400(AppColor.black22, 16),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cardTileDouble(
      {required String label1,
        required String value1,
        required String value2,
        required String image,}) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4,right: 8.0),
            child: Image(
              image: AssetImage(image),
              width: 40,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    label1,
                    style: StyleOfit.textStyleFW400(AppColor.black22, 16),
                  ),
                ),
                RichText(
                    overflow: TextOverflow.clip,
                    text: TextSpan(
                      text: "$value1 ${value2.isNotEmpty ? "- " : ""}",
                      style: StyleOfit.textStyleFW400(AppColor.black22, 16),
                      children:  <TextSpan>[
                        TextSpan(
                          text: value2,
                          style: StyleOfit.textStyleFW400(AppColor.black22, 16),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget itemAccount(BuildContext context,
      {
        required String text,
        required VoidCallback voidCallback,
        String? iconRight}) {
    return InkWell(
      onTap: () {
        voidCallback();
      },
      child: Expanded(
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
    );
  }
}
