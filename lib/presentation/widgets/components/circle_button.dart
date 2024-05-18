// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CircleButton extends StatefulWidget {
  final Function onPressed;
  final double size;
  const CircleButton({
    super.key,
    required this.onPressed,
    required this.size,
  });

  @override
  State<CircleButton> createState() => _CircleButtonState();
}

class _CircleButtonState extends State<CircleButton> {
  bool wasPressed = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: !wasPressed ? widget.size : (widget.size * 0.98),
      height: !wasPressed ? widget.size : (widget.size * 0.98),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: Colors.black.withOpacity(0.6)),
          color: Theme.of(context).colorScheme.primaryContainer,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              blurRadius: 2,
            ),
          ]),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          backgroundColor: !wasPressed
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.primaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        onPressed: () {
          setState(() {
            wasPressed = !wasPressed;
          });
          widget.onPressed();
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: widget.size * 0.3,
        ),
      ),
    );
  }
}
