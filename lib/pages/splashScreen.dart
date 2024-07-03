import 'dart:async';

import 'package:clockin/components/colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final Widget Function() nextScreenBuilder;
  final String logo;

  const SplashScreen(
      {super.key, required this.nextScreenBuilder, required this.logo});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _controller.repeat();
    _animation = CurvedAnimation(parent: _controller, curve: Curves.bounceIn);

    mudarTela(widget.nextScreenBuilder);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void mudarTela(Widget Function() screenBuilder) {
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => screenBuilder()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corBase,
      body: Center(
        child: Stack(
          children: [
            Positioned.fill(
              child: AspectRatio(
                aspectRatio: 1.0,
                child: FractionallySizedBox(
                  widthFactor: 0.28,
                  heightFactor: 0.28,
                  child: RotationTransition(
                    turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                    child: Image.asset('assets/2.png'),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: AspectRatio(
                aspectRatio: 1.0,
                child: FractionallySizedBox(
                  widthFactor: 0.3,
                  heightFactor: 0.3,
                  child: Image.asset('assets/1.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
