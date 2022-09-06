import 'package:flutter/material.dart';

class DemoInfo {
  String name;
  Widget? demo;
  List<DemoInfo>? subDemo;

  DemoInfo({
    this.name = '',
    this.demo,
    this.subDemo,
  });
}
