import 'package:cloud_firestore/cloud_firestore.dart';

class TheNew {
  final String id;
  final String image;
  final String image1;
  final String image2;
  final String title;
  final String content;
  final Timestamp createAt;

  TheNew(
      {this.id,
      this.content,
      this.createAt,
      this.image,
      this.image1,
      this.image2,
      this.title});

  TheNew.fromMap(Map<String, dynamic> data, String id)
      : id = id,
        title = data['title'],
        createAt = data['createAt'],
        content = data['content'],
        image = data['image'],
        image1 = data['image1'],
        image2 = data['image2'];
}
