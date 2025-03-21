import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeControlsOverlay extends StatelessWidget {
  const HomeControlsOverlay({
    super.key,
    required this.opacity,
    required this.scale,
    required this.rotate,
    required this.onOpacityChanged,
    required this.onScaleChanged,
    required this.onRotateChanged,
    required this.onTopButtonTap,
    required this.onLeftButtonTap,
    required this.onRightButtonTap,
    required this.onBottomButtonTap,
  });

  final double opacity;
  final double scale;
  final double rotate;
  final Function(double opacity) onOpacityChanged;
  final Function(double scale) onScaleChanged;
  final Function(double rotate) onRotateChanged;

  final VoidCallback onTopButtonTap;
  final VoidCallback onLeftButtonTap;
  final VoidCallback onRightButtonTap;
  final VoidCallback onBottomButtonTap;

  @override
  Widget build(BuildContext context) {
    final labelLarge = Theme.of(
      context,
    ).textTheme.labelLarge?.copyWith(color: Colors.white);
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          title: Text('Animations'),
          actions: [EndDrawerButton(), Gap(15)],
        ),
        Divider(),
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Opacity', style: labelLarge),
                  Slider(
                    min: 0,
                    max: 1,
                    value: opacity,
                    onChanged: onOpacityChanged,
                    padding: EdgeInsets.zero,
                    inactiveColor: Colors.blue.shade100,
                    activeColor: Colors.white,
                  ),
                  Gap(20),
                  Text('Scale', style: labelLarge),
                  Slider(
                    min: 0,
                    max: 1,
                    value: scale,
                    onChanged: onScaleChanged,
                    padding: EdgeInsets.zero,
                    inactiveColor: Colors.blue.shade100,
                    activeColor: Colors.white,
                  ),
                  Gap(20),
                  Text('Rotate', style: labelLarge),
                  Slider(
                    min: 0,
                    max: 1,
                    value: rotate,
                    onChanged: onRotateChanged,
                    padding: EdgeInsets.zero,
                    inactiveColor: Colors.blue.shade100,
                    activeColor: Colors.white,
                  ),
                ],
              ),
              Spacer(),
              SizedBox(
                width: 150,
                height: 150,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: CircleButton(label: 'T', onTap: onTopButtonTap),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CircleButton(label: 'L', onTap: onLeftButtonTap),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CircleButton(label: 'R', onTap: onRightButtonTap),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CircleButton(label: 'B', onTap: onBottomButtonTap),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CircleButton extends StatefulWidget {
  const CircleButton({super.key, required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  State<CircleButton> createState() => _CircleButtonState();
}

class _CircleButtonState extends State<CircleButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        _timer?.cancel();
        _timer = Timer.periodic(Duration(milliseconds: 60), (timer) {
          widget.onTap();
        });
      },
      onTapUp: (details) {
        _timer?.cancel();
      },
      child: Container(
        width: 50,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Text(
          widget.label,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: Colors.blue),
        ),
      ),
    );
  }

  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
