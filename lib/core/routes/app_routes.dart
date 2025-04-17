
import 'package:go_router/go_router.dart';
import 'package:logiology/core/constants/app_route_paths.dart';
import 'package:logiology/features/auth/presentation/pages/log_in_page.dart';
import 'package:logiology/features/home/data/local_data_source/user_info_data_source.dart';
import 'package:logiology/features/home/presentation/pages/home_page.dart';

class AppRoutes {
  static GoRouter routes = GoRouter(
    initialLocation: '/',
    routes: [
    
      GoRoute(
          path: AppRoutePaths.homePage,
          builder: (context, state) => HomePage()),

          GoRoute(
          path: '/',
          builder: (context, state) => 
          !UserInfo.loginStatus? LogInPage():HomePage()),
    
    ],
  );
}
