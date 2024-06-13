import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.child,
    this.margin = const EdgeInsets.all(0),
    this.controller,
  });

  final dynamic controller;
  final Widget child;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: MediaQuery.of(context).size.width / 1.03,
      // height: MediaQuery.of(context).size.height / 2.97,
      height: MediaQuery.of(context).size.height / 3.76,

      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
        border: const Border(
          bottom: BorderSide(color: Colors.black, width: 2),
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 1,
            color: Colors.black,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}
