import 'package:flutter/material.dart';

class NeumorphicComingSoonBadge extends StatelessWidget {
  const NeumorphicComingSoonBadge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // A container with some padding and a neumorphic border
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          const BoxShadow(
            color: Colors.white,
            offset: Offset(-4.0, -4.0),
            blurRadius: 16.0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(4.0, 4.0),
            blurRadius: 16.0,
          ),
        ],
      ),
      // A stack that overlays the badge on the container content
      child: Stack(
        children: [
          // The container content can be any widget, such as an image
          Image.network(
            'https://flutter.dev/images/flutter-logo-sharing.png',
            fit: BoxFit.cover,
          ),
          // The badge is positioned at the top right corner of the container
          Positioned(
            top: 0,
            right: 0,
            // The badge is a container with some text and a neumorphic background
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(2.0, 2.0),
                    blurRadius: 4.0,
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-2.0, -2.0),
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: Text(
                'Coming Soon',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
