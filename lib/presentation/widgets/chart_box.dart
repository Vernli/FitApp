import 'package:app/presentation/widgets/components/chart.dart';
import 'package:flutter/material.dart';

class ChartBox extends StatefulWidget {
  const ChartBox({super.key});

  @override
  State<ChartBox> createState() => _ChartBoxState();
}

class _ChartBoxState extends State<ChartBox> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolling = false;

  @override
  void initState() {
    super.initState();
  }

  List scrollSpace = [0, 75, 150, 225, 300, 375, 450, 525, 600];

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.position.isScrollingNotifier.addListener(() {
        setState(() {
          _isScrolling = true;
          if (_scrollController.hasClients) {
            if (!_scrollController.position.isScrollingNotifier.value) {
              int nearestIndex = scrollSpace.reduce(
                (a, b) => (a - _scrollController.position.pixels).abs() <
                        (b - _scrollController.position.pixels).abs()
                    ? a
                    : b,
              );
              _scrollController
                  .animateTo(
                    nearestIndex.toDouble(),
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.ease,
                  )
                  .then(
                    (value) => setState(
                      () => _isScrolling = false,
                    ),
                  );
            }
          }
        });
      });
    });

    return SizedBox(
      child: AbsorbPointer(
        absorbing: _isScrolling,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: null,
          scrollDirection: Axis.horizontal,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 191),
            width: 1000,
            height: 150,
            child: const Chart(),
          ),
        ),
      ),
    );
  }
}
