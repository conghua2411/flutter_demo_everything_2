import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_demo_everything_2/flutter_bloc_demo/bloc/counter_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Counter cubit unit test', () {
    blocTest<CounterCubit, int>(
      'emits [0] when create',
      build: () => CounterCubit(),
      expect: () => [],
    );

    blocTest<CounterCubit, int>(
      'emits [0,1] when increase one',
      build: () => CounterCubit(),
      act: (cubit) => cubit.increase(),
      expect: () => [
        1,
      ],
    );

    blocTest<CounterCubit, int>(
      'emits [0,1] when increase one',
      build: () => CounterCubit(),
      act: (cubit) => cubit.decrease(),
      expect: () => [
        -1,
      ],
    );
  });
}
