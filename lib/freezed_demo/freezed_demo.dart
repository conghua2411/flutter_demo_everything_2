import 'package:flutter/material.dart';
import 'package:flutter_demo_everything_2/freezed_demo/bloc/post_bloc.dart';
import 'package:flutter_demo_everything_2/freezed_demo/model/post.dart';

class FreezedDemo extends StatefulWidget {
  const FreezedDemo({Key? key}) : super(key: key);

  @override
  State<FreezedDemo> createState() => _FreezedDemoState();
}

class _FreezedDemoState extends State<FreezedDemo> {
  late PostBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = PostBloc();
  }

  @override
  void dispose() {
    bloc.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Freezed demo'),
      ),
      body: StreamBuilder<List<Post>>(
          initialData: [],
          stream: bloc.listenListPost(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemBuilder: (ctx, index) {
                return PostWidget(snapshot.data![index]);
              },
              itemCount: snapshot.data!.length,
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.cloud_upload),
        onPressed: _loadListPost,
      ),
    );
  }

  _loadListPost() async {
    List<Post> list = await bloc.getListPostFuture();

    bloc.addStreamListPostData(list);
  }

  Widget PostWidget(Post post) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${post.id}: ${post.content}',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text('${post.toJson()}'),
          SizedBox(
            height: 8,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${post.createDate}',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
