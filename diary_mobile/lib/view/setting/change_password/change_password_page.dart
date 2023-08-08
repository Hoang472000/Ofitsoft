import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../data/repository.dart';
import '../../../generated/l10n.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/change_password_status.dart';
import '../../../utils/utils.dart';
import '../../../utils/widgets/bkav_app_bar.dart';
import '../../../utils/widgets/button_widget.dart';
import '../../../utils/widgets/dialog_manager.dart';
import '../../../utils/widgets/note_pass_word.dart';
import '../../../utils/widgets/text_form_input.dart';
import '../../../view_model/setting/change_password/change_password_bloc.dart';
import '../../login/login_page.dart';

class ChangePassWordPage extends StatefulWidget {
  const ChangePassWordPage({Key? key}) : super(key: key);

  static Route route() {
    return Utils.pageRouteBuilder(const ChangePassWordPage(), true);
  }

  @override
  State<ChangePassWordPage> createState() => _ChangePassWordPageState();
}

class _ChangePassWordPageState extends State<ChangePassWordPage> {
  String onchangePassOld = "";
  String onchangePassNew = "";
  String onchangePassCon = "";
  final TextEditingController _inputPassCurrent = TextEditingController();
  final TextEditingController _inputPassNew = TextEditingController();
  final TextEditingController _inputConfirmPassNew = TextEditingController();
  final FocusNode _focusNodePassCurrent = FocusNode();
  final FocusNode _focusNodePassNew = FocusNode();
  final FocusNode _focusConfirmPassNew = FocusNode();
  final _formKey = GlobalKey<FormState>();
  ValidatePassFail? validatePassFail;
  ChangePasswordFailed? changePasswordFailed;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            ChangePasswordBloc(context, context.read<Repository>()),
        child: BlocListener<ChangePasswordBloc, ChangePasswordState>(
          listener: (context, state) async {
            if (state.formStatus is ChangePasswordSuccess) {
              if (!mounted) return;
              DiaLogManager.displayDialog(
                  context, "", "Thay đổi mật khẩu thành công\nVui lòng đăng nhập lại !", () {}, (
                  ) async {
                // context.read<ChangePasswordBloc>().add(Logout());
                Navigator.of(context, rootNavigator: true)
                    .pushAndRemoveUntil<void>(
                    await LoginPage.route(), (route) => false);
                if (!mounted) return;
                Get.back();
              }, S.of(context).agree, "", dialogComplete: true,dismissible: false);
            } else if (state.formStatus is ChangePasswordFailed) {
            } else if (state.formStatus is ChangeFormSubmitting) {
              DiaLogManager.showDialogLoading(context);
            }
          },
          child: WillPopScope(
            onWillPop: () async {
              Navigator.of(context).pop();
              return false;
            },
            child: Scaffold(
              backgroundColor: AppColor.background,
                appBar: BkavAppBar(
                  context,
                  centerTitle: true,
                  showDefaultBackButton: true,
                  backgroundColor: AppColor.main,
                  title: Text(
                    S.of(context).change_password,
                    style: StyleBkav.textStyleFW700(Colors.white, 20),
                  ),
                ),
                body: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
                    builder: (context, state) {
                      if (state.formStatus is ValidatePassFail) {
                        validatePassFail = state.formStatus as ValidatePassFail;
                      } else if (state.formStatus is ChangePasswordFailed) {
                        changePasswordFailed =
                        state.formStatus as ChangePasswordFailed;
                      }
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: Container(
                          //color: Colors.white,
                          height: double.infinity,
                          width: double.infinity,
                          child: Form(
                            key: _formKey,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 32),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    const NotePassWord(),
                                    Container(
                                        margin: const EdgeInsets.only(top: 25),
                                        child: TextFormFieldInput(
                                          noBorder: false,
                                          underLine: false,
                                          S.of(context).pass_current,
                                          _inputPassCurrent,
                                          true,
                                          (state.formStatus is ValidatePassFail &&
                                              validatePassFail?.errorPassCurrent !=
                                                  "")
                                              ? true
                                              : false,
                                          _focusNodePassCurrent,
                                          (state.formStatus is ValidatePassFail &&
                                              validatePassFail?.errorPassCurrent !=
                                                  "")
                                              ? validatePassFail!.errorPassCurrent
                                              : S.of(context).pass_empty,
                                              (lostFocus) {
                                            context.read<ChangePasswordBloc>().add(
                                                ValidatePassNew(
                                                    passCurrent:
                                                    _inputPassCurrent.text,
                                                    passNew: _inputPassNew.text,
                                                    passNewConfirm:
                                                    _inputConfirmPassNew.text,
                                                    context: context));
                                            if (!lostFocus) {
                                              _focusNodePassNew.requestFocus();
                                            }
                                          },
                                          true,
                                          //icons: '',
                                          onChangeCallBack: (text) {
                                            setState(() {
                                              onchangePassOld = text;
                                            });
                                          },// textCapitalization: false,
                                          // false
                                        )),
                                    Container(
                                      margin: const EdgeInsets.only(top: 25),
                                      child: TextFormFieldInput(
                                        noBorder: false,
                                        underLine: false,
                                        S.of(context).pass_new,
                                        _inputPassNew,
                                        true,
                                        (state.formStatus is ValidatePassFail &&
                                            validatePassFail?.errorPassNew !=
                                                "")
                                            ? true
                                            : false,
                                        _focusNodePassNew,
                                        (state.formStatus is ValidatePassFail &&
                                            validatePassFail?.errorPassNew !=
                                                "")
                                            ? validatePassFail!.errorPassNew
                                            : S.of(context).pass_empty,
                                            (lostFocus) {
                                          context.read<ChangePasswordBloc>().add(
                                              ValidatePassNew(
                                                  passCurrent:
                                                  _inputPassCurrent.text,
                                                  passNew: _inputPassNew.text,
                                                  passNewConfirm:
                                                  _inputConfirmPassNew.text,
                                                  context: context));
                                          if (!lostFocus) {
                                            _focusConfirmPassNew.requestFocus();
                                          }
                                        },
                                        true,
                                        //icons: '',
                                        onChangeCallBack: (text) {
                                          setState(() {
                                            onchangePassNew = text;
                                            context.read<ChangePasswordBloc>().add(
                                                ValidatePassNew(
                                                    passCurrent:
                                                    onchangePassOld,
                                                    passNew: onchangePassNew,
                                                    passNewConfirm:
                                                    onchangePassCon,
                                                    context: context));
                                          });
                                        }, //textCapitalization: false,
                                      ),
                                    ),
                                    Container(
                                        margin: const EdgeInsets.only(top: 25),
                                        child: TextFormFieldInput(
                                          noBorder: false,
                                          underLine: false,
                                          S.of(context).confirm_pass_new,
                                          _inputConfirmPassNew,
                                          true,
                                          (state.formStatus is ValidatePassFail &&
                                              validatePassFail
                                                  ?.errorPassNewConfirm !=
                                                  "")
                                              ? true
                                              : false,
                                          _focusConfirmPassNew,
                                          (state.formStatus is ValidatePassFail &&
                                              validatePassFail
                                                  ?.errorPassNewConfirm !=
                                                  "")
                                              ? validatePassFail!
                                              .errorPassNewConfirm
                                              : S.of(context).pass_empty,
                                              (lostFocus) {
                                            context.read<ChangePasswordBloc>().add(
                                                ValidatePassNew(
                                                    passCurrent:
                                                    _inputPassCurrent.text,
                                                    passNew: _inputPassNew.text,
                                                    passNewConfirm:
                                                    _inputConfirmPassNew.text,
                                                    context: context));
                                            if (!lostFocus) {
                                              FocusScope.of(context).unfocus();
                                            }
                                          },
                                          true,
                                          //icons: '',
                                          onChangeCallBack: (string) {
                                            setState(() {
                                              onchangePassCon = string;
                                            });
                                          }, //textCapitalization: false,
                                        )),
                                    // const NotePassWord(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(top: 80),
                                          width: 180,
                                          child:onchangePassCon==onchangePassNew&&onchangePassOld!=onchangePassNew&&onchangePassNew.isNotEmpty&&onchangePassOld.length>=8&&validatePassFail?.errorPassNew==""
                                              ? BkavButton(
                                            text: S.of(context).agree,
                                            onPressed: () async {
                                              String passCurrent =
                                                  _inputPassCurrent.text;
                                              String passNew =
                                                  _inputPassNew.text;
                                              String confirmPassNew =
                                                  _inputConfirmPassNew.text;
                                              _formKey.currentState!
                                                  .validate();
                                              if (validatePassFail
                                                  ?.errorPassCurrent ==
                                                  "" &&
                                                  passCurrent.isNotEmpty) {
                                                if (validatePassFail
                                                    ?.errorPassNew !=
                                                    "" ||
                                                    passNew.isEmpty) {
                                                  _focusNodePassNew
                                                      .requestFocus();
                                                } else if (validatePassFail
                                                    ?.errorPassNewConfirm !=
                                                    "" ||
                                                    confirmPassNew.isEmpty) {
                                                  _focusConfirmPassNew
                                                      .requestFocus();
                                                }
                                              } else {
                                                _focusNodePassCurrent
                                                    .requestFocus();
                                              }
                                              if (changePasswordFailed !=
                                                  null) {
                                                _focusNodePassCurrent
                                                    .requestFocus();
                                              }
                                              if (passCurrent.isNotEmpty &&
                                                  passNew.isNotEmpty &&
                                                  confirmPassNew.isNotEmpty) {
                                                context
                                                    .read<
                                                    ChangePasswordBloc>()
                                                    .add(ValidatePassNew(
                                                    passCurrent:
                                                    passCurrent,
                                                    passNew: passNew,
                                                    passNewConfirm:
                                                    confirmPassNew,
                                                    context: context,
                                                    submit: true));
                                                requestFocus();
                                              }
                                            },
                                            color: AppColor.main,
                                          )
                                              : BkavButton(
                                            text: S.of(context).agree,
                                            onPressed: () {
                                              context
                                                  .read<
                                                  ChangePasswordBloc>()
                                                  .add(SubmissionChangePassword(
                                                  _inputPassCurrent.text, _inputPassNew.text));
                                            },
                                            color: AppColor.main
                                                .withOpacity(0.3),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    })),
          ),
        ));
  }

  void requestFocus() {
    if (validatePassFail != null) {
      if (validatePassFail!.errorPassCurrent == "" &&
          _inputPassCurrent.text.isNotEmpty) {
        if (validatePassFail!.errorPassNew != "" ||
            _inputPassNew.text.isEmpty) {
          _focusNodePassNew.requestFocus();
        } else if (validatePassFail!.errorPassNewConfirm != "" ||
            _inputConfirmPassNew.text.isEmpty) {
          _focusConfirmPassNew.requestFocus();
        }
      } else {
        _focusNodePassCurrent.requestFocus();
      }
    } else {
      if (_inputPassCurrent.text.isEmpty) {
        _focusNodePassCurrent.requestFocus();
      } else if (_inputPassNew.text.isEmpty) {
        _focusNodePassNew.requestFocus();
      } else if (_inputConfirmPassNew.text.isEmpty) {
        _focusConfirmPassNew.requestFocus();
      }
    }
  }
}
