import 'package:flutter_demo_everything_2/freezed_demo/model/post.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Map<String, dynamic> postJson = {
    'id': 1,
    'content': 'content',
    'createDate': DateTime.now().toString(),
  };

  group('post model test', () {
    test('post model parser test', () {
      Post post = Post.fromJson(postJson);
      expect(post.id, 1);
      expect(post.content, 'content');
      expect(post.createDate != null, true);
    });
  });
}