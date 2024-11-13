import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue[800],
          foregroundColor: Colors.white,
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late VideoPlayerController _controller;
  bool _isVideoReady = false;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(
      'videos/hev.mp4', // Local asset video path
    )
      ..initialize().then((_) {
        setState(() {
          _isVideoReady = true;
        });
        _controller.setLooping(true);
        _controller.play();
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text('Know Me More'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  _ButtonWithPic('images/pic1.jpg', 'Who am I?', "Justin Legaspi"),

                  SizedBox(width: 20),

                  _ButtonWithPic('images/pic2.png', 'Where do I live?', "Mendez, Cavite"),
                ],
              ),

              SizedBox(height: 20),

              _ButtonWithPic('images/pic3.jpg', 'What Course am I taking?', "Computer Engineering"),

              SizedBox(height: 20),

              _ButtonWithVid('videos/hev.mp4', 'Who is my Favorite Artist?', "Hev Abi"),

              SizedBox(height: 20),

              Text('The Packages I used Are:'),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  _ButtonOnly('Flutter Toast', 'The fluttertoast package provides an easy way to show simple toast messages in Flutter applications. Toasts are brief messages that pop up on the screen, providing feedback to users. They automatically disappear after a short duration, and you can control their appearance, position, and duration. It’s a great way to notify users about certain actions (like button presses) without interrupting the user experience.'),

                  SizedBox(width: 20),

                  _ButtonOnly('Video Player', 'The video_player package allows you to display and control video playback in Flutter apps. It supports both network and local asset videos, providing features like play, pause, seek, and volume control. You can also loop videos and listen to playback state changes. It’s ideal for apps that require video content, such as media players, tutorials, or video streaming services.'),
                ],
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _ButtonWithPic(String imagePath, String buttonText, String toastMessage) {
    return Column(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: AssetImage(imagePath),
        ),
        SizedBox(height: 15),
        ElevatedButton(
          onPressed: () {
            Fluttertoast.showToast(
              msg: toastMessage,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
            );
          },
          child: Text(buttonText),
        ),
      ],
    );
  }

  Widget _ButtonWithVid(String videoUrl, String buttonText, String toastMessage) {
    return Column(
      children: [
        _isVideoReady
            ? Container(
          width: 500,
          height: 250,
          child: VideoPlayer(_controller),
        )
            : CircularProgressIndicator(),

        SizedBox(height: 15),

        ElevatedButton(
          onPressed: () {
            Fluttertoast.showToast(
              msg: toastMessage,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
            );
          },
          child: Text(buttonText),
        ),
      ],
    );
  }

  Widget _ButtonOnly(String buttonText, String toastMessage) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Fluttertoast.showToast(
              msg: toastMessage,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
            );
          },
          child: Text(buttonText),
        ),
      ],
    );
  }
}
