import 'package:flutter/material.dart';

class ReuseableButton extends StatelessWidget {
  const ReuseableButton({
    super.key,
    required this.text,
    required this.onTap,
    this.enabled = true, // default to true if not provided
    this.buttonColor, // optional color parameter
  });

  final String text;
  final VoidCallback? onTap; // Make it nullable to handle disabled state
  final bool enabled;
  final Color? buttonColor; // Optional color parameter

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
      child: MaterialButton(
        onPressed: enabled
            ? onTap
            : null, // Use enabled flag to determine if onTap should be null
        minWidth: size.width * 0.9,
        height: size.height * 0.07,
        color: buttonColor ??
            const Color(0xff141414), // Use provided color or default
        disabledColor: Colors.grey, // Color when button is disabled
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
