import 'package:fashion_story/models/video.dart';
import 'package:fashion_story/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  String _videoId = YoutubePlayer.convertUrlToId(
      "https://www.youtube.com/watch?v=CcMvQ57xy0I");

  YoutubePlayerController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirestoreService().getVideo(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Video>> snapshot) {
              if (snapshot.hasError || !snapshot.hasData)
                return CircularProgressIndicator();
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    Video video = snapshot.data[index];
                    return Stack(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: YoutubePlayer(
                            controller: YoutubePlayerController(
                              initialVideoId:
                                  YoutubePlayer.convertUrlToId(video.linkVideo),
                              flags: YoutubePlayerFlags(
                                mute: false,
                                autoPlay: true,
                              ),
                            ),
                            showVideoProgressIndicator: true,
                            progressIndicatorColor: Colors.blueAccent,
                          ),
                        ),
                        Positioned(
                          left: 20,
                          bottom: 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('this is a name author',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              Text('this is a name author',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white))
                            ],
                          ),
                        )
                      ],
                    );
                  });
            }));
  }
}
