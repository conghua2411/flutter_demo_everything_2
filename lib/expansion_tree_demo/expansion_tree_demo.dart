import 'package:flutter/material.dart';

class ExpansionTreeDemo extends StatefulWidget {
  @override
  _ExpansionTreeDemoState createState() => _ExpansionTreeDemoState();
}

class _ExpansionTreeDemoState extends State<ExpansionTreeDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ExpansionPanelList(
              animationDuration: Duration(milliseconds:1000),
              dividerColor:Colors.red,
              elevation:1,
              children: [
                ExpansionPanel(
                  headerBuilder: (ctx, isOpen) {
                    return Text('header');
                  },
                  body: Text('body'),
                  isExpanded: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
