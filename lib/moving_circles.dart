import 'package:flutter/material.dart';

class MovingCircles extends StatefulWidget {
  const MovingCircles({super.key});

  @override
  State<MovingCircles> createState() => _MovingCirclesState();

  static navigate(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return MovingCircles();
        },
      ),
    );
  }
}

class _MovingCirclesState extends State<MovingCircles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('Moving Circles'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
    );
  }
}
