
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../generated/l10n.dart';
import '../../../resource/assets.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../logger.dart';
import '../../utils.dart';

///custom 1 o nhat text
class TextFormFieldInputText extends StatefulWidget {
  final String _label;
  final TextEditingController _textEditingController;
  final bool _isTypePassword;

  final bool _errorValidate;
  final FocusNode _focusNode;
  final String errorValidate;
  final Function(bool) checkPass;
  final bool changePass;
  final bool?
  isNotValidStart; // xac dinh xem truong thong tin co bat buoc hay khong
  final bool? isPhone;
  final bool? isNumber;
  final bool? isFromEnterInfo;
  final bool? isTime; // xac dinh truong chon thoi gian
  final bool? isNotEdit; // xac dinh xem duoc sua hay khong
  final bool? isNotPass;
  final bool? noBorder; // set noBorder
  final bool? underLine; // dung underLine thay cho OutLine
  final Function(String)? onChangeCallBack;
  final bool? isChangeCallBack;
  final int? minLine;
  final bool? isShowAsterrick;

  const TextFormFieldInputText(
      this._label,
      this._textEditingController,
      this._isTypePassword,
      this._errorValidate,
      this._focusNode,
      this.errorValidate,
      this.checkPass,
      this.changePass,
      {Key? key,
        this.isNotValidStart,
        this.isPhone,
        this.isNumber,
        this.isFromEnterInfo,
        this.isTime, this.isNotEdit,
        this.isNotPass, this.noBorder, this.underLine,
        this.onChangeCallBack, this.isChangeCallBack, this.minLine, this.isShowAsterrick = true})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TextFormFieldInputTextState();
}

class _TextFormFieldInputTextState extends State<TextFormFieldInputText> {
  bool _showDeleteText = true;
  bool _obscureText = true;
  bool _showAsterisk = false;
  bool _textIsNotEmpty = false;
  bool _validatorTextIsEmpty = false;
  bool hideError = false;
  bool onTap = true;

  bool _hasFocus = false;

  //HoangCV add
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

  _TextFormFieldInputTextState();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///show icon * mau do
  void showAsterrick(bool show) {
    setState(() {
      _showAsterisk = show;
    });
  }

  //hien thi thong bao text null
  void textIsNotEmplty(bool textIsNotEmpty) {
    setState(() {
      _validatorTextIsEmpty = !textIsNotEmpty;
    });
  }

