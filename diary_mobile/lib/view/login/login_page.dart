import 'dart:async';

import 'package:diary_mobile/data/entity/diary/diary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repository.dart';
import '../../generated/l10n.dart';
import '../../resource/assets.dart';
import '../../resource/color.dart';
import '../../resource/style.dart';
import '../../utils/constans/api_const.dart';
import '../../utils/constants/shared_preferences_key.dart';
import '../../utils/form_submission_status.dart';
import '../../utils/logger.dart';
import '../../utils/utils.dart';
import '../../utils/widgets/button_widget.dart';
import '../../utils/widgets/text_form_input_ai_book.dart';
import '../../view_model/account/login_bloc.dart';
import '../diary_activity/activity/add_activity.dart';
import '../forget_password/forget_password_page.dart';
import '../home/home_page.dart';
import '../setting/contact/contact_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage(
      {Key? key,
      this.versionApp = "",
      required this.isRemember,
      required this.userName,
      required this.isFaceId,
      required this.isFingerprint})
      : super(key: key);
  final String versionApp;
  bool isRemember;
  final String userName;
  final bool isFaceId;
  bool isFingerprint;

  static Future<Route> route({String version = ""}) async {
    //String version = await Utils.getVersionApp();
    final prefs = await SharedPreferences.getInstance();
    // Logger.loggerDebug(
    //     " userName = ${prefs.getString(SharedPreferencesKey.userName).toString()}");
    // Logger.loggerDebug(
    //     " accessToken = ${prefs.getString(SharedPreferencesKey.accessToken).toString()}");
    bool? remembersave = prefs.getBool(SharedPreferencesKey.isRemember);
    bool isRemember = ApiConst.isRememberDefault;
    String userName = prefs.getString(SharedPreferencesKey.userName) ?? "";
    bool statusFaceID = await Utils.statusFaceID();
    bool statusFingerprint = await Utils.statusFingerprint();
    // Logger.loggerDebug(
    //     " statusFingerprint = ${statusFingerprint.toString()}");
    // Logger.loggerDebug(
    //     " statusFaceID = ${statusFaceID.toString()}");
    if (remembersave == null) {
      prefs.setBool(
          SharedPreferencesKey.isRemember, ApiConst.isRememberDefault);
    } else {
      isRemember = remembersave;
    }

    return MaterialPageRoute(
        builder: (_) => LoginPage(
              versionApp: version,
              isRemember: isRemember,
              userName: userName,
              isFingerprint: statusFingerprint,
              isFaceId: statusFaceID,
            ));
  }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  bool loginGoogle = false;
  String account = "";
  TextEditingController _inputUsernameController = TextEditingController();
  final TextEditingController _inputPasswordController =
      TextEditingController();

  final FocusNode _focusNodeName = FocusNode();

  final FocusNode _focusNodePassword = FocusNode();

  //late ai_book.AiBookDb _db;
  bool isRemember = ApiConst.isRememberDefault;

  // DatNVh login with Google

  @override
  void initState() {
    super.initState();
    isRemember = widget.isRemember;
    // _db=ai_book.AiBookDb.instance;
    // getListUser();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    WidgetsBinding.instance.addObserver(this);
  }

  // Future<List<UserEntity>> getListUser() async {
  //   List<UserEntity> list = await _db.getlistUser();
  //   if(list.length==1){
  //     _inputUsernameController=TextEditingController(text: widget.userName);
  //   }
  //   return list;
  // }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: AppColor.background,
          resizeToAvoidBottomInset: false,
          body: Utils.bkavCheckOrientation(
            context,
            Container(
              decoration: const BoxDecoration(
            image: DecorationImage(
              opacity: 1,
                image: AssetImage(
                    ImageAsset.imageOfitSoftBackground),
                fit: BoxFit.cover),
                ),
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: MultiBlocProvider(
                      providers: [
/*                      BlocProvider<SettingBloc>(
                            create: (context) => SettingBloc(context,
                                repository: context.read<Repository>(),
                                showFace: widget.isFaceId,
                                showFigure: widget.isFingerprint)),*/
                        BlocProvider<LoginBloc>(
                            create: (context) => LoginBloc(
                                context,
                                widget.isFaceId,
                                widget.isFingerprint,
                                _inputUsernameController.text,
                                context.read<Repository>())),
                      ],
                      child: _loginForm(context),
                      //),
                    ),
                  )),
            ),
          ),
        ));
  }

  Widget _loginForm(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) async {
          final formStatus = state.formStatus;
          if (formStatus is SubmissionFailed) {
            final prefs = await SharedPreferences.getInstance();
            prefs.remove(SharedPreferencesKey.socialAccessToken);
            prefs.remove(SharedPreferencesKey.socialID);
            // GoogleSignIn googleSignIn = GoogleSignIn();
            // await googleSignIn.signOut();
            // await FirebaseAuth.instance.signOut();
          } else if (formStatus is SubmissionSuccess) {
            Logger.loggerDebug(
                "state.isChangePassWordFirstTime ${state.isChangePassWordFirstTime}");
            // if(!state.isChangePassWordFirstTime){
            //   Navigator.of(context).pushAndRemoveUntil<void>(
            //       ChangePassWordPage.route(true,state.password), (route) => false);
            // }else {
            // Navigator.of(context).pushAndRemoveUntil<void>(
            //      await HomePage.route(), (route) => false);
            Navigator.of(context).pushAndRemoveUntil<void>(
                /*await PaymentListPage.route(0), (route) => false);*/
                await HomePage.route(),
                (route) => false);
/*                ListBillPage.route(), (route) => false);*/
            /*      await PaymentListPage.route(0), (route) => false);*/
            //await HomePage.route(), (route) => false);
            // }
          } else if (formStatus is FormSubmitting) {
            //_showLoaderDialog(context);
          }
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.only(top: 105),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _logoWidgetLogin(context),
                        _usernameField(context),
                        _passwordField(),
                        //_rowRememberPass(),
                        SizedBox(
                          height: 40,
                        ),
                        _rowButton(),
                        //_rowRegisterAccount(),
                        _rowHotline(context),
                        //_loginWithGoogle()
                      ],
                    ),
                    //_fabButton(),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget _logoWidgetLogin(BuildContext context) {
    return const Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          Image(image: AssetImage(ImageAsset.imageOfitsoftText), height: 150,),
          SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }

  //thong bao loi dang nhap
  Widget _notifiLoginError() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      final formStatus = state.formStatus;
      if (formStatus is SubmissionFailed) {
        String errorLogin = formStatus.exception.toString();
        return Container(
          height: 15,
          alignment: Alignment.topCenter,
          child: Text(
            errorLogin,
            style: StyleOfit.textStyleFW700(AppColor.redE1, 14),
          ),
        );
      }
      return const SizedBox(
        height: 15,
      );
    });
  }

  Widget _usernameField(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      //DatNVh autofill username neu nguoi dung da login truoc do
      if (state.username.isNotEmpty) {
        _inputUsernameController = TextEditingController(
            text: _inputUsernameController.text.isNotEmpty
                ? _inputUsernameController.text
                : state.username);
      }
      return Focus(
        child: Container(
            margin: const EdgeInsets.only(top: 48),
            child: TextFormFieldInputAiBook(
              S.of(context).label_user_name,
              _inputUsernameController,
              false,
              false,
              _focusNodeName,
              "${S.of(context).error_input_empty}${S.of(context).label_user_name.toLowerCase()}!",
              (lostFocus) {},
              false,
              false,
              keyboardType: TextInputType.text,
            )),
        onFocusChange: (hasFocus) {
          if (hasFocus) {
            context.read<LoginBloc>().add(EventFocusTextField());
          }
        },
      );
    });
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      // if(state.username.isNotEmpty) {
      //   _inputPasswordController = TextEditingController(
      //       text: state.isRememberLogin ? state.password : "");
      // }
      return Focus(
        child: Container(
            margin: const EdgeInsets.only(top: 20),
            child: TextFormFieldInputAiBook(
                S.of(context).label_password,
                _inputPasswordController,
                true,
                false,
                _focusNodePassword,
                "${S.of(context).error_input_empty}${S.of(context).label_password.toLowerCase()}!",
                (lostFocus) {},
                false,
                false)),
        onFocusChange: (hasFocus) {
          if (hasFocus) {
            context.read<LoginBloc>().add(EventFocusTextField());
          }
        },
      );
    });
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return (state.formStatus is FormSubmitting)
          ? SizedBox(
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                        primary: AppColor.main,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32)))
                    .copyWith(
                  elevation: MaterialStateProperty.resolveWith(
                    (states) {
                      return 0;
                    },
                  ),
                ),
                onPressed: () {},
                child: const Center(
                  child: SizedBox(
                    height: 15.0,
                    width: 15.0,
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ),
              ),
            )
          : OfitButton(
              text: S.of(context).button_login,
              onPressed: () {
                //auto focus vao truong du lieu trong tu tren xuong duoi
                if (_inputUsernameController.text.isEmpty) {
                  _focusNodeName.requestFocus();
                } else {
                  if (_inputPasswordController.text.isEmpty) {
                    _focusNodePassword.requestFocus();
                  }
                }
                _formKey.currentState!.validate();
                if (_inputUsernameController.text.isNotEmpty &&
                    _inputPasswordController.text.isNotEmpty) {
                  context.read<LoginBloc>().add(LoginSubmitted(
                        _inputUsernameController.text,
                        _inputPasswordController.text,
                        false,
                      ));
                }
              },
              color: AppColor.main,
            );
    });
  }

  Widget _rowHotline(BuildContext context) {
    return InkWell(
      onTap: () {
        //Navigator.push(context, ContactPage.route());
        Utils.launchPhoneUrl('0989426911');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        margin: const EdgeInsets.only(top: 35, bottom: 15),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ], color: Colors.white.withOpacity(0.9), borderRadius: BorderRadius.circular(22)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              IconAsset.icContact,
            ),
            const SizedBox(
              width: 6,
            ),
            Flexible(
              child: Text("Hỗ trợ",
                  style: StyleOfit.textStyleFW700(AppColor.yellowFF, 16,
                      overflow: TextOverflow.visible)),
            )
          ],
        ),
      ),
    );
  }

  Widget _rowRegisterAccount() {
    return Container(
      height: 18,
      margin: const EdgeInsets.only(top: 15, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Chưa có tài khoản? ",
              style: TextStyle(color: AppColor.black22, fontSize: 16)),
          InkWell(
            onTap: () {
              /*           Navigator.pushNamed(context, DangKyMoiScreen.routeName);*/
            },
            child: Text(
              "Đăng ký ngay",
              style: TextStyle(
                  color: AppColor.yellowFF,
                  fontSize: 16,
                  decoration: TextDecoration.underline),
            ),
          ),
        ],
      ),
    );
  }

  Widget _rowButton() {
    return _loginButton();
  }

  Widget _rowRememberPass() {
    return Container(
        height: 18,
        margin: const EdgeInsets.only(top: 15, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: TextButton(
                //diem diem giao dien
                style: TextButton.styleFrom(
                  primary: AppColor.blueE8,
                  padding: EdgeInsets.zero,
                  backgroundColor: AppColor.whiteF2.withOpacity(0.5),
                ),
                onPressed: () async {
                  Navigator.push(
                      context,
                      await ForgetPasswordPage.route(
                          _inputUsernameController.text));
                },
                child: Text(S.of(context).forgot_password + " ?",
                    style: StyleOfit.textStyleFW600(AppColor.back09, 14,
                        overflow: TextOverflow.visible)),
              ),
            ),
          ],
        ));
  }


  Widget containerLine({bool? isMargin}) {
    return Container(
      width: double.infinity,
      height: 1,
      color: AppColor.gray300,
      margin: const EdgeInsets.symmetric(horizontal: 5),
    );
  }
}
