import 'package:flutter/material.dart';

class IntroWidget extends StatefulWidget {
  const IntroWidget({super.key});

  @override
  State<IntroWidget> createState() => _IntroWidgetState();
}

class _IntroWidgetState extends State<IntroWidget> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'IntroWidget is working',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
