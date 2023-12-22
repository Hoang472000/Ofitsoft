import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/l10n.dart';
import '../../resource/assets.dart';
import '../../resource/color.dart';
import '../../resource/style.dart';
import '../../utils/constants/shared_preferences_key.dart';
import '../../utils/status/forget_password_status.dart';
import '../../utils/logger.dart';
import '../../utils/utils.dart';
import '../../utils/widgets/bkav_app_bar.dart';
import '../../utils/widgets/button_widget.dart';
import '../../utils/widgets/note_pass_word.dart';
import '../../utils/widgets/input/text_form_input_password.dart';
import '../../view_model/account/forget_password_bloc.dart';
import '../login/login_page.dart';
import '../otp/get_otp_bloc.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage.init({Key? key, required this.userName})
      : super(key: key);
  static Future<Route> route(String username) async {
    final prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString(SharedPreferencesKey.userName) ?? "";
    return Utils.pageRouteBuilder(
        ForgetPasswordPage.init(
          userName: username,
        ),
        true);
  }

  final String userName;
  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  static const maxSeconds = 120;
  int seconds = 0;
  Timer? timer;
  //late ai_book.AiBookDb _db;
  final _formKey = GlobalKey<FormState>();
  bool isSend = false;
  bool isEnabled = true;
  String email = "";
  final TextEditingController _inputOtpController = TextEditingController();
  TextEditingController _inputUserNameController = TextEditingController();

  final TextEditingController _inputPasswordController =
      TextEditingController();

  final TextEditingController _inputConfPasswordController =
      TextEditingController();

  final FocusNode _focusNodeOtp = FocusNode();
  final FocusNode _focusUserName = FocusNode();

  final FocusNode _focusNodePassword = FocusNode();

  final FocusNode _focusNodeConfPassword = FocusNode();
  ValidatePassFail? validatePassFail;
  ForgetPasswordFailed? forgetPasswordFailed;
  void startTime() {
    seconds = maxSeconds;
    timer = Timer.periodic(Duration(seconds: 1), (_) async {
      if (seconds > 0) {
        if (mounted) {
          setState(() => seconds--);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    //_db = ai_book.AiBookDb.instance;
    getListUser();
    _inputUserNameController = TextEditingController(text: widget.userName);
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //     statusBarColor: Colors.transparent,
    //     statusBarIconBrightness: Brightness.light,
    //     statusBarBrightness: Brightness.light
    //     ));
  }

  //HoangCV lay email tu db
  void getListUser() async {
/*    List<UserInfo> list = await _db.getlistUser();
    for (int i = 0; i < list.length; i++) {
      if (list[i].userName == _inputUserNameController.text) {
        email = list[i].email!;
      }
    }*/
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetOtpBloc>(
            create: (context) =>
                GetOtpBloc()),
        BlocProvider<ForgetPasswordBloc>(
            create: (context) =>
                ForgetPasswordBloc()),
      ],
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: AppColor.background,
          appBar: OfitAppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.light
            ),
            context,
            showDefaultBackButton: false,
            leading: IconButton(
              icon: SvgPicture.asset(
                  IconAsset.icArrowLeft,
                  height: 15,
                  color:AppColor.whiteF2
              ),
              onPressed: () async {
                if(seconds!=0){
                  Navigator.of(context).pushAndRemoveUntil(
                      await LoginPage.route(), (route) => false);
                }else{
                  Navigator.of(context).pop();
                }
              },
              color: Colors.white,
              padding: EdgeInsets.zero,
            ),
            backgroundColor: AppColor.background,
            title: Text(
              S.of(context).forgot_password,
              style: StyleOfit.textStyleFW700(Colors.white, 20),
            ),
          ),
          body: Utils.bkavCheckOrientation(
              context,
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  //color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 50),
                    child: BlocListener<ForgetPasswordBloc,
                        CreatePasswordNewState>(
                      listener: (context, state) async {
                        final formStatus=state.formStatus;
                        if (formStatus is ForgetPasswordSuccess) {
                          // if (!mounted) return;
                          ForgetPasswordSuccess forgetPasswordSuccess =
                              state.formStatus as ForgetPasswordSuccess;
                          Navigator.of(context, rootNavigator: true)
                              .pushAndRemoveUntil<void>(
                              await LoginPage.route(), (route) => false);
                          final snackBar = SnackBar(
                            content: Text(S.of(context).pasword_successful),
                            duration: const Duration(milliseconds: 2000),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          //khi doi thanh cong thi cai dat lai van tay,khuan mat
                          // final prefs = await SharedPreferences.getInstance();
                          // if (await Utils.statusFingerprint()) {
                          //   String uid = prefs.getString(SharedPreferencesKey.userName) ?? "-1";
                          //   prefs.setString(uid.toLowerCase(),
                          //       jsonEncode(SettingSharePref.toJson(false, false)));
                          // }
                          //
                        } else if (formStatus is ForgetPasswordFailed) {
                          ForgetPasswordFailed forgetPasswordFailed =
                              state.formStatus as ForgetPasswordFailed;
                          final snackBar = SnackBar(
                            content: Text(formStatus.stringError),
                            duration: const Duration(milliseconds: 2000),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          // DiaLogManager.displayDialog(
                          //     context,
                          //     "",
                          //     S.of(context).error_resetpasword,
                          //     () {}, () async {
                          //   if (!mounted) return;
                          //   Get.back();
                          // }, S.of(context).agree, "", dialogComplete: true);
                        }
                      },
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _infoUser(context),
                              _OtpField(context),
                              _passwordField(context),
                              _ConfpasswordField(context),
                              const NotePassWord(),
                              _RowButtonchange(context)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }

  Widget _infoUser(BuildContext context) {
    return BlocConsumer<GetOtpBloc, SubmissionOtpState>(
      listener: (context, state) async {
        final formStatus = state.formStatus;
        if (formStatus is ForgetPasswordFailed) {
          setState(() {
            isEnabled = false;
          });
          // DiaLogManager.displayDialog(
          //     context, "", formStatus.stringError, () {
          //   Get.back();
          // }, () {
          //   Get.back();
          // }, S.of(context).cancel, S.of(context).agree);
        }  if (formStatus is ForgetPasswordSuccess) {
          // DiaLogManager.showDialogSendInformationSuccess(context, S.of(context).send_information_success, state.dataHtml,() async { Navigator.of(context).pushAndRemoveUntil<void>(
          // await LoginPage.route(), (route) => false);});
          startTime();
          setState(() {
            //HoangCV tam thoi vut luon otp vao _inputMaxtController
            // _inputOtpController = TextEditingController(text: state.otp);
            isSend = true;
            isEnabled = true;
          });
          Logger.loggerDebug("otp la : ${state.otp} ");
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            BlocBuilder<ForgetPasswordBloc, CreatePasswordNewState>(
              builder: (context, stateF) {
                if (stateF.formStatus is ValidatePassFail) {
                  validatePassFail = stateF.formStatus as ValidatePassFail;
                } else if (stateF.formStatus is ForgetPasswordFailed) {
                  forgetPasswordFailed =
                      stateF.formStatus as ForgetPasswordFailed;
                }
                return TextFormFieldInputAiBook(
                    S.of(context).label_user_name,
                    _inputUserNameController,
                    false,
                   false,
                    _focusUserName,
                   "${S.of(context).label_user_name_empty}!",
                        (lostFocus) {
                      // context.read<ForgetPasswordBloc>().add(ValidatePassNew(
                      //     username: _inputUserNameController.text,
                      //     otp: _inputOtpController.text,
                      //     passNewConfirm: _inputConfPasswordController.text,
                      //     passNew: _inputPasswordController.text,
                      //     context: context));
                      // if (!lostFocus) {
                      //   _focusUserName.requestFocus();
                      // }
                    },
                    false,
                    true,keyboardType: TextInputType.text,);
              },
            ),
            const SizedBox(
              height: 15,
            ),
            !isSend
                ? InkWell(
                    onTap: () {
                      String username = _inputUserNameController.text;
                      // _formKey.currentState!.validate();
                      if (username.isNotEmpty) {
                        context.read<GetOtpBloc>().add(
                            SubmissionOtpEvent(_inputUserNameController.text));
                      }else{
                        _focusUserName.requestFocus();
                      }
                    },
                    child: Text(
                      S.of(context).text_button_send,
                      style: StyleOfit.textStyleFW700(AppColor.main, 14),
                    ))
                : RichText(
                    text: TextSpan(
                    text: S.of(context).text_send_to_email,
                    style: StyleOfit.textStyleFW400(AppColor.black22, 14),
                    children: <TextSpan>[
                      TextSpan(
                        text: email.isNotEmpty
                            ? (email.indexOf("@") % 2 == 0
                                ? email.replaceRange(
                                    email.indexOf("@") ~/ 2,
                                    email.indexOf("@"),
                                    "*" * (email.indexOf("@") ~/ 2))
                                : email.replaceRange(
                                    email.indexOf("@") ~/ 2,
                                    email.indexOf("@"),
                                    "*" * (email.indexOf("@") ~/ 2 + 1)))
                            : "*******@gmail.com",
                        style: StyleOfit.textStyleFW400(AppColor.black22, 14),
                      ),
                      TextSpan(
                        text: S.of(context).text_check_emal,
                        style: StyleOfit.textStyleFW400(AppColor.black22, 14),
                      ),
                      seconds == 0
                          ? TextSpan(
                              text: S.of(context).text_button_send_again,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  String username =
                                      _inputUserNameController.text;
                                  if (username.isNotEmpty) {
                                    context.read<GetOtpBloc>().add(
                                        SubmissionOtpEvent(
                                            _inputUserNameController.text));
                                  }
                                },
                              style:
                                  StyleOfit.textStyleFW700(AppColor.main, 14),
                            )
                          : TextSpan(
                              text:
                                  "${S.of(context).text_button_send_again} (sau ${seconds}s).",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  null;
                                },
                              style:
                                  StyleOfit.textStyleFW700(AppColor.gray70, 14),
                            )
                    ],
                  )),
          ],
        );
      },
    );
  }

  Widget _OtpField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 48),
      child: BlocBuilder<ForgetPasswordBloc, CreatePasswordNewState>(
          builder: (context, state) {
        if (state.formStatus is ValidatePassFail) {
          validatePassFail = state.formStatus as ValidatePassFail;
        } else if (state.formStatus is ForgetPasswordFailed) {
          forgetPasswordFailed = state.formStatus as ForgetPasswordFailed;
        }
        return TextFormFieldInputAiBook(
          S.of(context).text_verification,
          _inputOtpController,
          false,
          false,
          _focusNodeOtp,
           "${S.of(context).text_verification_error}!",
          (lostFocus) {
            // context.read<ForgetPasswordBloc>().add(ValidatePassNew(
            //     username: _inputUserNameController.text,
            //     otp: _inputOtpController.text,
            //     passNewConfirm: _inputConfPasswordController.text,
            //     passNew: _inputPasswordController.text,
            //     context: context));
            // if (!lostFocus) {
            //   _focusNodeOtp.requestFocus();
            // }
          },
          false,
          false,
          isEnable: isEnabled,
        );
      }),
    );
  }

  Widget _passwordField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: BlocBuilder<ForgetPasswordBloc, CreatePasswordNewState>(
          builder: (context, state) {
        if (state.formStatus is ValidatePassFail) {
          validatePassFail = state.formStatus as ValidatePassFail;
        } else if (state.formStatus is ForgetPasswordFailed) {
          forgetPasswordFailed = state.formStatus as ForgetPasswordFailed;
        }
        return Container(
            margin: const EdgeInsets.only(top: 10),
            child: TextFormFieldInputAiBook(
              S.of(context).pass_new,
              _inputPasswordController,
              true,
              (state.formStatus is ValidatePassFail &&
                      validatePassFail?.errorPassNew != "")
                  ? true
                  : false,
              _focusNodePassword,
              (state.formStatus is ValidatePassFail &&
                      validatePassFail?.errorPassNew != "")
                  ? validatePassFail!.errorPassNew
                  : S.of(context).pass_empty,
              (lostFocus) {
                context.read<ForgetPasswordBloc>().add(ValidatePassNew(
                    passNew: _inputPasswordController.text,
                    context: context,
                    username: _inputUserNameController.text,
                    otp: _inputOtpController.text,
                    passNewConfirm: _inputConfPasswordController.text));
                if (!lostFocus) {
                  _focusNodeConfPassword.requestFocus();
                }
              },
              true,
              false,
              isEnable: isEnabled,
            ));
      }),
    );
  }

  Widget _ConfpasswordField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: BlocBuilder<ForgetPasswordBloc, CreatePasswordNewState>(
        builder: (context, state) {
          if (state.formStatus is ValidatePassFail) {
            validatePassFail = state.formStatus as ValidatePassFail;
          } else if (state.formStatus is ForgetPasswordFailed) {
            forgetPasswordFailed = state.formStatus as ForgetPasswordFailed;
          }

          return Container(
              margin: const EdgeInsets.only(top: 10),
              child: TextFormFieldInputAiBook(
                S.of(context).confirm_pass_new,
                _inputConfPasswordController,
                true,
                (state.formStatus is ValidatePassFail &&
                        validatePassFail?.errorPassNewConfirm != "")
                    ? true
                    : false,
                _focusNodeConfPassword,
                (state.formStatus is ValidatePassFail &&
                        validatePassFail?.errorPassNewConfirm != "")
                    ? validatePassFail!.errorPassNewConfirm
                    : S.of(context).pass_empty,
                (lostFocus) {
                  context.read<ForgetPasswordBloc>().add(ValidatePassNew(
                      passNewConfirm: _inputConfPasswordController.text,
                      otp: _inputOtpController.text,
                      username: _inputUserNameController.text,
                      context: context,
                      passNew: _inputPasswordController.text));
                  if (!lostFocus) {
                    FocusScope.of(context).unfocus();
                  }
                },
                true,
                false,
                isEnable: isEnabled,
              ));
        },
      ),
    );
  }

  Widget _RowButtonchange(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 48, bottom: 40),
      child: BlocBuilder<ForgetPasswordBloc, CreatePasswordNewState>(
          builder: (context, state) {
        if (state.formStatus is ValidatePassFail) {
          validatePassFail = state.formStatus as ValidatePassFail;
        } else if (state.formStatus is ForgetPasswordFailed) {
          forgetPasswordFailed = state.formStatus as ForgetPasswordFailed;
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 150,
                child: isEnabled
                    ? OfitButton(
                        text: S.of(context).text_button_save,
                        onPressed: () async {
                          String username = _inputUserNameController.text;
                          String otp = _inputOtpController.text;
                          String passNew = _inputPasswordController.text;
                          String confirmPassNew =
                              _inputConfPasswordController.text;
                            if (username.isNotEmpty) {
                              if(otp.isEmpty){
                                _focusNodeOtp.requestFocus();
                              }
                              else if(validatePassFail?.errorPassNew !=
                                  "" ||
                                  passNew.isEmpty){
                                _focusNodePassword.requestFocus();
                              }
                              else if(validatePassFail?.errorPassNewConfirm !=
                                  "" ||
                                  confirmPassNew.isEmpty){
                                _focusNodeConfPassword.requestFocus();
                            }
                            }
                           else {
                              _focusUserName.requestFocus();
                              requestFocus();
                          }
                          if (forgetPasswordFailed != null &&
                              forgetPasswordFailed?.stringError != "") {
                            _focusNodeOtp.requestFocus();
                          }
                          _formKey.currentState!.validate();
                          if (username.isNotEmpty &&
                              otp.isNotEmpty &&
                              passNew.isNotEmpty &&
                              confirmPassNew.isNotEmpty) {
                            context.read<ForgetPasswordBloc>().add(
                                ValidatePassNew(
                                    username: username,
                                    otp: otp,
                                    passNewConfirm: confirmPassNew,
                                    passNew: passNew,
                                    context: context,
                                    submit: true));
                            requestFocus();
                          }
                        },
                        color: AppColor.main,
                      )
                    : OfitButton(
                        text: S.of(context).text_button_save, onPressed: null)),
          ],
        );
      }),
    );
  }

  void requestFocus() {
    if (validatePassFail != null) {
        if (validatePassFail!.errorPassNew == "" &&
            _inputPasswordController.text.isNotEmpty) {
          if (validatePassFail!.errorPassNewConfirm != "" ||
              _inputConfPasswordController.text.isEmpty) {
            _focusNodeConfPassword.requestFocus();
          }
        }
       else {
          _focusNodePassword.requestFocus();
      }
    } else {
      if (_inputUserNameController.text.isEmpty) {
        _focusUserName.requestFocus();
      } else if (_inputOtpController.text.isEmpty) {
        _focusNodeOtp.requestFocus();
      } else if (_inputPasswordController.text.isEmpty) {
        _focusNodePassword.requestFocus();
      } else if (_inputConfPasswordController.text.isEmpty) {
        _focusNodeConfPassword.requestFocus();
      }
    }
  }
}
