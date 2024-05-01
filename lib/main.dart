import 'package:app/buisness/bloc/weight_bloc.dart';
import 'package:app/config/theme/app_theme.dart';
import 'package:app/presentation/components/tab_appbar.dart';
import 'package:app/presentation/weight_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dziennik Treningowy',
      theme: appTheme,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeightBloc>(
          create: (context) => WeightBloc(),
        ),
      ],
      child: DefaultTabController(
        length: 3,
        initialIndex: 1,
        child: Scaffold(
          appBar: const TabAppBar(
            tabs: [
              Tab(
                text: 'Dieta',
              ),
              Tab(
                text: 'Trening',
              ),
              Tab(
                text: 'Waga',
              ),
            ],
          ),
          body: const TabBarView(
            children: [
              Center(child: Text('Dieta')),
              Center(child: Text('Plan Treningowy')),
              Center(child: WeightScreen<WeightBloc>()),
            ],
          ),
          extendBodyBehindAppBar: false,
          floatingActionButton: FloatingActionButton(
            // TODO - IMPLEMENTACJA FUNKCJONALNOŚCI
            onPressed: () => {},
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: const Icon(Icons.bar_chart_rounded),
          ),
        ),
      ),
    );
  }
}
