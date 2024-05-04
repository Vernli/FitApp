import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.child,
    this.controller,
  });

  final dynamic controller;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.03,
      height: MediaQuery.of(context).size.height / 3.8,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
        border: Border(
          bottom: BorderSide(color: Colors.black.withOpacity(0.5), width: 2),
        ),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(1), blurRadius: 4),
        ],
      ),
      child: child,
    );
  }
}
