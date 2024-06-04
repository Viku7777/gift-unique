import 'package:flutter/material.dart';

class TestLoginView extends StatelessWidget {
  const TestLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text("Test Auth View"),
      ),
    );
  }
}
