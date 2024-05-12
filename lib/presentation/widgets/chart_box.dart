import 'package:app/presentation/widgets/components/chart.dart';
import 'package:flutter/material.dart';

class ChartBox extends StatefulWidget {
  final ScrollController scrollController;
  final List<int> scrollSpace;
  final List<double> weightList;
  final Function(int) onScrollEnd;
  const ChartBox({
    super.key,
    required this.scrollController,
    required this.scrollSpace,
    required this.weightList,
    required this.onScrollEnd,
  });
  @override
  State<ChartBox> createState() => _ChartBoxState();
}

class _ChartBoxState extends State<ChartBox> {
  bool _isScrolling = false;
  int? _previousScrollSpaceLength;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      /// If the previous scroll space length is null, set it to the current scroll space length.
      if (_previousScrollSpaceLength == null) {
        _previousScrollSpaceLength = widget.scrollSpace.length;
      }

      /// If the previous scroll space length is different from the current scroll space length, animate the scroll controller to the last element of the scroll space.
      else if (_previousScrollSpaceLength != widget.scrollSpace.length) {
        widget.scrollController.animateTo(
          widget.scrollSpace.last.toDouble(),
          duration: const Duration(milliseconds: 200),
          curve: Curves.ease,
        );
        _previousScrollSpaceLength = widget.scrollSpace.length;

        /// Call the onScrollEnd function with the last element of the scroll space as the argument.
        widget.onScrollEnd(widget.scrollSpace.last);
      }

      /// Add a listener to the scroll controller to check if the scroll position is scrolling.
      widget.scrollController.position.isScrollingNotifier.addListener(() {
        setState(() {
          _isScrolling = true;

          /// If the scroll controller has clients and the scroll position is not scrolling, find the nearest index to the current scroll position and animate the scroll controller to that index.
          if (widget.scrollController.hasClients) {
            if (!widget.scrollController.position.isScrollingNotifier.value) {
              int nearestIndex = widget.scrollSpace.reduce(
                (a, b) => (a - widget.scrollController.position.pixels).abs() <
                        (b - widget.scrollController.position.pixels).abs()
                    ? a
                    : b,
              );
              widget.scrollController
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
              widget.onScrollEnd(nearestIndex);
            }
          }
        });
      });
    });

    return SizedBox(
      /// AbsorbPointer widget to prevent user interaction while scrolling.
      child: AbsorbPointer(
        absorbing: _isScrolling,

        /// SingleChildScrollView widget to enable horizontal scrolling.
        child: SingleChildScrollView(
          controller: widget.scrollController,
          physics: null,
          scrollDirection: Axis.horizontal,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 191),

            /// Calculate the width of the container based on the length of the scroll space.
            width: widget.scrollSpace.length * 75.0 + 300,
            height: 150,
            child: Chart(
              weightList: widget.weightList,
            ),
          ),
        ),
      ),
    );
  }
}
