import 'package:animations/home_controls_overlay.dart';
import 'package:animations/moving_circles.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      endDrawer: HomeDrawer(),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Transform.translate(
            offset: Offset(offsetX, offsetY),
            child: Transform.scale(
              scale: 8 * scale,
              child: Transform.rotate(
                angle: 3.14 * rotate,
                child: Opacity(
                  opacity: opacity,
                  child: Container(
                    color: Colors.blue.shade900,
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
            ),
          ),
          HomeControlsOverlay(
            opacity: opacity,
            scale: scale,
            rotate: rotate,
            onOpacityChanged: (opacity) {
              setState(() {
                this.opacity = opacity;
              });
            },
            onScaleChanged: (scale) {
              setState(() {
                this.scale = scale;
              });
            },
            onRotateChanged: (rotate) {
              setState(() {
                this.rotate = rotate;
              });
            },
            onTopButtonTap: () {
              setState(() {
                offsetY -= dy;
              });
            },
            onLeftButtonTap: () {
              setState(() {
                offsetX -= dx;
              });
            },
            onRightButtonTap: () {
              setState(() {
                offsetX += dx;
              });
            },
            onBottomButtonTap: () {
              setState(() {
                offsetY += dy;
              });
            },
          ),
        ],
      ),
    );
  }

  double opacity = 1;
  double scale = 0.2;
  double rotate = 0.5;
  double offsetX = 0;
  double offsetY = 0;
  double dx = 5;
  double dy = 5;
}

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blue,
      child: ListView(
        children: [
          DrawerItem(
            label: 'Moving Circles',
            onTap: () {
              MovingCircles.navigate(context);
            },
          ),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({super.key, required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      title: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(color: Colors.white),
      ),
    );
  }
}
