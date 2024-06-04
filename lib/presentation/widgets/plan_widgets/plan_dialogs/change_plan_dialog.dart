import 'package:app/buisness/action/plan_action.dart';
import 'package:app/buisness/bloc/plan_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePlanDialog extends StatelessWidget {
  final List<String> planNames;
  const ChangePlanDialog({
    super.key,
    required this.planNames,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 1,
                  offset: Offset(0, 2),
                ),
              ],
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                const Center(
                  child: Text(
                    'Zmień plan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: planNames.length,
            itemBuilder: (context, index) {
              return ListTile(
                tileColor: index % 2 == 0
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.onSecondary,
                title: Center(
                  child: Text(planNames[index]),
                ),
                onTap: () {
                  BlocProvider.of<PlanBloc>(context).add(
                    ChangePlanAction(planName: planNames[index]),
                  );
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
