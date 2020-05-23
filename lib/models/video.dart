class Video {
  String id;
  String caption;
  String imageAuthor;
  String nameAuthor;
  String linkVideo;

  Video(
      {this.id,
      this.caption,
      this.imageAuthor,
      this.linkVideo,
      this.nameAuthor});

  Video.fromMap(Map<String, dynamic> data, String id)
      : id = id,
        caption = data['caption'],
        imageAuthor = data['imageAuthor'],
        nameAuthor = data['nameAuthor'],
        linkVideo = data['linkVideo'];

  Map<String, dynamic> toMap() {
    return {
      'caption': caption,
      'nameAuthor': nameAuthor,
      'imageAuthor': imageAuthor,
      'linkVideo': linkVideo,
    };
  }
}
