import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_demo_everything_2/flutter_bloc_demo/bloc/time_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Time cubit test', () {
    blocTest(
      'emits [] when nothing is added',
      build: () => TimeCubit(),
      expect: () => [],
    );

    blocTest<TimeCubit, DateTime>(
      'emits [DateTime.now()] when call updateTime is added',
      build: () => TimeCubit(),
      act: (cubit) => cubit.updateTime(),
      verify: (cubit) => [
        cubit.updateTime,
      ],
    );
  });
}
