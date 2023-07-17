import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_demo_everything_2/freezed_demo/model/post.dart';

part 'post_state.dart';

part 'post_bloc.freezed.dart';

class PostBloc {
  late StreamController<PostState> streamState;

  PostBloc() {
    streamState = StreamController.broadcast();

    streamState.add(PostState.initial());
  }

  List<Post> getListPost() => List.generate(
        20,
        (index) => Post(
          id: index,
          content: 'asdasas dd ' * (index + 1),
          createDate: DateTime.now(),
        ),
      );

  Future<List<Post>> getListPostFuture() => Future.delayed(
        Duration(seconds: 1),
        () => getListPost(),
      );

  Stream<PostState> listenPostState() => streamState.stream;

  void loadListPost() async {
    streamState.add(PostState.loading());
    List<Post> list = await getListPostFuture();
    streamState.add(PostState.loaded(list: list));
  }

  dispose() {
    streamState.close();
  }
}
