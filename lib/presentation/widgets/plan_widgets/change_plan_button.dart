import 'package:app/buisness/action/plan_action.dart';
import 'package:app/buisness/bloc/plan_bloc.dart';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePlanButton extends StatefulWidget {
  final String currentPlanName;
  final List<String> planNames;
  const ChangePlanButton({
    super.key,
    required this.planNames,
    required this.currentPlanName,
  });

  @override
  State<ChangePlanButton> createState() => _ChangePlanButtonState();
}

class _ChangePlanButtonState extends State<ChangePlanButton> {
  @override
  Widget build(BuildContext context) {
    String? selectedValue;

    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: const Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  'Zmień plan',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        items: widget.planNames
            .map(
              (String item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
          context.read<PlanBloc>().add(
                ChangePlanAction(planName: selectedValue),
              );
        },
        buttonStyleData: ButtonStyleData(
          height: 32,
          width: 120,
          padding: const EdgeInsets.only(left: 0, right: 0),
          decoration: BoxDecoration(
            color: Colors.grey[800],
            border: Border.all(
              color: Colors.black38,
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 2,
                offset: Offset(0, 0),
              ),
            ],
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: 200,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            border: Border.all(
              color: Colors.black38,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 2,
                offset: Offset(0, 4),
              ),
            ],
          ),
          offset: const Offset(0, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(20),
            thickness: MaterialStateProperty.all(6),
            thumbVisibility: MaterialStateProperty.all(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );

    // return Center(
    //   child: DropdownButtonHideUnderline(
    //     child: DropdownButton2<String>(
    //       isExpanded: true,
    //       hint: Text(
    //         'Select Item',
    //         style: TextStyle(
    //           fontSize: 14,
    //           color: Theme.of(context).hintColor,
    //         ),
    //       ),
    //       items: widget.planNames
    //           .map((String plan) => DropdownMenuItem<String>(
    //                 value: plan,
    //                 child: Text(
    //                   plan,
    //                   style: const TextStyle(
    //                     fontSize: 14,
    //                   ),
    //                 ),
    //               ))
    //           .toList(),
    //       value: selectedValue,
    //       onChanged: (String? value) {
    //         setState(() {
    //           selectedValue = value;
    //         });
    //       },
    //       buttonStyleData: const ButtonStyleData(
    //         padding: EdgeInsets.symmetric(horizontal: 16),
    //         height: 40,
    //         width: 140,
    //       ),
    //       menuItemStyleData: const MenuItemStyleData(
    //         height: 40,
    //       ),
    //     ),
    //   ),
    // );

    // return Material(
    //   child: Container(
    //     height: MediaQuery.of(context).size.height,
    //     color: Theme.of(context).colorScheme.secondary,
    //     child: Column(
    //       children: [
    //         PlanAddAppbar(
    //           paddingTop: safeAreaPadding['paddingTop']!,
    //           title: 'Wybierz plan',
    //         ),
    //         const Spacer(),
    //         Container(
    //           width: MediaQuery.of(context).size.width - 75,
    //           height: safeAreaHeight - 100,
    //           margin: const EdgeInsets.only(top: 24),
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(16),
    //             boxShadow: const [
    //               BoxShadow(
    //                 color: Colors.black,
    //                 blurRadius: 4,
    //                 offset: Offset(0, 2),
    //               ),
    //             ],
    //             color: Theme.of(context).colorScheme.onSecondary,
    //           ),
    //           child: Column(
    //             children: [
    //               ListView.builder(
    //                 shrinkWrap: true,
    //                 itemCount: planNames.length,
    //                 itemBuilder: (context, index) {
    //                   return Container(
    //                     color: planNames[index] == currentPlanName
    //                         ? Theme.of(context).colorScheme.primary
    //                         : index % 2 == 0
    //                             ? Theme.of(context).colorScheme.secondary
    //                             : Theme.of(context).colorScheme.onSecondary,
    //                     child: ListTile(
    //                       title: Center(
    //                         child: Text(planNames[index]),
    //                       ),
    //                       onTap: () {
    //                         BlocProvider.of<PlanBloc>(context).add(
    //                           ChangePlanAction(planName: planNames[index]),
    //                         );
    //                         Navigator.of(context).pop();
    //                       },
    //                     ),
    //                   );
    //                 },
    //               ),
    //             ],
    //           ),
    //         ),
    //         const SizedBox(
    //           height: 32,
    //         ),
    //         const Spacer(),
    //       ],
    //     ),
    //   ),
    // );
  }
}
