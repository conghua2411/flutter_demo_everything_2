import 'dart:math';

import 'package:flutter/material.dart';

import 'pinterest_item_preview.dart';

class PinterestPreview extends StatefulWidget {
  const PinterestPreview({Key? key}) : super(key: key);

  @override
  State<PinterestPreview> createState() => _PinterestPreviewState();
}

class _PinterestPreviewState extends State<PinterestPreview> {
  List<String> images = [
    'https://i.pinimg.com/564x/fc/ff/6e/fcff6e833e882d98a238721f7bb20b73.jpg',
    'https://i.pinimg.com/236x/e6/16/e2/e616e2db5113396538c634ca3b1c7fb0.jpg',
    'https://i.pinimg.com/564x/d0/e5/9c/d0e59cd8deb829b01b6ca223646906d7.jpg',
    'https://i.pinimg.com/564x/c0/18/b5/c018b5bf0b262f965a0b7ab44df8ce22.jpg',
    'https://i.pinimg.com/564x/50/a8/d9/50a8d98d7403e9e3ea5842a1bcfbe352.jpg',
    'https://i.pinimg.com/564x/b3/12/ae/b312ae198d24cafd9375a9cb9759e584.jpg',
    'https://i.pinimg.com/564x/62/f9/74/62f974ae2eee3717d378c0d8b5747e20.jpg',
    'https://i.pinimg.com/564x/76/c0/10/76c0108d8f586c31f428fa05ec02fc85.jpg',
    'https://i.pinimg.com/564x/8b/1a/18/8b1a18cb3aeb0a98a24ec716d2dfc8ca.jpg',
  ];

  final _random = Random();

  (String, String, String) _random3DifferenceImage() {
    int index = _random.nextInt(images.length);
    int index2 = _random.nextInt(images.length);
    do {
      index2 = _random.nextInt(images.length);
    } while (index == index2);

    int index3 = _random.nextInt(images.length);
    do {
      index3 = _random.nextInt(images.length);
    } while (index3 == index || index3 == index2);

    return (images[index], images[index2], images[index3]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pinterest Preview'),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          var (image, image2, image3) = _random3DifferenceImage();

          return PinterestItemPreview(
            dpo: PinterestItemDpo(
              first: image,
              second: image2,
              third: image3,
              name: 'Character',
            ),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
