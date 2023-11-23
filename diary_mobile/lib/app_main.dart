import 'dart:io';

import 'package:diary_mobile/data/fake_data/fake_repository_impl.dart';
import 'package:diary_mobile/utils/constants/config_build.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/entity/notify/notify_push.dart';
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
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  Logger.loggerDebug(
      "HoangCV _firebaseMessagingBackgroundHandler ${message.toMap().toString()}");
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyBwFt-QSqCNM2aM74VR-IX500HGBSi8HjE',
            appId: '1:321357439192:android:dbaffd1bdbbb522f2177ad',
            messagingSenderId: '321357439192',
            projectId: 'ofitone-c9783')
    );
  Utils.handle(message, true);
}

Future<void> initOfit() async{

  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();
              await Firebase.initializeApp(
                options: const FirebaseOptions(
                    apiKey: 'AIzaSyBwFt-QSqCNM2aM74VR-IX500HGBSi8HjE',
                    appId: '1:321357439192:android:dbaffd1bdbbb522f2177ad',
                    messagingSenderId: '321357439192',
                    projectId: 'ofitone-c9783')
              );
  final prefspre = await SharedPreferences.getInstance();
  int userId =
      prefspre.getInt(SharedPreferencesKey.userId) ?? -1;
  await FirebaseMessaging.instance.subscribeToTopic("${userId}");
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseMessaging.instance.getInitialMessage();
  SystemChrome.setEnabledSystemUIMode( SystemUiMode.manual,overlays: [SystemUiOverlay.top]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      ));

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    Logger.loggerDebug("HoangCV onMessageOpenedApp.listen $message");
    Utils.handle(message, false);
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    Logger.loggerDebug(
        "Bkav onMessage.listen ${message.toMap().toString()}");
    Utils.handle(message, false);
  });
  messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (Platform.isIOS) {
    messaging.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }
  if (Platform.isAndroid) {
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'Thông báo OfitOne', // title
      importance: Importance.max,
    );
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  final prefs = await SharedPreferences.getInstance();
  String? uuidSave = prefs.getString(SharedPreferencesKey.keyUUID);
  Logger.loggerDebug("Bkav DucLQ uuid $uuidSave");

/*  if (uuidSave == null || uuidSave.isEmpty) {
    var uuid = const Uuid(options: {'dai_ly_bkav': UuidUtil.cryptoRNG});
    uuidSave = uuid.v4();
    prefs.setString(SharedPreferencesKey.keyUUID, uuidSave);
  }*/

  messaging.getToken().then((tokenFirebase) {
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
  });
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
                String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
                bool isKeepLogin= sharedPreferences.getBool(SharedPreferencesKey.isRemember) ?? true;
                print("HoangCV: check login : ${token}");
                switch (state.status) {
                  case AuthenticationStatus.authenticated:
                    _navigator.pushAndRemoveUntil<void>(
                        await HomePage.route(), (route) => false);
                    break;
                    //case mất mạng
                  case AuthenticationStatus.unauthenticated:
                    if(token.isNotEmpty && await Utils.checkInternetConnection()== false){
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
