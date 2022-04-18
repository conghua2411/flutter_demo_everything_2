import 'package:dartz/dartz.dart';

class DartzLogic {
  Future<Either<Exception, String>> getUserName() {
    return Future.delayed(Duration(seconds: 1), () => Right('HalaHolaAmingo'));
  }

  Future<Either<Exception, String>> getPhoneNumber() {
    return Future.delayed(Duration(seconds: 3), () => Left(Exception('cannot get phone number')));
  }
}