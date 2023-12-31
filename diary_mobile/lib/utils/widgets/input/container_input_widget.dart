import 'dart:convert';
import 'dart:math';
import 'package:diary_mobile/resource/color.dart';
import 'package:diary_mobile/resource/style.dart';
import 'package:diary_mobile/utils/extenstion/service_info_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../resource/assets.dart';
import '../../extenstion/extenstions.dart';
import '../../extenstion/input_register_model.dart';
import '../../utils.dart';
import '../checkbox/checkbox_custom_widget.dart';


class ContainerInputWidget extends StatelessWidget {
  final Function? onClick;
  final InputRegisterModel inputRegisterModel;
  final BuildContext? contextParent;
  final ValueChanged<int>? onMutiChoice;
  final ValueChanged<String>? onChangeText;
  final ValueChanged<String>? onSubmittedText;
  final Function(String)? onEditingComplete;
  final Function? onClickIcon;
  final Function? showPassword;
  final ValueChanged<bool>? checkFocus;
  final TextStyle? titleStyle; // điều chỉnh style tiêu đề
  final ValueChanged<bool>? onChangeToggle;
  final Color? color;

  const ContainerInputWidget({
    Key? key,
    this.onClick,
    required this.inputRegisterModel,
    this.contextParent,
    this.onMutiChoice,
    this.onChangeText,
    this.onSubmittedText,
    this.onEditingComplete,
    this.onClickIcon,
    this.showPassword,
    this.checkFocus,
    this.titleStyle,
    this.onChangeToggle,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Xử lí khi click ra ngoài sẽ viết hoa và bỏ dấu tiếng việt
    if (inputRegisterModel.type == TypeInputRegister.TextField &&
        inputRegisterModel.isUpCaseTextAndRemoveSign) {
      inputRegisterModel.focusNode.addListener(() {
        print(inputRegisterModel.focusNode.hasFocus);
        if (!inputRegisterModel.focusNode.hasFocus) {
          inputRegisterModel.controller!.text = Utils.formatText(
              inputRegisterModel.controller!.text.toUpperCase());
        }
      });
    }
    return Stack(
      children: [
        Padding(
          padding: /*inputRegisterModel.noBorder ? EdgeInsets.zero:*/ EdgeInsets.only(top: 8, bottom: 8),
          child: GestureDetector(
            onTap: () {
              switch (inputRegisterModel.type) {
                case TypeInputRegister.TextField:
                  inputRegisterModel.focusNode.requestFocus();
                  break;
                case TypeInputRegister.Select:
                  onClick!();
                  break;
                case TypeInputRegister.MultiSelection:
                  // TODO: Handle this case.
                  break;
                case TypeInputRegister.Non:
                  // TODO: Handle this case.
                  break;
                case TypeInputRegister.Balance:
                  // TODO: Handle this case.
                  break;
                case TypeInputRegister.TextFieldIcon:
                  inputRegisterModel.focusNode.requestFocus();
                  break;
                case TypeInputRegister.TextFieldMoney:
                  //inputRegisterModel.focusNode.requestFocus();
                  break;
                case TypeInputRegister.TextFieldRemark:
                  inputRegisterModel.focusNode.requestFocus();
                  break;
                case TypeInputRegister.Tolge:
                  // TODO: Handle this case.
                  break;
                case TypeInputRegister.TextFieldDate:
                // TODO: Handle this case.
                  break;
              }
            },
            child: Row(
              children: [
                 SizedBox(
//imageActivityFarm
                   child: inputRegisterModel.image != "" ?
                   Padding(
                     padding: EdgeInsets.only(right: 4),
                     child: Image(
                       image: AssetImage(inputRegisterModel.image),
                       width: 40,
                       fit: BoxFit.contain,
                     ),
                   ): Container(),
                   /*SvgPicture.asset(
                       IconAsset.icAlmond,
                       width: 30),*/
                 ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: inputRegisterModel.error != null
                              ? !inputRegisterModel.noUnder ? Colors.red : Colors.transparent
                              // chỗ này kiểm tra xem nó là dạng togle thì không show viền boder
                              : inputRegisterModel.type == TypeInputRegister.Tolge || inputRegisterModel.noBorder
                                  ? Colors.transparent
                                  : Color(0xFFB2B8BB),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: color == null ? Colors.white : color),
                    child: Container(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        primary: false,
                        children: [
                          Padding(
                            padding: inputRegisterModel.noBorder ? EdgeInsets.zero : const EdgeInsets.all(6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                inputRegisterModel.title.length > 25 ?
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    '${inputRegisterModel.title}',
                                    style: TextStyle(
                                            color: AppColor.gray57,
                                            fontSize: 14)
                                        .merge(titleStyle),
                                  ),
                                ) : Text(
                                  '${inputRegisterModel.title}',
                                  style: TextStyle(
                                      color: AppColor.gray57,
                                      fontSize: 14)
                                      .merge(titleStyle),
                                ),
                                (inputRegisterModel.isCompulsory &&
                                        inputRegisterModel.title.isNotEmpty)
                                    ? Text(
                                        " *",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 14),
                                      )
                                    : Container(),
                                SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Row(
                                    children: [
                                      Expanded(child: _rightWidget(context)),
                                      inputRegisterModel.unit == null
                                          ? Container()
                                          : Expanded(
                                              child: Text(
                                              inputRegisterModel.unit ?? "",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14),
                                              textAlign: TextAlign.end,

                                            )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          inputRegisterModel.type == TypeInputRegister.MultiSelection
                              ? bottomWidget()
                              : Container()
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        inputRegisterModel.noUnder ? Positioned.fill(
          top: -30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                inputRegisterModel.error ?? "",
                style: TextStyle(
                    color: Colors.red,
                    backgroundColor: Colors.white,
                    fontSize: 12),
              ),
            ],
          ),
        )
            :Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                inputRegisterModel.image != "" ? SizedBox(width: 44,) : SizedBox(),
                Expanded(
                  child: Text(
                    "${inputRegisterModel.error ?? ""}",
                    style: TextStyle(
                        color: Colors.red,
                        backgroundColor: Colors.white,
                        fontSize: 12),
                  ),
                ),
                SizedBox(
                  width: 20,
                )
              ],
            )
      ],
    );
  }

  Widget bottomWidget() {
    print("HoangCV");
    return ListView.builder(
        padding: EdgeInsets.only(bottom: 12),
        shrinkWrap: true,
        primary: false,
        itemCount: inputRegisterModel.listMutiChoice!.length,
        itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                /// Đóng bàn phím nếu đang chọn
                FocusScope.of(context).requestFocus(FocusNode());
                onMutiChoice!(index);
              },
              child: Container(
                color: index % 2 == 0
                    ? Theme.of(context).primaryColorLight
                    : Colors.white,
                padding: EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  children: [
                    CheckboxCustomWidget(
                      isChecked:
                          inputRegisterModel.listMutiChoice![index].isSelected,
                    ),
                    Flexible(
                      // cho phép wrap text
                      child: Text(
                          inputRegisterModel.listMutiChoice![index].description ?? "",
                          style: StyleOfit.textStyleFW400(AppColor.black22, 14)),
                    ),
                  ],
                ),
              ),
            ));
  }

