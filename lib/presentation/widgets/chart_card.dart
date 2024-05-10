import 'package:app/buisness/bloc/weight_bloc.dart';
import 'package:app/buisness/states/weight_state.dart';
import 'package:app/presentation/widgets/chart_box.dart';
import 'package:app/presentation/widgets/components/custom_button.dart';
import 'package:app/presentation/widgets/components/custom_card.dart';
import 'package:app/presentation/widgets/components/triangle_pointer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChartCard extends StatelessWidget {
  const ChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      margin: const EdgeInsets.only(top: 30),
      child: BlocBuilder<WeightBloc, WeightState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              const ChartBox(),
              ClipPath(
                clipper: TrianglePointer(),
                child: Container(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
                  width: 32,
                  height: 24,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  border: const BorderDirectional(
                    top: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 1,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                //TODO CHANGE DATA ON SCROLLING
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      '2024-01-05',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    const Text(
                      '56,5kg',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CustomButton(
                      onPressed: () {},
                      text: 'Usuń',
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.8),
                      size: const Size(60, 30),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
