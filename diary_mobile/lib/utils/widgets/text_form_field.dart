
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../generated/l10n.dart';
import '../../resource/color.dart';
import '../../resource/style.dart';

class BkavTextFormField extends StatefulWidget{
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final String label;
  final String content;
  final bool cannotEdit;
  final String subfixIcon;
  final bool checkEmpty;
  final bool noteNotEmpty;
  final VoidCallback onEditComplete;
  final bool? noBorder;
  const BkavTextFormField({
    required this.textEditingController,
    required this.focusNode,
    required this.label,
    required this.content,//default ""
    required this.cannotEdit,//default false
    required this.subfixIcon,
    this.checkEmpty= true,
    this.noteNotEmpty= false,
    required this.onEditComplete,
    Key? key, this.noBorder = false}): super(key: key);
  @override
  State<StatefulWidget> createState() => _BkavTextFormFieldState();
}

class _BkavTextFormFieldState extends State<BkavTextFormField>{
  bool hasFocus= false;
  bool readyOnly= true;
  bool? textEmpty;
  String? text;
  TextEditingController? controller;

  void textIsEmpty(bool isTextEmpty){
    setState(() {
      textEmpty= isTextEmpty;
    });
  }

  Widget subfixIconClear(){
    return Visibility(
        visible: textEmpty== false && widget.cannotEdit== false && hasFocus,
        child: IconButton(
                color: AppColor.black22,
                icon:
                //Bkav Nhungltk: fix loi fucus bi mau xanh
                const Icon(
                  Icons.clear,
                  color: AppColor.main,
                  size: 16,
                ),
                onPressed: () {
                  widget.textEditingController.clear();
                  textIsEmpty(true);
                },
              ));
  }
  @override
  void dispose() {
    widget.textEditingController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.content.isNotEmpty) {
      controller = TextEditingController(text: widget.content);
    }else{
      controller= widget.textEditingController;
    }
    return Focus(
      child: TextFormField(
      textInputAction: TextInputAction.next,
      textAlign: widget.noBorder==true?TextAlign.end:TextAlign.start,
      readOnly: widget.cannotEdit,
      focusNode: widget.focusNode,
      controller: controller,
      validator: (value){
        if(value!.isEmpty) {
          textIsEmpty(true);
          return null;
        }else{
          textIsEmpty(false);
          return null;
        }
      },
        onChanged: (value){
          if(value.isNotEmpty){
            textIsEmpty(false);
          }
        },
        onEditingComplete: (){
          widget.onEditComplete();
        },
      decoration: InputDecoration(
         suffixIcon: widget.subfixIcon!=""?  Row(children: [
          subfixIconClear(),
          IconButton(icon: SvgPicture.asset(widget.subfixIcon), onPressed: () {
            setState(() {
              readyOnly= false;
            });
          },)],): (!widget.cannotEdit && textEmpty== false  && hasFocus)? subfixIconClear(): null,
        border: widget.noBorder==false?border(Color(0xFFBDBDBD)):const UnderlineInputBorder(),
        label: !widget.noteNotEmpty? Text(
          widget.label,
          style: StyleBkav.textStyleFW400(AppColor.gray9F, 12),
        ):
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: Text(widget.label,
                  style: StyleBkav.textStyleFW400(AppColor.gray9F, 12)),
            ),
            Flexible(
              child: Text("*",
                  style:
                  StyleBkav.textStyleFW400(AppColor.redDD, 16)),
            )
          ],
        ),
        errorBorder: border(Colors.red ),
        errorText: widget.cannotEdit && hasFocus? S.of(context).warning_cannot_edit:
        textEmpty==true && !widget.cannotEdit && hasFocus==false? S.of(context).error_input_empty : null,
        contentPadding: widget.noBorder==false?const EdgeInsets.only(top: 9, bottom: 9, left: 12, right: 12):const EdgeInsets.only(top: 9, bottom: 9),
      ),
    ),
    onFocusChange: (focus){
      setState(() {
        hasFocus= focus;
      });
      if(focus== false){
        if(widget.textEditingController.text.isEmpty){
          textIsEmpty(true);
        }
      }
    },);
  }

  InputBorder border(Color color){
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(
    color: color, width: 1.0));
  }

}