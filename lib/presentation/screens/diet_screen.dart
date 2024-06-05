import 'package:app/buisness/bloc/diet_bloc.dart';
import 'package:app/presentation/pages/diet_page.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';

class DietScreen<T extends DietBloc> extends StatelessWidget {
  const DietScreen({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pl_PL', null);
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: const DietPage(),
    );
  }
}
