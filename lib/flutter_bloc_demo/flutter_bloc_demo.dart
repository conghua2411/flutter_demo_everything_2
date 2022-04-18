import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo_everything_2/flutter_bloc_demo/bloc/counter_cubit.dart';
import 'package:flutter_demo_everything_2/flutter_bloc_demo/bloc/time_cubit.dart';

class FlutterBlocDemo extends StatefulWidget {
  const FlutterBlocDemo({Key? key}) : super(key: key);

  @override
  State<FlutterBlocDemo> createState() => _FlutterBlocDemoState();
}

class _FlutterBlocDemoState extends State<FlutterBlocDemo> {
  late CounterCubit counterCubit;

  late TimeCubit timeCubit;

  @override
  void initState() {
    super.initState();

    counterCubit = CounterCubit();

    timeCubit = TimeCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Bloc Demo'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                BlocBuilder(
                  bloc: counterCubit,
                  builder: (ctx, state) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('$state'),
                    );
                  },
                ),
                BlocProvider(
                  create: (_) => timeCubit,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TimeEvenWidget(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          counterCubit.increase();
          timeCubit.updateTime();
        },
      ),
    );
  }
}

class TimeEvenWidget extends StatelessWidget {
  const TimeEvenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'only show even second',
        ),
        BlocSelector<TimeCubit, DateTime, DateTime?>(
          selector: (state) {
            if (state.second & 1 == 0) {
              return state;
            }
            return null;
          },
          builder: (ctx, state) {
            return Text(
              '${state != null ? state.second : 'not an even second time'}',
            );
          },
        ),
      ],
    );
  }
}
