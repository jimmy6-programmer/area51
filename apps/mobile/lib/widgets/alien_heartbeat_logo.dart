import 'package:flutter/material.dart';

class AlienHeartbeatLogo extends StatelessWidget {
  final double size;
  final bool animate;

  const AlienHeartbeatLogo({super.key, this.size = 48.0, this.animate = false});

  @override
  Widget build(BuildContext context) {
    final green = Theme.of(context).colorScheme.primary;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Image.asset(
        //   'assets/logo/logo.png',
        //   width: size * 1,
        //   height: size * 1,
        // ),
        // const SizedBox(width: 8),
        Text(
          'AREA 51',
          style: TextStyle(
            fontSize: size * 0.5,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
            color: green,
          ),
        ),
      ],
    );
  }
}
