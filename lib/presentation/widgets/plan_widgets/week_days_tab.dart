import 'package:app/utils/plan_exercise.dart';
import 'package:app/presentation/widgets/plan_widgets/add_exercise_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WeekDaysTab extends StatefulWidget {
  final List<String> weekDays;
  final List<Widget> tabBarPages;
  final bool isBottomButton;
  final double contentHeight;
  final int tabLength;
  final Function(int, PlanExercise)? onAddExercise;
  final Function? checkIsExerciseExists;

  const WeekDaysTab({
    super.key,
    required this.weekDays,
    required this.tabBarPages,
    required this.isBottomButton,
    this.onAddExercise,
    required this.contentHeight,
    required this.tabLength,
    this.checkIsExerciseExists,
  });

  @override
  State<WeekDaysTab> createState() => _WeekDaysState();
}

class _WeekDaysState extends State<WeekDaysTab> with TickerProviderStateMixin {
  List<List<PlanExercise>> exercises = [];

  late TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabLength, vsync: this);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          indicatorColor: Theme.of(context).colorScheme.primary,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: Theme.of(context).colorScheme.primary.withOpacity(0.98),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 2,
                offset: Offset(0, -2),
              ),
            ],
          ),
          dividerColor: Colors.black54,
          tabs: widget.weekDays
              .map(
                (day) => Tab(
                  child: Text(
                    day,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        widget.isBottomButton
            ? Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .onSecondary
                      .withOpacity(0.98),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 2,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: AddExerciesButton(
                    checkIsExerciseExists: (value) {
                      if (widget.checkIsExerciseExists == null) {
                        throw Exception('checkIsExerciseExists is null');
                      }
                      return widget.checkIsExerciseExists!(
                        _tabController!.index,
                        value,
                      );
                    },
                    onAddExercise: (value) {
                      if (widget.onAddExercise == null) {
                        throw Exception('onAddExercise is null');
                      }
                      widget.onAddExercise!(_tabController!.index, value);
                    },
                  ),
                ),
              )
            : const SizedBox(),
        Container(
          width: MediaQuery.of(context).size.width,
          height: widget.contentHeight,
          color: Colors.black26,
          child: TabBarView(
            controller: _tabController,
            children: widget.tabBarPages,
          ),
        ),
      ],
    );
  }
}
