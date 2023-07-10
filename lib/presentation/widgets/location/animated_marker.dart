// ignore_for_file: unused_field

import 'package:flutter/Material.dart';

class AnimatedMarker extends StatefulWidget {
  const AnimatedMarker({super.key});

  @override
  State<AnimatedMarker> createState() => _AnimatedMarkerState();
}

class _AnimatedMarkerState extends State<AnimatedMarker>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _scaleAnimation;
  Animation<double>? _colorAnimation;
  final bool _isFirstContainerVisible = true;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        weight: 0.5,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1.0, end: 0.0),
        weight: 0.5,
      ),
    ]).animate(_animationController!);

    _colorAnimation = TweenSequence<double>([
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1.0, end: 0.0),
        weight: 0.5,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        weight: 0.5,
      ),
    ]).animate(_animationController!);

    _animationController!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController!.reset();
        _animationController!.forward();
      }
    });

    _animationController!.forward();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _scaleAnimation!,
            builder: (BuildContext context, Widget? child) {
              return Transform.scale(
                scale: _scaleAnimation!.value,
                child: Opacity(
                  opacity: _colorAnimation!.value,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.teal,
                    ),
                  ),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: _scaleAnimation!,
            builder: (BuildContext context, Widget? child) {
              return Transform.scale(
                scale: 1.0 - _scaleAnimation!.value,
                child: Opacity(
                  opacity: 1.0 - _colorAnimation!.value,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.teal,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
