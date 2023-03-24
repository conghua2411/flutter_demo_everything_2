import 'package:dartz/dartz.dart' as Dartz;
import 'package:flutter/material.dart';
import 'package:flutter_demo_everything_2/dartz_demo/dartz_logic.dart';

class DartzDemoInfo extends StatefulWidget {
  const DartzDemoInfo({Key? key}) : super(key: key);

  @override
  State<DartzDemoInfo> createState() => _DartzDemoInfoState();
}

class _DartzDemoInfoState extends State<DartzDemoInfo> {
  late DartzLogic logic;

  @override
  void initState() {
    super.initState();

    logic = DartzLogic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dartz Demo'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<Dartz.Either<Exception, String>>(
                initialData: Dartz.right(''),
                future: logic.getUserName(),
                builder: (context, snapshot) {
                  return userInfoWidget(
                      title: 'Username', value: snapshot.data!);
                }),
            FutureBuilder<Dartz.Either<Exception, String>>(
                initialData: Dartz.right(''),
                future: logic.getPhoneNumber(),
                builder: (context, snapshot) {
                  return userInfoWidget(
                      title: 'Phone number', value: snapshot.data!);
                }),
          ],
        ),
      ),
    );
  }

  Widget userInfoWidget({
    required String title,
    required Dartz.Either<Exception, String> value,
  }) {
    String? strValue;
    String? strError;

    value.fold((l) => strError = '$l', (r) => strValue = r);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$title:'),
          Flexible(
            child: strError != null
                ? Text(
                    'Error: $strError',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  )
                : Text('$strValue'),
          ),
        ],
      ),
    );
  }
}
