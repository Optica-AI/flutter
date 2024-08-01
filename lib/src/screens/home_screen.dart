import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  late YoutubePlayerController _controller;

  @override
  void initState(){
    super.initState();
    _controller = YoutubePlayerController(
        initialVideoId: 'BAVW-3LICdg',
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        )
    );
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Guidelines',
          style: TextStyle(
            color: Colors.purple[900],
            fontWeight: FontWeight.w500,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey[300],
            height: 1.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  "Good Day,",
                  style: TextStyle(
                    color: Colors.purple[900],
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    // fontFamily: 'Nunito',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: Text(
                  "how do your eyes feel today?",
                  style: TextStyle(
                    color: Colors.purple[900],
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    // fontFamily: 'Nunito',
                  ),
                ),
              ),
              const Text(
                'Get familiar with Optica with this video tutorial',
                style: TextStyle(
                  // fontSize:  ,
                  // fontFamily: ,
                ),
              ),
              //Video placeHolder
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 30.0),
                child: Container( //This container should hold a youtube video.
                  height: 200.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.deepPurple[50],
                  ),
                  child: YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.deepPurple,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Divider(
                  thickness: 1.0,
                  indent: 20.0,
                  endIndent: 20.0,
                ),
              ),
              //Text guidelines
              Container(
                // height: 100.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.deepPurple[50],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Did you know?',
                            style: TextStyle(
                              // fontFamily: 'Nunito',
                              fontWeight: FontWeight.w800,
                              overflow: TextOverflow.clip,
                              color: Colors.purple[900],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text('Glaucoma is known as the "silent thief of sight" because it can cause significant vision '
                                'loss without noticeable symptoms. Regular eye exams are crucial for early detection, '
                                'especially for those at higher risk, such as older adults and people with a family history of glaucoma. '
                                'Early treatment can help preserve vision. '
                              ,
                              overflow: TextOverflow.fade,
                              softWrap: true,
                              maxLines: 3,
                              style: TextStyle(
                                color: Colors.purple[800],
                                // fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



