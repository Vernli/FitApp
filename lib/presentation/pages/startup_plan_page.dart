import 'package:app/buisness/bloc/plan_bloc.dart';
import 'package:app/presentation/pages/add_plan_page.dart';
import 'package:app/presentation/widgets/components/circle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartupPlanPage extends StatelessWidget {
  const StartupPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleButton(
          size: 140,
          onPressed: () {
            return Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<PlanBloc>(context),
                  child: const AddPlanPage(),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 10),
        const Text(
          'Dodaj',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.10,
        ),
      ],
    );
  }
}
