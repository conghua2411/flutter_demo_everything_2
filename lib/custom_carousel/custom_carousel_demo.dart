import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_demo_everything_2/custom_carousel/perspective_pageview.dart';

class CustomCarouselDemo extends StatefulWidget {
  @override
  _CustomCarouselDemoState createState() => _CustomCarouselDemoState();
}

class _CustomCarouselDemoState extends State<CustomCarouselDemo> {
  late PageController pageController;

  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      viewportFraction: 0.3,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: perspectivePageView(),
        // child: Center(
        //   child: Container(
        //     height: 200,
        //     child: PageView.builder(
        //       onPageChanged: (index) {
        //         setState(() {
        //           print('hello: $index');
        //           currentPage = index;
        //         });
        //       },
        //       controller: pageController,
        //       itemBuilder: (ctx, index) {
        //         return Padding(
        //           padding: currentPage != index
        //               ? const EdgeInsets.all(8)
        //               : const EdgeInsets.all(0),
        //           child: Container(
        //             margin: currentPage - index > 0
        //                 ? const EdgeInsets.only(left: 8)
        //                 : currentPage - index < 0
        //                     ? const EdgeInsets.only(right: 8)
        //                     : const EdgeInsets.all(0),
        //             decoration: BoxDecoration(
        //               color: Colors.lightBlueAccent,
        //               borderRadius: BorderRadius.circular(12),
        //               border: Border.all(
        //                 color: Colors.black,
        //                 width: 2,
        //               ),
        //             ),
        //             child: Center(
        //               child: Text('hello $index'),
        //             ),
        //           ),
        //         );
        //       },
        //     ),
        //   ),
        // ),
        // child: _customRow(),
      ),
    );
  }

  Widget perspectivePageView() {
    return Container(
      child: Center(
        // Adding Child Widget of Perspective PageView
        child: PerspectivePageView(
          hasShadow: true, // Enable-Disable Shadow
          shadowColor: Colors.black12, // Change Color
          aspectRatio: PVAspectRatio.ONE_ONE, // Aspect Ratio of 1:1 (Default)
          children: <Widget>[
            GestureDetector(
              onTap: () {
                debugPrint("Statement One");
              },
              child: Container(
                color: Colors.red,
              ),
            ),
            GestureDetector(
              onTap: () {
                debugPrint("Statement Two");
              },
              child: Container(
                color: Colors.green,
              ),
            ),
            GestureDetector(
              onTap: () {
                debugPrint("Statement Two");
              },
              child: Container(
                color: Colors.yellow,
              ),
            ),
            GestureDetector(
              onTap: () {
                debugPrint("Statement Two");
              },
              child: Container(
                color: Colors.black,
              ),
            ),
            GestureDetector(
              onTap: () {
                debugPrint("Statement Two");
              },
              child: Container(
                color: Colors.blue,
              ),
            ),
          ],

        ),
      ),
    );
  }

  Widget _customRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          10,
          (index) => Container(
            width: 100,
            height: 100,
            // margin: EdgeInsets.only(right: 16.0 * (currentPage - index).abs()),
            child: Padding(
              padding: EdgeInsets.all(8.0 * (currentPage - index).abs()),
              child: Container(
                color: Colors.redAccent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

////////////////////////////////
class SnappingListView extends StatefulWidget {
  final Axis scrollDirection;
  final ScrollController? controller;

  final IndexedWidgetBuilder? itemBuilder;
  final List<Widget>? children;
  final int? itemCount;

  final double itemExtent;
  final ValueChanged<int>? onItemChanged;

  final EdgeInsets padding;

  SnappingListView(
      {this.scrollDirection = Axis.vertical,
      this.controller,
      required this.children,
      required this.itemExtent,
      this.onItemChanged,
      this.padding = const EdgeInsets.all(0.0)})
      : assert(itemExtent > 0),
        itemCount = null,
        itemBuilder = null;

  SnappingListView.builder(
      {this.scrollDirection = Axis.vertical,
      this.controller,
      required this.itemBuilder,
      this.itemCount,
      required this.itemExtent,
      this.onItemChanged,
      this.padding = const EdgeInsets.all(0.0)})
      : assert(itemExtent > 0),
        children = null;

  @override
  createState() => _SnappingListViewState();
}

class _SnappingListViewState extends State<SnappingListView> {
  int _lastItem = 0;

  @override
  Widget build(BuildContext context) {
    final startPadding = widget.scrollDirection == Axis.horizontal
        ? widget.padding.left
        : widget.padding.top;
    final scrollPhysics = SnappingListScrollPhysics(
        mainAxisStartPadding: startPadding, itemExtent: widget.itemExtent);
    final listView = widget.children != null
        ? ListView(
            scrollDirection: widget.scrollDirection,
            controller: widget.controller,
            children: widget.children!,
            itemExtent: widget.itemExtent,
            physics: scrollPhysics,
            padding: widget.padding)
        : ListView.builder(
            scrollDirection: widget.scrollDirection,
            controller: widget.controller,
            itemBuilder: widget.itemBuilder!,
            itemCount: widget.itemCount,
            itemExtent: widget.itemExtent,
            physics: scrollPhysics,
            padding: widget.padding);
    return NotificationListener<ScrollNotification>(
        child: listView,
        onNotification: (notif) {
          if (notif.depth == 0 &&
              widget.onItemChanged != null &&
              notif is ScrollUpdateNotification) {
            final currItem =
                (notif.metrics.pixels - startPadding) ~/ widget.itemExtent;
            if (currItem != _lastItem) {
              _lastItem = currItem;
              widget.onItemChanged!(currItem);
            }
          }
          return false;
        });
  }
}

class SnappingListScrollPhysics extends ScrollPhysics {
  final double mainAxisStartPadding;
  final double itemExtent;

  const SnappingListScrollPhysics(
      {ScrollPhysics? parent,
      this.mainAxisStartPadding = 0.0,
      required this.itemExtent})
      : super(parent: parent);

  @override
  SnappingListScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return SnappingListScrollPhysics(
        parent: buildParent(ancestor),
        mainAxisStartPadding: mainAxisStartPadding,
        itemExtent: itemExtent);
  }

  double _getItem(ScrollMetrics position) {
    return (position.pixels - mainAxisStartPadding) / itemExtent;
  }

  double _getPixels(ScrollMetrics position, double item) {
    return min(item * itemExtent, position.maxScrollExtent);
  }

  double _getTargetPixels(
      ScrollMetrics position, Tolerance tolerance, double velocity) {
    double item = _getItem(position);
    if (velocity < -tolerance.velocity)
      item -= 0.5;
    else if (velocity > tolerance.velocity) item += 0.5;
    return _getPixels(position, item.roundToDouble());
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    // If we're out of range and not headed back in range, defer to the parent
    // ballistics, which should put us back in range at a page boundary.
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent))
      return super.createBallisticSimulation(position, velocity);
    final Tolerance tolerance = this.tolerance;
    final double target = _getTargetPixels(position, tolerance, velocity);
    if (target != position.pixels)
      return ScrollSpringSimulation(spring, position.pixels, target, velocity,
          tolerance: tolerance);
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}
