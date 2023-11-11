import 'package:flutter/material.dart';

class TestPageA extends StatelessWidget {
  const TestPageA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Test Page A'),
      ),
    );
  }
}
