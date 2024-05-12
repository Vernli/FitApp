import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Color color;
  final Color onPressedColor;
  final String text;
  final Size size;
  const CustomButton({
    super.key,
    required this.text,
    required this.color,
    required this.size,
    required this.onPressed,
    required this.onPressedColor,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  late bool wasPressed;
  @override
  void initState() {
    super.initState();
    wasPressed = false;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.onPressed();
        setState(() {
          wasPressed = !wasPressed;
          Future.delayed(const Duration(milliseconds: 250), () {
            setState(() {
              wasPressed = !wasPressed;
            });
          });
        });
      },
      style: ElevatedButton.styleFrom(
        minimumSize: widget.size,
        backgroundColor: wasPressed ? widget.onPressedColor : widget.color,
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
        widget.text,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
