import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final String text;
  final Size size;
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: size,
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.black,
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        shadowColor: Colors.black.withOpacity(0.8),
        elevation: 3,
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
