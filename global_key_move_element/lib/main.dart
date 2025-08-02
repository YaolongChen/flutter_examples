import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _ballKey = GlobalKey();

  BallPosition _ballPosition = BallPosition.top;

  @override
  Widget build(BuildContext context) {
    final mountedKeyBall = Ball(key: _ballKey, text: 'MountedKey');
    final normalBall = Ball(text: 'Normal');

    return Scaffold(
      body: Stack(
        children: [
          if (_ballPosition == BallPosition.top)
            Align(alignment: FractionalOffset(.3, 0), child: mountedKeyBall),
          if (_ballPosition == BallPosition.top)
            Align(alignment: FractionalOffset(.6, 0), child: normalBall),
          Center(child: Divider()),
          if (_ballPosition == BallPosition.bottom)
            Align(alignment: FractionalOffset(.3, 1.0), child: mountedKeyBall),
          if (_ballPosition == BallPosition.bottom)
            Align(alignment: FractionalOffset(.6, 1.0), child: normalBall),
        ],
      ),
      persistentFooterButtons: [
        OutlinedButton(
          onPressed: () {
            setState(() {
              _ballPosition = BallPosition.top;
            });
          },
          child: Text('MoveBallsToTop'),
        ),
        OutlinedButton(
          onPressed: () {
            setState(() {
              _ballPosition = BallPosition.bottom;
            });
          },
          child: Text('MoveBallsToBottom'),
        ),
      ],
    );
  }
}

enum BallPosition { top, bottom }

class Ball extends StatefulWidget {
  const Ball({super.key, required this.text});

  final String text;

  @override
  State<Ball> createState() => _BallState();
}

class _BallState extends State<Ball> {
  @override
  void initState() {
    super.initState();
    print('Ball ${widget.text} initState');
  }

  @override
  void dispose() {
    print('Ball ${widget.text} dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(color: Colors.yellow, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(widget.text),
    );
  }
}
