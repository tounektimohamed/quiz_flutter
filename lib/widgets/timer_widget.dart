import 'package:flutter/material.dart';

class TimerWidget extends StatelessWidget {
  final Duration duration;
  final VoidCallback onTimeUp;

  const TimerWidget({super.key, required this.duration, required this.onTimeUp});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<int>(
      tween: IntTween(begin: duration.inSeconds, end: 0), // Utilisez IntTween pour les entiers
      duration: duration,
      builder: (context, value, child) {
        return Text(
          'Temps restant: $value',
          style: const TextStyle(fontSize: 18),
        );
      },
      onEnd: onTimeUp,
    );
  }
}