  Widget _rightWidget(BuildContext context) {
    //print("HoangCV:_rightWidget chạy vào đây");
    switch (inputRegisterModel.type) {
      case TypeInputRegister.TextField:
        int maxLength = 0;
        if (inputRegisterModel.maxLengthTextInput != null) {
          if (inputRegisterModel.isFormatText) {
            maxLength = (inputRegisterModel.maxLengthTextInput! +
                (inputRegisterModel.maxLengthTextInput! % 3 == 0
                    ? inputRegisterModel.maxLengthTextInput! ~/ 3 - 1
                    : inputRegisterModel.maxLengthTextInput! ~/ 3))!;
          } else {
            maxLength = inputRegisterModel.maxLengthTextInput!;
          }
        }

        /// Format text
        List<TextInputFormatter> _textFormat = [];
        if (inputRegisterModel.isOnlyInputNumber) {
          _textFormat = <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9,]')),
          ];
        }
        if (inputRegisterModel.isUpCaseTextAndRemoveSign) {
          _textFormat = <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(
                r'[a-z A-Z àáãạảăắằẳẵặâấầẩẫậèéẹẻẽêềếểễệđìíĩỉịòóõọỏôốồổỗộơớờởỡợùúũụủưứừửữựỳỵỷỹýÀÁÃẠẢĂẮẰẲẴẶÂẤẦẨẪẬÈÉẸẺẼÊỀẾỂỄỆĐÌÍĨỈỊÒÓÕỌỎÔỐỒỔỖỘƠỚỜỞỠỢÙÚŨỤỦƯỨỪỬỮỰỲỴỶỸÝ]')),
          ];
        }
        if (inputRegisterModel.isRemoveSign) {
          _textFormat = <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[a-z A-Z 0-9]')),
          ];
        }
        if (inputRegisterModel.isAlwaysCap == null) {
          _textFormat = <TextInputFormatter>[];
        } else if (inputRegisterModel.isAlwaysCap &&
            inputRegisterModel.isAlwaysCap != null) {
          _textFormat = <TextInputFormatter>[UpperCaseTextFormatter()];
        } else {
          _textFormat = <TextInputFormatter>[];
        }
        return Row(
          children: [
            Expanded(
              child: Focus(
                child: TextField(
                  obscureText: inputRegisterModel.isPassword,

                  /// Chỉ cho phép nhận số. Kể cả dấu chấm
                  inputFormatters: _textFormat,
                  focusNode: inputRegisterModel.focusNode,
                  keyboardType: inputRegisterModel.typeInput,
                  controller: inputRegisterModel.controller,
                  textCapitalization:
                      inputRegisterModel.textCapitalization == null
                          ? TextCapitalization.none
                          : inputRegisterModel.textCapitalization!,
                  textAlign: TextAlign.right,
                  //autofocus: true,
                  // onTap: () {
                  //   inputRegisterModel.controller.selection =
                  //       new TextSelection.fromPosition(new TextPosition(
                  //           offset: inputRegisterModel.controller.text.length));
                  // },
                  onChanged: (newText) {//HoangCV: đoạn này cần xem lại đang lỗi // đọc thì khá giống format cho nhập số điện thoại, kiểu int với double  `
                    //setTrailingSpaceWhenInput(inputRegisterModel);

                    if(onChangeText != null){
                      onChangeText!(newText);
                    }

                    try {
                      if (inputRegisterModel.controller!.text
                                  .replaceAll(',', '')
                                  .length <=
                              inputRegisterModel.maxLengthTextInput! &&
                          inputRegisterModel.isFormatText) {

                        String str = Utils.convertNumber(double.parse(inputRegisterModel.controller!
                            .text.replaceAll('.', '')));

                        inputRegisterModel.controller!.value = TextEditingValue(
                          text: str,
                          selection: TextSelection.collapsed(
                              offset: str.length),
                        );
                      }
                      // print(inputRegisterModel.controller.text);
                    } catch (e) {
                      print(e);
                    }
                  },
                  onSubmitted: onSubmittedText,
                  maxLength: maxLength,
                  style: TextStyle(
                      color: inputRegisterModel.unit == null
                          ? Colors.black
                          : Color(0xFFA3A3A3),
                      fontSize: 14),
                  decoration: InputDecoration(
                      contentPadding: inputRegisterModel.noBorder
                          ? const EdgeInsets.only(
                              top: 6, bottom: 6, left: 8, right: 0)
                          : const EdgeInsets.only(
                              top: 6, bottom: 6, left: 20, right: 0),
                      isDense: true,
                      hintText: inputRegisterModel.hintText,
                      border: inputRegisterModel.noUnder ? UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColor.back09),
                      ): InputBorder.none,
                      counterText: ''),

                  minLines: 1,
                  maxLines: 5,
                ),
                onFocusChange: (focus){
                  if(!focus){
            /*        print("HoangCV: inputRegisterModel.controller!.text: ${focus}");
                    onSubmittedText;
                    FocusScope.of(context).unfocus();
                    if(inputRegisterModel.controller!=null){
                      print("HoangCV: inputRegisterModel.controller!.text: ${inputRegisterModel.controller!.text}");
                      onEditingComplete!(inputRegisterModel.controller!.text);
                    }*/
                  }
                },
              ),
            ),
            inputRegisterModel.icon != null
                ? GestureDetector(
                    onTap: () {
                      if(inputRegisterModel.typeInputEnum == TypeInputEnum.password ||
                          inputRegisterModel.typeInputEnum == TypeInputEnum.new_password ||
                          inputRegisterModel.typeInputEnum == TypeInputEnum.re_new_password)
                        showPassword!();
                      else
                        inputRegisterModel.controller!.text = "";
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Utils.iconCustom(
                          icon: inputRegisterModel.icon,
                          context: contextParent,
                          size: 30),
                    ),
                  )
                : Container()
          ],
        );
        break;

    // các text container bình thường show số tiền và loại tiền input có 2 tham số các nhau bằng /

