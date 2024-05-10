import 'package:flutter/material.dart';

class TabAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TabAppBar({super.key, required this.tabs});
  final List<Widget> tabs;

  // Rozmiar APP Bara
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 24);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Theme(
      data: theme.copyWith(
        colorScheme:
            theme.colorScheme.copyWith(surfaceVariant: Colors.transparent),
      ),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(20)),),
        child: Column(
          children: [
            // Przestrzeń
            const SizedBox(
              height: 24,
            ),
            SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: kToolbarHeight - (0.16 * kToolbarHeight),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  border: Border.all(color: Colors.black38, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.tab,
                  padding: const EdgeInsets.all(0),
                  indicator: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black.withOpacity(0.5)),
                  ),
                  tabs: tabs,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
