import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/core/constants/constants.dart';
import 'package:ecommerce/core/services/bloc_observer.dart';
import 'package:ecommerce/core/utils/setup-deep_link_listener.dart';
import 'package:ecommerce/cubits/auth_cubit/auth_cubit.dart';
import 'package:ecommerce/cubits/deep_linke_cubit/deep_link.dart';
import 'package:ecommerce/cubits/favorite_cubit/favorite_cubit.dart';
import 'package:ecommerce/cubits/main_cubit/main_cubit.dart';
import 'package:ecommerce/cubits/search_cubit/search_cubit.dart';
import 'package:ecommerce/cubits/user_cubit/user_cubit.dart';
import 'package:ecommerce/entry_point.dart';
import 'package:ecommerce/features/auth/LoginScreen.dart';
import 'package:ecommerce/features/product/views/product_details_screen.dart';
import 'package:ecommerce/te.dart';
import 'package:ecommerce/theme/app_theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/services/cache_helper.dart';
import 'core/services/dio_api.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    logDartError(details.exception, details.stack!);
    logFlutterError(details);
  };


  DioHelper.init(baseUrl: 'http://191.101.81.32:8269');
  await EasyLocalization.ensureInitialized();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  token = await CacheHelper.getData(key: 'token',) ;
  refreshToken = await CacheHelper.getData(key: 'refresh_token',);
  print('refresh: $refreshToken');
  Widget screen;
  if(refreshToken != null) {
    screen = const EntryPoint();
  } else {
    screen = LoginScreen();
  }
  print('token: $token');
  final deepLinkCubit = DeepLinkCubit();
  setupDeepLinkListener(deepLinkCubit);

  runApp(
      EasyLocalization(
        supportedLocales: const [ Locale('ar') , Locale('en')],
        path: 'assets/translations',
        startLocale: const Locale('en'),
        child: Phoenix(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => deepLinkCubit),
              BlocProvider(create: (context) => AuthCubit()),
              BlocProvider(create: (context) => FavoriteCubit(),),
              BlocProvider(create: (context) => MainCubit()..getCategories()..getPriceList()..getProducts(context: context),),
              BlocProvider(create: (context) => SearchCubit(),),
              BlocProvider(create: (context) => UserCubit()..getUserData(context: context),),

            ],
              child: MyApp(screen: screen,)
          ),
        ),
      )
  );
}

void logFlutterError(FlutterErrorDetails details) {
  print('Flutter Error: ${details.exception}');
  print('Stack trace: ${details.stack}');
}

void logDartError(Object error, StackTrace stackTrace) {
  print('Dart Error: $error');
  print('Stack trace: $stackTrace');
}


class MyApp extends StatelessWidget {
   Widget screen;
   MyApp({super.key, required this.screen});

  @override
  Widget build(BuildContext context) {
    refreshToken == null ? screen = LoginScreen() : screen = const EntryPoint();
    return BlocListener<DeepLinkCubit, DeepLinkState>(
  listener: (context, state) {
    if (state.productId != null) {
      MainCubit.get(context).getProductDetails(id:  int.parse(state.productId ?? '0'));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProductDetailsScreen(),
        ),
      );
    }
  },
  child: ScreenUtilInit(
      designSize: const Size(360, 820),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) =>
          MaterialApp(
            debugShowCheckedModeBanner: false,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            locale: context.locale,
            theme: AppTheme.lightTheme(context),
            home: screen,
            themeMode: ThemeMode.light,
          ),
    ),
);
  }
}