// các input dạng có nhập bình thường nhưng có thêm icon đằng sau


// các input dạng Nhập tiền
      case TypeInputRegister.TextFieldMoney:
        return TextField(
          keyboardType: TextInputType.number,
          controller: inputRegisterModel.controller,
          textAlign: TextAlign.right,
          autofocus: false,
          // onTap: () {
          //   inputRegisterModel.controller.selection =
          //       new TextSelection.fromPosition(new TextPosition(
          //           offset: inputRegisterModel.controller.text.length));
          // },
          onChanged: (newText) {
            try {
              setTrailingSpaceWhenInput(inputRegisterModel);
              if (inputRegisterModel.controller!
                  .text
                  .replaceAll('\D', '')
                  .length <=
                  inputRegisterModel.maxLengthTextInput! &&
                  inputRegisterModel.isFormatText) {

                String str = Utils.convertNumber(double.parse(inputRegisterModel.controller!
                    .text.replaceAll('.', '')));
      
                inputRegisterModel.controller!.value = TextEditingValue(
                  text: inputRegisterModel.isDecimalCurrency
                      ? Utils.formatDecimalCurrency(
                      inputRegisterModel.controller!.text, false)
                      : str,
                  selection: TextSelection.collapsed(
                      offset: inputRegisterModel.isDecimalCurrency
                          ? Utils
                          .formatDecimalCurrency(
                          inputRegisterModel.controller!.text, false)
                          .length
                          :str.length),
                );
              }
            } catch(e){
              print("Lỗi money: ${e}");
            }
            // onChangeText(newText);
          },
          onSubmitted: onSubmittedText,
          //onEditingComplete: onEditingComplete!(inputRegisterModel.controller!=null? inputRegisterModel.controller!.text : ''),
          style: TextStyle(
              color: inputRegisterModel.unit == null
                  ? Colors.black
                  : Color(0xFFA3A3A3),
              fontSize: 14),
          decoration: InputDecoration(
            contentPadding:
            EdgeInsets.symmetric(vertical: 6, horizontal: 0),
            isDense: true,
            border: InputBorder.none,
            counterText: '',
          ),
          maxLength: inputRegisterModel.maxLengthTextInput,
        );

        break;
      case TypeInputRegister.Balance:
        return Container();
        break;
      case TypeInputRegister.TextFieldIcon:
        return Container();
        break;
      case TypeInputRegister.Tolge:
        return Container();
        break;
      case TypeInputRegister.Select:
    try {
      // print("HoangCV: run way111111 ${inputRegisterModel.valueSelected} : ${inputRegisterModel.valueSelected.image}");
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                children: [
                  (inputRegisterModel.valueSelected.image != null && inputRegisterModel.valueSelected.image != null && inputRegisterModel.valueSelected.image !='') ?
                  Expanded(
                    child: Image.memory(gaplessPlayback: true,
                    base64Decode(inputRegisterModel.valueSelected.image??
                        ""),
                    height: 50, fit: BoxFit.fitHeight,
                    ),
                  ) : const SizedBox(),
                  Expanded(
                    child: Text(
                      "${inputRegisterModel.valueDefault ?? Extension().getValueDisplay(
                            inputRegisterModel.valueSelected,
                          )}",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      textAlign: inputRegisterModel.textAlign,
                    ),
                  ),
                ],
              ),
            ),
            inputRegisterModel.icon != null
                ? Padding(
                    padding: EdgeInsets.zero,
                    child: Icon(inputRegisterModel.icon, /*fontFamily: fontIconApp*/
                        size: 30 ?? 16, color: color ?? Theme.of(context).primaryColor)
              /*Utils.iconCustom(
                        icon: inputRegisterModel.icon,
                        context: contextParent,
                        size: 30),*/
                  )
                : Container()
          ],
        );
        } catch(e){
      // print("HoangCV: run way111111 ${inputRegisterModel.valueSelected}");
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              "${inputRegisterModel.valueDefault ?? Extension().getValueDisplay(
                inputRegisterModel.valueSelected,
              )}",
              style: TextStyle(color: Colors.black, fontSize: 14),
              textAlign: inputRegisterModel.textAlign,
            ),
          ),
          inputRegisterModel.icon != null
              ? Padding(
            padding: EdgeInsets.only(left: 8),
            child: Transform.rotate(
              angle: inputRegisterModel.rotateIcon ? 180 * pi / 180 : 0,
              child: Utils.iconCustom(
                  icon: inputRegisterModel.icon,
                  context: contextParent,
                  size: 30),
            ),
          )
              : Container()
        ],
      );
    }
        break;
      case TypeInputRegister.MultiSelection:
        return Container();
        break;
      case TypeInputRegister.Non:
        try {
          return TextField(
            enabled: false,
            keyboardType: inputRegisterModel.typeInput,
            controller: inputRegisterModel.controller,
            textAlign: inputRegisterModel.textAlign,
            // onTap: () {
            //   inputRegisterModel.controller.selection =
            //       new TextSelection.fromPosition(new TextPosition(
            //           offset: inputRegisterModel.controller.text.length));
            // },
            onChanged: (newText) {
              setTrailingSpaceWhenInput(inputRegisterModel);
            },
            autofocus: true,
            style: TextStyle(
                color: inputRegisterModel.unit == null
                    ? Colors.black
                    : Color(0xFFA3A3A3),
                fontSize: 14),
            decoration: InputDecoration(
                contentPadding:
                EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                isDense: true,
                prefixIcon: (inputRegisterModel.valueSelected.image != null &&
                    inputRegisterModel.valueSelected.image != null &&
                    inputRegisterModel.valueSelected.image != '') ?
                Image.memory(gaplessPlayback: true,
                  base64Decode(inputRegisterModel.valueSelected.image ??
                      ""),
                  height: 50, fit: BoxFit.fitHeight,
                ) : const SizedBox(),
                border: InputBorder.none,
                counterText: ''),
            minLines: 1,
            maxLines: 2,
          );
        } catch(e){
          //print("HoiangCV: non: 1: ${inputRegisterModel.controller!.text}");
          return TextField(
            enabled: false,
            keyboardType: inputRegisterModel.typeInput,
            controller: inputRegisterModel.controller,
            textAlign: inputRegisterModel.textAlign,
            // onTap: () {
            //   inputRegisterModel.controller.selection =
            //       new TextSelection.fromPosition(new TextPosition(
            //           offset: inputRegisterModel.controller.text.length));
            // },
            onChanged: (newText) {
              setTrailingSpaceWhenInput(inputRegisterModel);
            },
            autofocus: true,
            style: TextStyle(
                color: inputRegisterModel.unit == null
                    ? Colors.black
                    : Color(0xFFA3A3A3),
                fontSize: 14),
            decoration: InputDecoration(
                contentPadding:
                EdgeInsets.symmetric(vertical: 6, horizontal: 0),
                isDense: true,
                border: InputBorder.none,
                counterText: ''),
            minLines: 1,
            maxLines: 2,
          );
        }
        break;

      // các input dạng nhiều dong như nội dung
      case TypeInputRegister.TextFieldRemark:
        int maxLength = 0;
        if (inputRegisterModel.maxLengthTextInput != null) {
          if (inputRegisterModel.isFormatText) {
            maxLength = inputRegisterModel.maxLengthTextInput! +
                (inputRegisterModel.maxLengthTextInput! % 3 == 0
                    ? inputRegisterModel.maxLengthTextInput! ~/ 3 - 1
                    : inputRegisterModel.maxLengthTextInput! ~/ 3);
          } else {
            maxLength = inputRegisterModel.maxLengthTextInput!;
          }
        }
        return TextField(
          controller: inputRegisterModel.controller,
          textAlign: TextAlign.right,
          autofocus: true,
          // onTap: () {
          //   inputRegisterModel.controller.selection =
          //       new TextSelection.fromPosition(new TextPosition(
          //           offset: inputRegisterModel.controller.text.length));
          // },
          onChanged: (newText) {
            setTrailingSpaceWhenInput(inputRegisterModel);
            if (Utils.formatText(inputRegisterModel.controller!.text).length <=
                    inputRegisterModel.maxLengthTextInput &&
                inputRegisterModel.isFormatText) {
              inputRegisterModel.controller!.value = TextEditingValue(
                text: Utils.formatText(
                    inputRegisterModel.controller!.text.toUpperCase()),
                selection: TextSelection.collapsed(
                    offset: Utils.formatText(inputRegisterModel.controller!.text)
                        .length),
              );
            }
          },
          maxLength: maxLength,
          style: TextStyle(
              color: inputRegisterModel.unit == null
                  ? Colors.black
                  : Color(0xFFA3A3A3),
              fontSize: 14),
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 6, horizontal: 0),
              isDense: true,
              border: InputBorder.none,
              counterText: '',
              hintText: inputRegisterModel.hintText),
          minLines: 3,
          maxLines: 3,
        );
        break;

