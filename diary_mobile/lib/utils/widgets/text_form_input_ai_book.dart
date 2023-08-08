
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../generated/l10n.dart';
import '../../resource/assets.dart';
import '../../resource/color.dart';
import '../../resource/style.dart';
import '../logger.dart';

/// Bkav DucLQ custom 1 o nhat text
class TextFormFieldInputAiBook extends StatefulWidget {
  final String _label;
  final TextEditingController _textEditingController;
  final bool _isTypePassword;
  final bool _errorValidate;
  final FocusNode _focusNode;
  final String errorValidate;
  final Function(bool) checkPass;
  final bool changePass;
  final bool redBoder;
  final bool?
      isNotValidStart; // HanhNTHe: xac dinh xem truong thong tin co bat buoc hay khong
  final bool? isPhone;
  final bool? isFromEnterInfo;
  final bool? isTime; // hanhNTHe: xac dinh truong chon thoi gian
  final bool? isNotEdit; // bkav HanhNTHe: xac dinh xem duoc sua hay khong
  final bool? isNotPass;
  final bool? isEnable;
  final TextInputType? keyboardType;

  const TextFormFieldInputAiBook(
      this._label,
      this._textEditingController,
      this._isTypePassword,
      this._errorValidate,
      this._focusNode,
      this.errorValidate,
      this.checkPass,
      this.changePass,
      this.redBoder,
      {Key? key,
      this.isNotValidStart,
      this.isPhone,
      this.isFromEnterInfo,
      this.isTime, this.isNotEdit,
      this.isNotPass,this.isEnable,  this.keyboardType})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TextFormFieldInputState();
}

class _TextFormFieldInputState extends State<TextFormFieldInputAiBook> {
  bool _showDeleteText = true;
  bool _obscureText = true;
  bool _showAsterisk = false;
  bool _textIsNotEmpty = false;
  bool _validatorTextIsEmpty = false;
  bool hideError = false;
  bool onTap = true;

  //Bkav Nhungltk
  bool _hasFocus = false;

