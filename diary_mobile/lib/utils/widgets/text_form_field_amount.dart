
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils.dart';

/// Bkav DucLQ custom 1 o nhat text
class TextFieldAmount extends StatefulWidget {
  final TextEditingController _textEditingController;
  final FocusNode _focusNode;
  final bool? isNotEdit; // bkav HanhNTHe: xac dinh xem duoc sua hay khong
  final Function(String)? onChangeCallBack;
  final Function(String)? onLostCallBack;
  final VoidCallback? onHasFocus;
  final bool? isChangeCallBack;
  final bool? isSell;

  const TextFieldAmount(this._textEditingController, this._focusNode,
      {Key? key,
      this.isNotEdit,
      this.onLostCallBack,
      this.isChangeCallBack,
      this.isSell, this.onChangeCallBack, this.onHasFocus})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TextFieldAmountState();
}

class _TextFieldAmountState extends State<TextFieldAmount> {
  bool hideError = false;
  bool onTap = true;
  String textControl = '0';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// Bkav DucLQ ham nay de tao lai deco
  InputDecoration createInputDecoration() {
    return const InputDecoration(
      //fillColor: Color(0xFFFFFFFF),
      //filled: true,
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF08B7DD)),
      ),
      isDense: true,
      contentPadding: EdgeInsets.zero,
      //contentPadding: EdgeInsets.symmetric(vertical: 10),
      border: /*UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ): */
          InputBorder.none,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      child: TextFormField(
          readOnly: widget.isNotEdit ?? false,
          onTap: () {
            setState(() {
              onTap = true;
            });
            widget._focusNode.requestFocus();
          },
          textInputAction: TextInputAction.next,
          focusNode: widget._focusNode,
          keyboardType: TextInputType.number,
          controller: widget._textEditingController,
          decoration: createInputDecoration(),
          obscuringCharacter: "*",
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.top,
          onChanged: (text) => {
            widget.onChangeCallBack!(text),
                setState(() {
                  textControl = text;
                })
              },
          onEditingComplete: () async {
            widget._focusNode.unfocus();
            setState(() {
              hideError = false;
              onTap = false;
            });
          }),
      onFocusChange: (hasFocus) async {
        if (hasFocus == false) {
          widget.onLostCallBack!(textControl);
        } else {
          widget.onHasFocus?.call();
        }
      },
    );
  }
}