// đây là lựa chọn có hoac không togle


    // các input dạng Nhập tiền
      case TypeInputRegister.TextFieldDate:
        return TextField(
          keyboardType: TextInputType.text,
          controller: inputRegisterModel.controller,
          textAlign: TextAlign.right,
          autofocus: false,
          onChanged: (newText) {
            print("HoangCV : TextFieldDate chạy vào đây: ${newText}");
            setTrailingSpaceWhenInput(inputRegisterModel);
            if (inputRegisterModel.controller!.text
               /* .replaceAll('\D', '')*/
                .length <=
                inputRegisterModel.maxLengthTextInput!) {
              inputRegisterModel.controller!.value = TextEditingValue(
                text: Utils.formatDateTextField(
                    inputRegisterModel.controller!.text),
                selection: TextSelection.collapsed(
                    offset: Utils.formatDateTextField(
                        inputRegisterModel.controller!.text)
                        .length),
              );
            }

            // onChangeText(newText);
          },
          onSubmitted: onSubmittedText,
          onEditingComplete: onEditingComplete!(inputRegisterModel.controller!=null? inputRegisterModel.controller!.text : ''),
          style: TextStyle(
              color: inputRegisterModel.unit == null
                  ? Colors.black
                  : Color(0xFFA3A3A3),
              fontSize: 14),
          decoration: InputDecoration(
            contentPadding:
            EdgeInsets.symmetric(vertical: 6, horizontal: 0),
            isDense: true,
            border: InputBorder.none,
            counterText: '',
          ),
          maxLength: inputRegisterModel.maxLengthTextInput,
        );

        break;
    }
    return Container();
  }
}

void setTrailingSpaceWhenInput(InputRegisterModel inputRegisterModel) {
  TextSelection previousSelection = inputRegisterModel.controller!.selection != null ? inputRegisterModel.controller!.selection : TextSelection(
      baseOffset: 0, extentOffset: inputRegisterModel.controller!.text.length);
  if (inputRegisterModel.controller!.text
          .substring(inputRegisterModel.controller!.text.length - 1) ==
      " ") {
    inputRegisterModel.controller!.value = TextEditingValue(
        text: inputRegisterModel.controller!.text.replaceAll(" ", "\t"),
        selection: previousSelection);
  } else if (inputRegisterModel.controller!.text
          .substring(inputRegisterModel.controller!.text.length - 1) !=
      " ") {
    inputRegisterModel.controller!.value = TextEditingValue(
        text: inputRegisterModel.controller!.text.replaceAll("\t", " "),
        selection: previousSelection);
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
