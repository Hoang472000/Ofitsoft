
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
/*
class TextFormDropDown extends StatefulWidget {
   TextFormDropDown({Key? key,required this.items,required this.value,required this.label,required this.typeInt,required this.deFault}) : super(key: key);
  List<Accountant> items;
   dynamic value;
  String label;
  bool typeInt;
  bool deFault;
  @override
  State<TextFormDropDown> createState() => _TextFormDropDownState();
}

class _TextFormDropDownState extends State<TextFormDropDown> {
        late Accountant _selectedValue;
  @override
  void initState() {
    super.initState();
    if(widget.deFault){
      for(int i=0;i<widget.items.length;i++){
        _selectedValue=widget.items[0];
      }
    }else{
      for(int i=0;i<widget.items.length;i++){
        if(widget.typeInt && widget.items[i].name==widget.value){
          _selectedValue=widget.items[i];
        }
        if(widget.typeInt==false && widget.items[i].value==widget.value){
          _selectedValue=widget.items[i];
        }
      }
    }
    init();
  }
  Future<void> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(widget.deFault){
        if(widget.label==S.of(context).financial_year){
          prefs.setInt(SharedPreferencesKey.financialYear,widget.items[0].value);
        }
        if(widget.label==S.of(context).currency){
          prefs.setString(SharedPreferencesKey.currency,widget.items[0].value);
        }
        if(widget.label==S.of(context).date_format){
          prefs.setInt(SharedPreferencesKey.dateFormat,widget.items[0].value);
        }
        if(widget.label==S.of(context).number_format_type){
          prefs.setInt(SharedPreferencesKey.numberFormatType,widget.items[0].value);
        }
        if(widget.label==S.of(context).export_method){
          prefs.setInt(SharedPreferencesKey.costMethodID,widget.items[0].value);
        }
        if(widget.label==S.of(context).circulars){
          prefs.setInt(SharedPreferencesKey.taxCircularsCompany,widget.items[0].value);
          prefs.setString(SharedPreferencesKey.StrtaxCircularsCompany,widget.items[0].name??"");
        }
        if(widget.label==S.of(context).tax_declaration){
          prefs.setInt(SharedPreferencesKey.taxDecMethod,widget.items[0].value);
        }
        if(widget.label==S.of(context).tax_period){
          prefs.setInt(SharedPreferencesKey.taxPeriod,widget.items[0].value);
        }
        if(widget.label==S.of(context).org_type){
          prefs.setInt(SharedPreferencesKey.orgType,widget.items[0].value);
        }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: DropdownButtonFormField<Accountant>(
        value: _selectedValue,
          isExpanded: true,
          items: widget.items.map<DropdownMenuItem<Accountant>>((Accountant value) {
            return DropdownMenuItem<Accountant>(
              value: value,
              child:widget.typeInt? Text(value.name.toString()):Text(value.value.toString()),
            );
          }).toList(),
        onChanged: (newValue) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          setState(() {
            _selectedValue = newValue!;
            if(widget.label==S.of(context).financial_year){
                  prefs.setInt(SharedPreferencesKey.financialYear,newValue.value);
            }
            if(widget.label==S.of(context).currency){
              prefs.setString(SharedPreferencesKey.currency,newValue.value);
            }
            if(widget.label==S.of(context).date_format){
              prefs.setInt(SharedPreferencesKey.dateFormat,newValue.value);
            }
            if(widget.label==S.of(context).number_format_type){
              prefs.setInt(SharedPreferencesKey.numberFormatType,newValue.value);
            }
            if(widget.label==S.of(context).export_method){
              prefs.setInt(SharedPreferencesKey.costMethodID,newValue.value);
            }
            if(widget.label==S.of(context).circulars){
              prefs.setInt(SharedPreferencesKey.taxCircularsCompany,newValue.value);
              prefs.setString(SharedPreferencesKey.StrtaxCircularsCompany,newValue.name??"");
            }
            if(widget.label==S.of(context).tax_declaration){
              prefs.setInt(SharedPreferencesKey.taxDecMethod,newValue.value);
            }
            if(widget.label==S.of(context).tax_period){
              prefs.setInt(SharedPreferencesKey.taxPeriod,newValue.value);
            }
            if(widget.label==S.of(context).org_type){
              prefs.setInt(SharedPreferencesKey.orgType,newValue.value);
            }
          });
        },
        decoration: InputDecoration(
          label: Text(widget.label,style: StyleBkav.textStyleFW400(Colors.black, 14),),
          contentPadding:
          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:  const BorderSide(color: AppColor.gray70, width: 1.0)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                  color:  Color(0xFFBDBDBD) ,
                  width: 1.0)),
        ),
      ),
    );
  }*/

