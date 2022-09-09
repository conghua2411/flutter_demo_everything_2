import 'package:flutter/material.dart';
import 'package:flutter_demo_everything_2/dio_demo/network.dart';
import 'package:flutter_demo_everything_2/helper/extension/navigator_extension.dart';

class DioDemo extends StatefulWidget {
  const DioDemo({Key? key}) : super(key: key);

  @override
  State<DioDemo> createState() => _DioDemoState();
}

class _DioDemoState extends State<DioDemo> {
  Network _network = Network();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: _buildPostItem,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.question_mark,
        ),
        onPressed: _showDemoInfo,
      ),
    );
  }

  void _showDemoInfo() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(
            'Dio interceptor demo',
          ),
          content: Text(
            'Request post, if post id is even return the 2*id post, '
            'with 2 sec delay',
          ),
        );
      },
    );
  }

  Widget _buildPostItem(
    BuildContext context,
    int index,
  ) {
    return TextButton(
      onPressed: () async {
        final response = await _network.get(
          path: '/posts',
          queryParameters: {
            'id': index + 1,
          },
        );

        if (response.statusCode == 200) {
          final postData = response.data[0];
          context.push(
            PostDetail(
              id: postData['id'],
              title: postData['title'],
              body: postData['body'],
            ),
          );
        }
      },
      child: Text(
        'Post ${index + 1}',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class PostDetail extends StatelessWidget {
  final int id;
  final String title;
  final String body;

  const PostDetail({
    Key? key,
    required this.id,
    required this.title,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                id.toString(),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  body,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
