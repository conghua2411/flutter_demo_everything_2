import 'package:flutter/material.dart';
import 'package:flutter_demo_everything_2/demo_info.dart';
import 'package:flutter_demo_everything_2/demos.dart';
import 'package:flutter_demo_everything_2/main.dart';
import 'package:go_router/go_router.dart';

extension ConvertDemoInfoToGoRoute on DemoInfo {
  GoRoute toGoRoute() {
    return GoRoute(
      path: name,
      builder: (ctx, state) {
        return demo ?? Container();
      },
      routes: (subDemo?.isNotEmpty ?? false)
          ? subDemo!
              .map(
                (demo) => demo.toGoRoute(),
              )
              .toList()
          : [],
    );
  }
}

class GoRouterDemo {
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return Main();
        },
        routes: demos
            .map(
              (demo) => demo.toGoRoute(),
            )
            .toList(),
      ),
    ],
  );

  RouteInformationProvider get routeInformationProvider =>
      _router.routeInformationProvider;

  RouteInformationParser<Object> get routeInformationParser =>
      _router.routeInformationParser;

  RouterDelegate<Object> get routerDelegate => _router.routerDelegate;
}
