// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../../domain/entities/todo.dart' as _i8;
import '../home/home_page.dart' as _i3;
import '../register/register_page.dart' as _i5;
import '../signup/signup_page.dart' as _i2;
import '../splash/splash_page.dart' as _i1;
import '../todo_detail/todo_detail_page.dart' as _i4;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    SplashPageRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.SplashPage());
    },
    SignUpPageRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.SignUpPage());
    },
    HomePageRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.HomePage());
    },
    TodoDetailRoute.name: (routeData) {
      final args = routeData.argsAs<TodoDetailRouteArgs>();
      return _i6.CustomPage<dynamic>(
          routeData: routeData,
          child: _i4.TodoDetail(key: args.key, todo: args.todo),
          transitionsBuilder: _i6.TransitionsBuilders.slideBottom,
          durationInMilliseconds: 300,
          opaque: true,
          barrierDismissible: false);
    },
    RegisterPageRoute.name: (routeData) {
      return _i6.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i5.RegisterPage(),
          transitionsBuilder: _i6.TransitionsBuilders.slideRight,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(SplashPageRoute.name, path: '/'),
        _i6.RouteConfig(SignUpPageRoute.name, path: '/sign-up-page'),
        _i6.RouteConfig(HomePageRoute.name, path: '/home-page'),
        _i6.RouteConfig(TodoDetailRoute.name, path: '/todo-detail'),
        _i6.RouteConfig(RegisterPageRoute.name, path: '/register-page')
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashPageRoute extends _i6.PageRouteInfo<void> {
  const SplashPageRoute() : super(SplashPageRoute.name, path: '/');

  static const String name = 'SplashPageRoute';
}

/// generated route for
/// [_i2.SignUpPage]
class SignUpPageRoute extends _i6.PageRouteInfo<void> {
  const SignUpPageRoute() : super(SignUpPageRoute.name, path: '/sign-up-page');

  static const String name = 'SignUpPageRoute';
}

/// generated route for
/// [_i3.HomePage]
class HomePageRoute extends _i6.PageRouteInfo<void> {
  const HomePageRoute() : super(HomePageRoute.name, path: '/home-page');

  static const String name = 'HomePageRoute';
}

/// generated route for
/// [_i4.TodoDetail]
class TodoDetailRoute extends _i6.PageRouteInfo<TodoDetailRouteArgs> {
  TodoDetailRoute({_i7.Key? key, required _i8.Todo? todo})
      : super(TodoDetailRoute.name,
            path: '/todo-detail',
            args: TodoDetailRouteArgs(key: key, todo: todo));

  static const String name = 'TodoDetailRoute';
}

class TodoDetailRouteArgs {
  const TodoDetailRouteArgs({this.key, required this.todo});

  final _i7.Key? key;

  final _i8.Todo? todo;

  @override
  String toString() {
    return 'TodoDetailRouteArgs{key: $key, todo: $todo}';
  }
}

/// generated route for
/// [_i5.RegisterPage]
class RegisterPageRoute extends _i6.PageRouteInfo<void> {
  const RegisterPageRoute()
      : super(RegisterPageRoute.name, path: '/register-page');

  static const String name = 'RegisterPageRoute';
}
