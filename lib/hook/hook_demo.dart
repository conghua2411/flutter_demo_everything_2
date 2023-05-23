import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HookDemo extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _counter = useState(0);

    final _animation = useAnimationController(
        duration: Duration(seconds: 1), lowerBound: 0.5, upperBound: 1);

    Future hey() => Future.delayed(Duration(seconds: 2), () => 'Hey');

    final heyText = useFuture(hey());

    return Scaffold(
      appBar: AppBar(
        title: Text('Hook demo'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              AnimatedBuilder(
                  animation: _animation,
                  builder: (ctx, child) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(24 * _animation.value),
                        border: Border.all(
                          color: Colors.blue,
                          width: _animation.value * 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: child,
                      ),
                    );
                  },
                  child: Text('${_counter.value}')),
              Text('${heyText.data}'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.plus_one),
        onPressed: () {
          _animation.forward(from: 0);
          _counter.value++;
        },
      ),
    );
  }
}
