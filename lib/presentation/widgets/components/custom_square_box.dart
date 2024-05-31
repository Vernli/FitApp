// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomSquareBox extends StatelessWidget {
  final String textValue;
  const CustomSquareBox({
    super.key,
    required this.textValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          '$textValue kg',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
