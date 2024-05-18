import 'package:app/presentation/widgets/components/plan_exercises.dart';
import 'package:app/presentation/widgets/plan_widgets/add_exercise_button.dart';
import 'package:flutter/material.dart';

class WeekDaysTab extends StatefulWidget {
  final List<String> weekDays;
  final List<Widget> tabBarPages;
  final Function(int, PlanExercises) onAddExercise;

  const WeekDaysTab({
    super.key,
    required this.weekDays,
    required this.tabBarPages,
    required this.onAddExercise,
  });

  @override
  State<WeekDaysTab> createState() => _WeekDaysState();
}

class _WeekDaysState extends State<WeekDaysTab> with TickerProviderStateMixin {
  List<List<PlanExercises>> exercises = [];

  late TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
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
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.98),
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
              onAddExercise: (value) {
                widget.onAddExercise(_tabController!.index, value);
              },
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: (MediaQuery.of(context).size.height * 0.75 - 88),
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
