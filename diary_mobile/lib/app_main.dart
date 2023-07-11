import 'package:diary_mobile/data/fake_data/fake_repository_impl.dart';
import 'package:diary_mobile/utils/constants/config_build.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/repository.dart';
import 'data/repository_impl.dart';
import 'generated/l10n.dart';
import 'resource/color.dart';
import 'utils/constants/shared_preferences_key.dart';
import 'utils/logger.dart';
import 'utils/utils.dart';
import 'view/home/home_page.dart';
import 'view/loading_page.dart';
import 'view/login/login_page.dart';
import 'view_model/account/authentication/authentication_bloc.dart';
import 'view_model/account/authentication/authentication_state.dart';
import 'view_model/navigation_service.dart';
//
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
// }


Future<void> initBkav() async{
  WidgetsFlutterBinding.ensureInitialized();
/*  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseMessaging.instance.getInitialMessage();*/
  // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  // makes Smartphone Statusbar transparent
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      ));

//
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//   FirebaseMessaging.instance.getInitialMessage();
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//   messaging.requestPermission(
//     alert: true,
//     announcement: false,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true,
//   );
//
//   if (Platform.isIOS) {
//     messaging.setForegroundNotificationPresentationOptions(
//       alert: true, // Required to display a heads up notification
//       badge: true,
//       sound: true,
//     );
//   }
//   if (Platform.isAndroid) {
//     AndroidNotificationChannel channel = const AndroidNotificationChannel(
//       'high_importance_channel', // id
//       'Thông báo Đại lý', // title
//       importance: Importance.max,
//     );
//     final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
//
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//   }
//
  final prefs = await SharedPreferences.getInstance();
//   String? uuidSave = prefs.getString(SharedPreferencesKey.keyUUID);
//   Logger.loggerDebug("Bkav DucLQ uuid $uuidSave");
//
//   if (uuidSave == null || uuidSave.isEmpty) {
//     var uuid = const Uuid(options: {'dai_ly_bkav': UuidUtil.cryptoRNG});
//     uuidSave = uuid.v4();
//     prefs.setString(SharedPreferencesKey.keyUUID, uuidSave);
//   }
//
/*  messaging.getToken().then((tokenFirebase) {
    if (tokenFirebase != null && tokenFirebase.isNotEmpty) {
      prefs.setString(SharedPreferencesKey.tokenFirebase, tokenFirebase);
      Logger.loggerDebug("Bkav DucLQ Token firebase cua app la $tokenFirebase");
    }
  });
  messaging.onTokenRefresh.listen((newToken) {
    if (newToken.isNotEmpty) {
      prefs.setString(SharedPreferencesKey.tokenFirebase, newToken);
      Logger.loggerDebug("Bkav DucLQ Token firebase cua app la $newToken");
    }
  });*/
//
}


class MyApp extends StatefulWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Repository repository;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    repository = ConfigBuild.isFakeUserRepo ? FakeRepositoryImpl() : RepositoryImpl(context: context);
    // Tạm thời tắt chế độ xoay ngang màn hình
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return RepositoryProvider.value(
      value: repository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(repository: repository),
        child: _AIBookView(),
      ),
    );/*BlocProvider<AuthenticationBloc>(
        create: (context) => AuthenticationBloc(),
    child: _AIBookView());*//*RepositoryProvider(
      create: (_)=>  BlocProvider(
        create: (_) => AuthenticationBloc(),
        child: _AIBookView(),
      ),
    );*/
  }
}

class _AIBookView extends StatefulWidget {
  @override
  State<_AIBookView> createState() => _AIBookState();
}

class _AIBookState extends State<_AIBookView> {
  final _navigatorKey = NavigationService.navigatorKey;
  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  void initState() {
    // context.read<Repository>().updateTokenFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        navigatorKey: _navigatorKey,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: ThemeData(
            primaryColor: AppColor.main,
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: AppColor.main
            )
        ),
        supportedLocales: S.delegate.supportedLocales,
        builder: (context, child) {
          return BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) async {
                SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
                String token = sharedPreferences.getString(SharedPreferencesKey.accessToken) ?? "";
                bool isKeepLogin= sharedPreferences.getBool(SharedPreferencesKey.isRemember)?? true;
                switch (state.status) {
                  case AuthenticationStatus.authenticated:
                    _navigator.pushAndRemoveUntil<void>(
                        await LoginPage.route(), (route) => false);
                    break;
                  case AuthenticationStatus.unauthenticated:
                    if(token.isNotEmpty && isKeepLogin && await Utils.checkInternetConnection()== false){
                      _navigator.pushAndRemoveUntil<void>(
                          await HomePage.route(), (route) => false);
                    }else {
                      _navigator.pushAndRemoveUntil(
                          await LoginPage.route(), (route) => false);
                    }
                    break;
                  default:
                    break;
                }
              },
              child: child);
        },
        onGenerateRoute: (_) => LoadingPage.route()
    );
  }
}
