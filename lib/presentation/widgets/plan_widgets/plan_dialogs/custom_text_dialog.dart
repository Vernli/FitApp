import 'package:flutter/material.dart';

class CustomTextDialog extends StatefulWidget {
  final String title;
  final String hintText;
  final String errorMessage;
  final Function(String) onPressed;

  const CustomTextDialog({
    super.key,
    required this.title,
    required this.hintText,
    required this.errorMessage,
    required this.onPressed,
  });

  @override
  State<CustomTextDialog> createState() => _CustomTextDialogState();
}

class _CustomTextDialogState extends State<CustomTextDialog> {
  final TextEditingController _textController = TextEditingController();
  bool isTextEmpty = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      elevation: 2,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Colors.black,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      insetPadding: const EdgeInsets.all(0),
      child: SizedBox(
        height: 224,
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Dialog title
            Container(
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 1,
                    offset: Offset(0, 2),
                  ),
                ],
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Center(
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),

            // Text field for plan name with limit of 18 characters
            SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  maxLength: 18,
                  autocorrect: false,
                  controller: _textController,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // show error message if the text field is empty
            isTextEmpty
                ? SizedBox(
                    height: 24,
                    child: Text(
                      widget.errorMessage,
                      style: TextStyle(
                        color: Colors.orange.shade300,
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 0,
                  ),
            Container(
              width: 120,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 1,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  // Check if the text field is empty or contains only whitespaces
                  if (_textController.text.isEmpty ||
                      _textController.text.trim().isEmpty) {
                    setState(() {
                      isTextEmpty = true;
                      _textController.clear();
                    });
                    return;
                  } else {
                    Navigator.pop(context);
                    // Send the value to the onPressed function
                    widget.onPressed(
                      _textController.text,
                    );
                    return;
                  }
                },
                child:
                    const Text('Dalej', style: TextStyle(color: Colors.white)),
              ),
            ),

            // Empty space at the bottom to align the button
            const SizedBox(
              height: 14,
            ),
          ],
        ),
      ),
    );
  }
}
