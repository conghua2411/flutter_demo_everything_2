import 'package:flutter/material.dart';

extension NavigatorExtension on BuildContext {
  Future<R?> push<R>(Widget widget) {
    return Navigator.of(this).push<R>(
      MaterialPageRoute(
        builder: (_) => widget,
      ),
    );
  }
}
