import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  Logo({
    this.dark = false,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        dark
            ? 'assets/images/logos/logo-text-dark.png'
            : 'assets/images/logos/logo-text.png',
        fit: BoxFit.cover,
        width: 300,
      ),
    );
  }
}
