import 'package:app/buisness/bloc/weight_bloc.dart';
import 'package:app/buisness/states/weight_state.dart';
import 'package:app/presentation/widgets/weight_widgets/chart_box.dart';
import 'package:app/presentation/widgets/components/custom_card.dart';
import 'package:app/presentation/widgets/components/triangle_pointer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A card widget that displays a chart with weight data.
class ChartCard extends StatefulWidget {
  const ChartCard({super.key});

  @override
  State<ChartCard> createState() => _ChartCardState();
}

class _ChartCardState extends State<ChartCard> {
  List<int> scrollSpace = [];
  List<double> weightList = [];
  List<Map<String, String>> weightDate = [];
  int position = 0;
  bool isPositionLoaded = false;
  ScrollController? scrollController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scrollSpace.clear();
    weightList.clear();
    weightDate.clear();
    scrollController?.dispose();
    isPositionLoaded = false;
    scrollController = null;
    position = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      margin: const EdgeInsets.only(top: 20),
      child: BlocBuilder<WeightBloc, WeightState>(
        builder: (context, state) {
          /// Generates scroll space, weight list, and weight date based on the provided data.
          /// The [state] object contains the data used for generating the scroll space, weight list, and weight date.
          /// The [data] variable is a dynamic object that represents the data from the state.
          /// The [scrollSpace] list is generated based on the length of the data, with each element representing the scroll space for a specific index.
          /// The [weightList] list is generated based on the length of the data, with each element representing the weight for a specific index.
          /// The [weightDate] list is generated based on the length of the data, with each element representing the weight date for a specific index.
          if (state.data != null) {
            dynamic data = state.data;
            scrollSpace = List.generate(data.length, (index) => index * 75);

            weightList = List.generate(data.length, (index) {
              return data[index]['weight'];
            });
            weightDate = List.generate(data.length, (index) {
              return {
                'date': data[index]['date'],
              };
            });
            // When the tab is loaded, load the position and set to the last element of the scroll space.
            if (isPositionLoaded == false) {
              position = scrollSpace.last;
              isPositionLoaded = true;
            }

            scrollController ??= ScrollController(
              initialScrollOffset: scrollSpace.last.toDouble(),
              keepScrollOffset: false,
            );
          }

          Map<String, String>? informations = getInformations();
          return Column(
            children: [
              state.data != null
                  ? ChartBox(
                      scrollController: ScrollController(
                        initialScrollOffset: scrollSpace.last.toDouble(),
                      ),
                      scrollSpace: scrollSpace,
                      weightList: weightList,
                      onScrollEnd: (value) {
                        setState(() {
                          position = value;
                        });
                      },
                    )
                  : const SizedBox(
                      height: 150,
                      child: Center(
                        child: Text(
                          'Brak danych',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
              ClipPath(
                clipper: TrianglePointer(),
                child: Container(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
                  width: 32,
                  height: 24,
                ),
              ),
              Container(
                height: 48,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  border: BorderDirectional(
                    top: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      informations?['weight'] ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      informations?['date'] ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
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

  /// Retrieves the weight and date information based on the current position.
  ///
  /// Returns a map with the 'date' and 'weight' information if the current position
  /// is within the scroll space, otherwise returns null.
  Map<String, String>? getInformations() {
    if (scrollSpace.contains(position)) {
      int index = scrollSpace.indexOf(position);

      return {
        'date': '${weightDate[index]['date']}',
        'weight': '${weightList[index]} kg',
      };
    }
    return null;
  }
}
