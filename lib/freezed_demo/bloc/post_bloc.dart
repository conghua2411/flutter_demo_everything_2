import 'dart:async';

import 'package:flutter_demo_everything_2/freezed_demo/model/post.dart';

class PostBloc {
  late StreamController<List<Post>> streamListPost;

  PostBloc() {
    streamListPost = StreamController.broadcast();
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

  void addStreamListPostData(List<Post> data) {
    if (!streamListPost.isClosed) {
      streamListPost.add(data);
    }
  }

  dispose() {
    streamListPost.close();
  }
}
