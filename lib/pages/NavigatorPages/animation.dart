import 'package:flutter/material.dart';

import '../../styles/styles.dart';
class CircleAnimationWidget extends StatefulWidget {
  final double timing;
  final double maxTime;

  CircleAnimationWidget({required this.timing, required this.maxTime});

  @override
  _CircleAnimationWidgetState createState() => _CircleAnimationWidgetState();
}

class _CircleAnimationWidgetState extends State<CircleAnimationWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1), // Adjust the duration as needed
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: widget.timing / widget.maxTime,
    ).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    return Container(
      height: media.size.height * 0.02,
      width: media.size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(media.size.width * 0.01),
        color: Colors.grey,
      ),
      alignment: Alignment.centerLeft,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Container(
            height: media.size.height * 0.02,
            width: media.size.width * 0.9 * _animation.value,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(media.size.width * 0.01),
              color: buttonColor,
            ),
          );
        },
      ),
    );
  }
}

// To use the CircleAnimationWidget in your main widget:

