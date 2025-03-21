import 'dart:math';

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

class _MovingCirclesState extends State<MovingCircles>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(
        children: [
          Visibility(
            visible: isLoaded,
            replacement: Center(
              child: CircularProgressIndicator(color: Colors.blue.shade100),
            ),
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: CirclesPainter(circles: circles),
                  size: screenSize,
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: AppBar(
              title: Text('Moving Circles'),
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  bool isLoaded = false;
  static const int maxCircles = 10;
  List<Circle> circles = [];
  late final AnimationController controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initialSetup();
  }

  void _initialSetup() {
    final screenSize = MediaQuery.sizeOf(context);
    final random = Random();

    final colors = [
      Colors.red,
      Colors.deepPurple,
      Colors.deepOrange,
      Colors.green,
      Colors.blue.shade900,
      Colors.pink,
      Colors.brown,
      Colors.amber,
    ];

    circles = List.generate(maxCircles, (index) {
      return Circle(
        x:
            random.nextDouble() * (screenSize.width - 2 * Circle.RADIUS) +
            Circle.RADIUS,
        y:
            random.nextDouble() * (screenSize.height - 2 * Circle.RADIUS) +
            Circle.RADIUS,
        dx: index % 2 == 0 ? -1 : 1,
        dy: index % 2 == 0 ? -1 : 1,
        color: colors[random.nextInt(colors.length)],
      );
    });

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );
    controller.repeat();

    setState(() {
      isLoaded = true;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class Circle {
  double x;
  double y;
  double dx;
  double dy;
  Color color;
  static const double RADIUS = 10;

  Circle({
    required this.x,
    required this.y,
    required this.dx,
    required this.dy,
    required this.color,
  });

  void draw(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(Offset(x, y), RADIUS, paint);

    final halfRadius = RADIUS / 2;

    x += dx * halfRadius;
    y += dy * halfRadius;

    if (x - halfRadius < 0 || x + halfRadius > size.width) {
      dx = -dx;
    }
    if (y - halfRadius < 0 || y + halfRadius > size.height) {
      dy = -dy;
    }
  }
}

class CirclesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    for (final circle in circles) {
      circle.draw(canvas, size);
    }
  }

  @override
  bool shouldRepaint(covariant CirclesPainter oldDelegate) {
    return true;
  }

  final List<Circle> circles;

  CirclesPainter({super.repaint, required this.circles});
}
