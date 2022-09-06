import 'package:flutter/material.dart';
import 'package:flutter_demo_everything_2/demo_info.dart';
import 'package:flutter_demo_everything_2/demos.dart';
import 'package:go_router/go_router.dart';

import 'go_router_demo/routers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GoRouterDemo _router = GoRouterDemo();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo Everything 2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  late List<DemoInfo> listDemo;

  @override
  void initState() {
    super.initState();
    listDemo = demos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: listDemo
              .map(
                (demo) => _demoButton(demo),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _demoButton(DemoInfo demo) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            context.go('/${demo.name}');

            /// go router, can open stack route
            // context.go('/AnimationInfo/CircleClose');
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.lightBlueAccent,
                width: 2,
              ),
            ),
            padding: const EdgeInsets.all(8),
            child: Text(
              demo.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