  ///ham nay de tao lai deco
  InputDecoration createInputDecoration() {
    return InputDecoration(
        fillColor: const Color(0xFFFFFFFF),
        counterText: "",
        filled: true,
        contentPadding:
        widget.noBorder == false ?
        const EdgeInsets.only(
            top: 6, bottom: 6, left: 8, right: 0):
        const EdgeInsets.only(
            top: 6, bottom: 6, left: 20, right: 0),
        focusedBorder: widget.underLine == false ?
        OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFA3A3A3), width: 1.0)):
        UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFA3A3A3)),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFA3A3A3), width: 1.0)),
        border:
        OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
                color: widget.isNotEdit ?? false
                    ? Color(0xFFA3A3A3)
                    : (widget._errorValidate || _validatorTextIsEmpty) &&
                    !hideError &&
                    (widget.isNotValidStart == null ||
                        (widget.isNotValidStart != null &&
                            !widget.isNotValidStart!))
                    ? AppColor.redDD
                    : Color(0xFFA3A3A3),
                width: 1.0)),
        errorText: widget.isNotEdit ?? false//
            ? widget.errorValidate
            : (widget.isNotValidStart == null ||
            (widget.isNotValidStart != null &&
                !widget.isNotValidStart!))
            ? (widget.changePass == true &&
            _validatorTextIsEmpty &&
            !hideError && !(widget.isNotPass ?? false)
            ? "${widget._label} ${S.of(context).not_emty}"
            : (widget._errorValidate || _validatorTextIsEmpty) &&
            !hideError
            ? widget.errorValidate
            : null)
            : null,
        label: (_showAsterisk /*&& (_notEmpty*/ ||
            _textIsNotEmpty) /*)*/
            ? Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: Text(widget._label,
                  style: StyleOfit.textStyleFW400(
                      _hasFocus || _textIsNotEmpty
                          ? AppColor.black22
                          : AppColor.labelInputText,
                      14)),
            ),
            widget.isNotValidStart == null ||
                (widget.isNotValidStart != null &&
                    !widget.isNotValidStart!)
                ? Flexible(
              child: Text(" *",
                  style:
                  StyleOfit.textStyleFW400(AppColor.redDD, 14)),
            )
                : Container()
          ],
        )
            : (widget.isNotValidStart != null && !widget.isNotValidStart!)
            ? RichText(
          text: TextSpan(children: [
            TextSpan(
                text: widget._label,
                style: StyleOfit.textStyleFW400(
                    AppColor.labelInputText, 14)),
            TextSpan(
                text: "*",
                style: StyleOfit.textStyleFW400(AppColor.redDD, 16)),
          ]),
          textScaleFactor: MediaQuery.of(context).textScaleFactor,
        )
            : Text(widget._label,
            style:
            StyleOfit.textStyleFW400(AppColor.labelInputText, 14)),
        suffixIcon: widget.isNotEdit ?? false || widget.noBorder == true
            ? null
            : widget.isTime != null && _showDeleteText && _hasFocus
            ? IconButton(
          color: AppColor.black22,
          //open lich
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
            ? Row(
            mainAxisAlignment:
            MainAxisAlignment.center, // added line
            mainAxisSize: MainAxisSize.min, // added line
            children: <Widget>[
              Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    // image: DecorationImage(
                    //     image: AssetImage(
                    //         IconAsset.backgroundClear),
                    //     fit: BoxFit.cover),
                  ),
                  child: Transform.scale(
                    scale: 2,
                    child: IconButton(
                      color: AppColor.black22,
                      icon:
                      //fix loi fucus bi mau xanh
                      const Icon(
                        Icons.clear,
                        color: AppColor.main,
                        size: 8,
                      ),
                      onPressed: () {
                        widget._textEditingController.clear();
                        _textIsNotEmpty = false;
                        showDeleteText(false);
                      },
                    ),
                  ))
            ])
            : null
            : _showDeleteText && _hasFocus //
            ? Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween, // added line
          mainAxisSize: MainAxisSize.min, // added line
          children: <Widget>[
            Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  // image: DecorationImage(
                  //     image: AssetImage(
                  //         IconAsset.backgroundClear),
                  //     fit: BoxFit.cover),
                ),
                child: Transform.scale(
                  scale: 2,
                  child: IconButton(
                    color: AppColor.black22,
                    icon: const Icon(
                      Icons.clear,
                      color: AppColor.main,
                      size: 8,
                    ),
                    onPressed: () {
                      widget._textEditingController.clear();
                      //
                      _textIsNotEmpty = false;
                      showDeleteText(false);
                    },
                  ),
                )),
            IconButton(
              color: AppColor.black22,
              //fix loi fucus bi mau xanh
              icon: _obscureText
                  ? const Icon(
                Icons.remove_red_eye,
                color: AppColor.main,
                size: 16,
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
          //fix loi fucus bi mau xanh
          icon: _obscureText
              ? const Icon(
            Icons.remove_red_eye,
            color: AppColor.main,
            size: 16,
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

  ///ham nay de show Icon delete
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
      child: TextField(
          readOnly: widget.isNotEdit ?? false,
          onTap: () {
            setState(() {
              onTap = true;
            });
            widget._focusNode.requestFocus();
          },
          style: TextStyle(
              color: Colors.black,
              fontSize: 14),
          textInputAction: TextInputAction.done,
          focusNode: widget._focusNode,
          maxLength: null,
          maxLines: null,
          minLines: widget.minLine != null ? widget.minLine : 5,
          maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds ,
          keyboardType:
          widget.isPhone != null ? TextInputType.phone :
          widget.isNumber != null ? TextInputType.number : TextInputType.text,
          controller: widget._textEditingController,
          decoration: createInputDecoration(),
          obscureText: widget._isTypePassword ? _obscureText : false,
          obscuringCharacter: "*",
          textAlign: /*widget.noBorder==true? TextAlign.right : */TextAlign.start ,
          onSubmitted: (text){
            widget.onChangeCallBack!(text);
          },
          onChanged: (text) => {
            if (widget.isChangeCallBack == true)
              {
                widget.onChangeCallBack!(text),
              },
            showDeleteText((text.isNotEmpty)),
            if ((text.isNotEmpty /*&& _isTypePassword*/) !=
                _showDeleteText)
              {
                if (!text.isNotEmpty)
                  {
                    //check dieu kien khi text null
                    _textIsNotEmpty = false,
                  } //check khi co text trong form thi ko hien thong bao nhap text
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
          /*validator: (String? value) {
            if (value == null || value.isEmpty) {
              textIsNotEmplty(false);
            }
            setState(() {
              hideError = false;
            });
            //return null;
          },*/
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
        setState(() {
          _hasFocus = hasFocus;
          if (hasFocus == false) {
            hideError = false;
          }
        });
        if (hasFocus == false && widget.changePass == true) {
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
