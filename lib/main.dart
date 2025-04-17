import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:logiology/core/di/sevice_locator.dart';
import 'package:logiology/core/routes/app_routes.dart';
import 'package:logiology/core/theme/app_colors.dart';
import 'package:logiology/core/theme/app_theme.dart';
import 'package:logiology/features/auth/data/data_source/user_log_in_info_local_data_source.dart';
import 'package:logiology/features/product/presentation/controllers/product_controllers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await setUpServiceLocator();
  Get.put(ProductController(getIt(),getIt(),getIt()));

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.transparentColor,
  ));

  getIt<UserLogInInfoLocalDataSource>().getUserData();
 

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(milliseconds: 700), () {
      FlutterNativeSplash.remove();
    });

    return MaterialApp.router(
      routerConfig: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
      title: 'Logiology',
      theme: AppTheme.darkThememode,
      themeMode: ThemeMode.dark,
    );
  }
}