  // HanhNTHe add
  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2060),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary:
                  AppColor.main, // header background color// body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        widget._textEditingController.text =
            "${selectedDate.day < 10 ? "0${selectedDate.day}" : selectedDate.day}/${selectedDate.month < 10 ? "0${selectedDate.month}" : selectedDate.month}/${selectedDate.year}";
      });
    }
  }

  //final FocusNode _focusNode= FocusNode();

  _TextFormFieldInputState();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// Bkav DucLQ show icon * mau do
  void showAsterrick(bool show) {
    setState(() {
      _showAsterisk = show;
    });
  }

  //Bkav Nhungltk: hien thi thong bao text null
  void textIsNotEmplty(bool textIsNotEmpty) {
    setState(() {
      _validatorTextIsEmpty = !textIsNotEmpty;
    });
  }

  /// Bkav DucLQ ham nay de tao lai deco
  InputDecoration createInputDecoration() {
    return InputDecoration(
        fillColor: Colors.white,
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        enabledBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide:widget.redBoder?const BorderSide(color: AppColor.main, width: 1.0): const BorderSide(color: AppColor.gray1, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(color: AppColor.main, width: 1.0)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(
                color: widget.isNotEdit ?? false
                    ? AppColor.redDD
                    : (widget._errorValidate || _validatorTextIsEmpty) &&
                            !hideError &&
                            (widget.isNotValidStart == null ||
                                (widget.isNotValidStart != null &&
                                    !widget.isNotValidStart!))
                        ? AppColor.redDD
                        : const Color(0xFFBDBDBD) /*Bkav Nhungltk*/,
                width: 1.0)),
 /*       errorText: widget.isNotEdit ?? false//
            ? widget.errorValidate
            : (widget.isNotValidStart == null ||
                    (widget.isNotValidStart != null &&
                        !widget.isNotValidStart!))
                ? (widget.changePass == true &&
                        _validatorTextIsEmpty &&
                        !hideError && !(widget.isNotPass ?? false)
                    // ? "${widget._label} ${S.of(context).not_emty}"
                      ? S.of(context).pass_empty
                    : (widget._errorValidate || _validatorTextIsEmpty) &&
                            !hideError
                        ? widget.errorValidate
                        : null)
                : null,*/
        // label: (_showAsterisk /*Bkav Nhungltk && (_notEmpty*/ ||
        //         _textIsNotEmpty) /*)*/
        //     ? Row(
        //         mainAxisSize: MainAxisSize.min,
        //         children: <Widget>[
        //           Flexible(
        //             child: Text(widget._label,
        //                 style: StyleBkav.textStyleFW400(
        //                     _hasFocus || _textIsNotEmpty
        //                         ? AppColor.black22
        //                         : AppColor.labelInputText,
        //                     0)),
        //           ),
        //           widget.isNotValidStart == null ||
        //                   (widget.isNotValidStart != null &&
        //                       !widget.isNotValidStart!)
        //               ? Flexible(
        //                   child: Text("*",
        //                       style:
        //                           StyleBkav.textStyleFW400(AppColor.redDD, 0)),
        //                 )
        //               : Container()
        //         ],
        //       )
        //     : (widget.isNotValidStart != null && !widget.isNotValidStart!)
        //         ? RichText(
        //             text: TextSpan(children: [
        //               TextSpan(
        //                   text: widget._label,
        //                   style: StyleBkav.textStyleFW400(
        //                       AppColor.labelInputText, 14)),
        //               TextSpan(
        //                   text: "*",
        //                   style: StyleBkav.textStyleFW400(AppColor.redDD, 16)),
        //             ]),
        //             textScaleFactor: MediaQuery.of(context).textScaleFactor,
        //           )
        //         : Text(widget._label,
        //             style:
        //                 StyleBkav.textStyleFW400(AppColor.labelInputText, 15)),
        labelText:" ${widget._label}",
        labelStyle:  widget.redBoder?StyleBkav.textStyleFW400(AppColor.main, 14):StyleBkav.textStyleFW400(AppColor.gray11, 14),
        hintText: " ${widget._label}",
        hintStyle:  widget.redBoder?StyleBkav.textStyleFW400(AppColor.main, 14):StyleBkav.textStyleFW400(AppColor.gray1, 14),
        suffixIcon: widget.isNotEdit ?? false
            ? null
            : widget.isTime != null && _showDeleteText && _hasFocus
                ? IconButton(
                    color: AppColor.black22,
                    //Bkav HanhNTHe: open lich
                    icon: SvgPicture.asset(
                      IconAsset.icLich,
                      width: 16,
                      height: 16,
                    ),
                    onPressed: () {
                      _selectDate(context);
                      // setState(() {
                      //   _obscureText = !_obscureText;
                      // });
                    },
                  )
                : (!widget._isTypePassword
                    ? _showDeleteText && _hasFocus
                        ?
                          // Row(
                          //   mainAxisAlignment:
                          //       MainAxisAlignment.center, // added line
                          //   mainAxisSize: MainAxisSize.min, // added line
                          //   children: <Widget>[
                          //       Container(
                          //           width: 24,
                          //           height: 24,
                          //           decoration: const BoxDecoration(
                          //             // image: DecorationImage(
                          //             //     image: AssetImage(
                          //             //         IconAsset.backgroundClear),
                          //             //     fit: BoxFit.cover),
                          //           ),
                          //           child: Transform.scale(
                          //             scale: 2,
                          //             child: IconButton(
                          //               color: AppColor.black22,
                          //               icon:
                          //                   //Bkav Nhungltk: fix loi fucus bi mau xanh
                          //                   const Icon(
                          //                 Icons.clear,
                          //                 color: AppColor.black22,
                          //                 size: 8,
                          //               ),
                          //               onPressed: () {
                          //                 widget._textEditingController.clear();
                          //                 _textIsNotEmpty = false;
                          //                 showDeleteText(false);
                          //               },
                          //             ),
                          //           ))
                          //     ])
                        null
                        : null
                    : _showDeleteText && _hasFocus //Bkav Nhungltk
                        ? Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween, // added line
                            mainAxisSize: MainAxisSize.min, // added line
                            children: <Widget>[
                              // Container(
                              //     width: 24,
                              //     height: 24,
                              //     decoration: const BoxDecoration(
                              //       // image: DecorationImage(
                              //       //     image: AssetImage(
                              //       //         IconAsset.backgroundClear),
                              //       //     fit: BoxFit.cover),
                              //     ),
                              //     child: Transform.scale(
                              //       scale: 2,
                              //       child: IconButton(
                              //         color: AppColor.black22,
                              //         icon: const Icon(
                              //           Icons.clear,
                              //           color: AppColor.black22,
                              //           size: 8,
                              //         ),
                              //         onPressed: () {
                              //           widget._textEditingController.clear();
                              //           //Bkav Nhungltk
                              //           _textIsNotEmpty = false;
                              //           showDeleteText(false);
                              //         },
                              //       ),
                              //     )),
                              IconButton(
                                color: AppColor.black22,
                                //Bkav Nhungltk: fix loi fucus bi mau xanh
                                icon: _obscureText
                                    ? SvgPicture.asset(
                                  IconAsset.eyeOn,
                                  width: 16,
                                  height: 16,
                                )
                                    : SvgPicture.asset(
                                        IconAsset.eyeOff,
                                        width: 16,
                                        height: 16,
                                      ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                            ],
                          )
                        : IconButton(
                            color: AppColor.black22,
                            //Bkav Nhungltk: fix loi fucus bi mau xanh
                            icon: _obscureText
                                ? SvgPicture.asset(
                              IconAsset.eyeOn,
                              width: 16,
                              height: 16,
                            )
                                : SvgPicture.asset(
                                    IconAsset.eyeOff,
                                    width: 16,
                                    height: 16,
                                  ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          )));
  }

  ///Bkav DucLQ ham nay de show Icon delete
  void showDeleteText(bool show) {
    setState(() {
      Logger.loggerDebug("show Delete $show");
      _showDeleteText = show;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget._textEditingController.text.isNotEmpty) {
      _textIsNotEmpty = true;
    }
    return Focus(
      child: TextFormField(
        style: widget.redBoder?StyleBkav.textStyleFW400(AppColor.main, 14,height: 1.2):StyleBkav.textStyleFW400(Colors.black, 14,height: 1.2),
        enabled: widget.isEnable,
          readOnly: widget.isNotEdit ?? false,
          onTap: () {
            setState(() {
              onTap = true;
            });
            widget._focusNode.requestFocus();
          },
          textInputAction: TextInputAction.next,
          focusNode: widget._focusNode,
          keyboardType:
              widget.keyboardType,
          controller: widget._textEditingController,
          decoration: createInputDecoration(),
          obscureText: widget._isTypePassword ? _obscureText : false,
          cursorColor: AppColor.main,
          cursorHeight: 20,
          obscuringCharacter: "*",
          onChanged: (text) => {
                showDeleteText((text.isNotEmpty)),
                if ((text.isNotEmpty /*Bkav Nhungltk && _isTypePassword*/) !=
                    _showDeleteText)
                  {
                    if (!text.isNotEmpty)
                      {
                        //Bkav HoangCV: check dieu kien khi text null
                        _textIsNotEmpty = false,
                      } // Bkav HoangCV: check khi co text trong form thi ko hien thong bao nhap text
                    else
                      {
                        textIsNotEmplty(true),
                      }
                  }
                else if (text.isNotEmpty)
                  {
                    _textIsNotEmpty = true,
                    textIsNotEmplty(true),
                    setState(() {
                      hideError = true;
                    })
                  }
                else
                  {
                    _textIsNotEmpty = false,
                    textIsNotEmplty(false),
                  }
              },
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              textIsNotEmplty(false);
            }
            setState(() {
              hideError = false;
            });
            //return null;
          },
          onEditingComplete: () async {
            widget._focusNode.unfocus();
            setState(() {
              hideError = false;
              onTap = false;
            });
            if (onTap == false && widget.changePass == true) {
              setState(() {
                onTap = true;
              });
              onLostFocus(widget._textEditingController.text, false);
            }
          }),
      onFocusChange: (hasFocus) async {
        showAsterrick(hasFocus);
        //Bkav Nhungltk:
        setState(() {
          _hasFocus = hasFocus;
          if (hasFocus == false) {
            hideError = false;
          }
        });
        if (hasFocus == false) {
          onLostFocus(widget._textEditingController.text, true);
        }
      },
    );
  }

  void onLostFocus(String text, bool lostFocus) {
    if (text.isEmpty) {
      textIsNotEmplty(false);
    } else {
      textIsNotEmplty(true);
    }
    widget.checkPass(lostFocus);
  }
}
