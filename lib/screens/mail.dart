import 'package:flutter/material.dart';

class MailScreen extends StatelessWidget {
  const MailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mail'),
      ),
      body: const Center(
        child: Text(
          'Mail Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
