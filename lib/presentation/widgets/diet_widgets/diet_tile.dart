import 'package:flutter/material.dart';

class DietTile extends StatelessWidget {
  final String mealName;
  final Function onExpansionChanged;
  final Function onAddButton;
  final bool initiallyExpanded;
  final Widget tileInformations;
  final List<Widget> children;

  const DietTile({
    super.key,
    required this.mealName,
    required this.onExpansionChanged,
    required this.onAddButton,
    required this.initiallyExpanded,
    required this.children,
    required this.tileInformations,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: ExpansionTile(
          initiallyExpanded: initiallyExpanded,
          backgroundColor: Colors.transparent,
          onExpansionChanged: (value) {
            if (value) {
              onExpansionChanged(value);
            }
          },
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mealName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  tileInformations,
                ],
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      onAddButton();
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          children: children,
        ),
      ),
    );
  }
}
