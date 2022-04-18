import 'package:flutter_bloc/flutter_bloc.dart';

class TimeCubit extends Cubit<DateTime> {
  TimeCubit() : super(DateTime.now());

  void updateTime() => emit(DateTime.now());
}