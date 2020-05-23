import 'package:fashion_story/models/video.dart';
import 'package:fashion_story/services/database_service.dart';
import 'package:flutter/material.dart';

class AddVideoPlayer extends StatefulWidget {
  @override
  _AddVideoPlayerState createState() => _AddVideoPlayerState();
}

class _AddVideoPlayerState extends State<AddVideoPlayer> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  TextEditingController _captionController;
  TextEditingController _videoIdController;


  FocusNode _captionNode;
  @override
  void initState() {
    super.initState();
    _captionController = TextEditingController(text: '');
    _videoIdController = TextEditingController(text: '');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('AddVideo'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.file_upload),
                onPressed: () {
                  _setupVideo();
                })
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(_captionNode);
                    },
                    controller: _captionController,
                    validator: (value) {
                      if (value.length < 4) return "caption cannot be empty";
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'caption', border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    focusNode: _captionNode,
                    controller: _videoIdController,
                    maxLines: 1,
                    decoration: InputDecoration(
                        labelText: 'Link', border: OutlineInputBorder()),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  _setupVideo() async {
    if (_key.currentState.validate()) {
      try {
        await FirestoreService().addVideo(Video(
          caption: _captionController.text,
          imageAuthor: 'assets//',
          nameAuthor: 'Nguyễn bá Tú',
          linkVideo: _videoIdController.text,
        ));
        Navigator.pop(context);
      } catch (e) {
        print(e);
      }
    }
  }
}
