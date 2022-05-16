import 'package:flutter/material.dart';
import 'package:flutter_demo_everything_2/helper/extension/navigator_extension.dart';

class ScreenLifeCycleDemo extends StatefulWidget {
  const ScreenLifeCycleDemo({Key? key}) : super(key: key);

  @override
  State<ScreenLifeCycleDemo> createState() => _ScreenLifeCycleDemoState();
}

class _ScreenLifeCycleDemoState extends State<ScreenLifeCycleDemo>
    with WidgetsBindingObserver {
  int _counter = 0;

  String appLifeCycle = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      appLifeCycle += '$state\n';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ScreenLifeCycleDemo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'BackTime: ${_counter}',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            TextButton(
              child: Text('Next Page'),
              onPressed: _gotoNextPage,
            ),
            Expanded(
              child: Text(
                '$appLifeCycle',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _gotoNextPage() {
    context.push(NextPage()).then(
      (value) {
        /// update your screen here
        ///
        setState(() {
          _counter++;
        });
      },
    );
  }
}

class NextPage extends StatefulWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: Center(
        child: Text('This is Next Page'),
      ),
    );
  }
}
