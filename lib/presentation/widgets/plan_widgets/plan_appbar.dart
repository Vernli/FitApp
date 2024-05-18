import 'package:flutter/material.dart';

class PlanAddAppbar extends StatefulWidget {
  final String title;
  final double paddingTop;
  const PlanAddAppbar({
    super.key,
    required this.title,
    required this.paddingTop,
  });

  @override
  State<PlanAddAppbar> createState() => _PlanAddAppbarState();
}

class _PlanAddAppbarState extends State<PlanAddAppbar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: widget.paddingTop,
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).colorScheme.primary,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          padding: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
            boxShadow: const [
              BoxShadow(
                blurRadius: 2,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: 250,
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
