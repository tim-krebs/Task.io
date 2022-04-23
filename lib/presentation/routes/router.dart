import 'package:auto_route/auto_route.dart';
import 'package:taskio/presentation/home/home_page.dart';
import 'package:taskio/presentation/signup/signup_page.dart';
import 'package:taskio/presentation/splash/splash_page.dart';
import 'package:taskio/presentation/todo_detail/todo_detail_page.dart';
import 'package:taskio/presentation/register/register_page.dart';

@MaterialAutoRouter(
  // Add new Routes: flutter packages pub run build_runner build
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: SignUpPage, initial: false),
    AutoRoute(page: HomePage, initial: false),
    CustomRoute(
        page: TodoDetail,
        initial: false,
        transitionsBuilder: TransitionsBuilders.slideBottom,
        durationInMilliseconds: 300),
    CustomRoute(
        page: RegisterPage,
        initial: false,
        transitionsBuilder: TransitionsBuilders.slideRight),
  ],
)
class $AppRouter {}
