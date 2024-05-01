import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onPressed;
  const AddButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            Theme.of(context).colorScheme.primary.withOpacity(0.98),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.black,
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        shadowColor: Colors.black.withOpacity(0.8),
        elevation: 2,
      ),
      child: const Text(
        'Dodaj',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
