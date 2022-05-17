import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_demo_everything_2/freezed_demo/model/post.dart';

part 'post_state.dart';

part 'post_bloc.freezed.dart';

class PostBloc {
  late StreamController<List<Post>> streamListPost;
  late StreamController<PostState> streamState;

  PostBloc() {
    streamListPost = StreamController.broadcast();
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

  Stream<List<Post>> listenListPost() => streamListPost.stream;

  Stream<PostState> listenPostState() => streamState.stream;

  void addStreamListPostData(List<Post> data) {
    if (!streamListPost.isClosed) {
      streamListPost.add(data);
    }
  }

  dispose() {
    streamListPost.close();
    streamState.close();
  }

  void loadListPost() async {
    streamState.add(PostState.loading());
    List<Post> list = await getListPostFuture();
    streamState.add(PostState.loaded(list: list));
  }
}
