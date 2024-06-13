import 'package:app/config/theme/app_theme.dart';
import 'package:app/utils/calculation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ADialot extends StatefulWidget {
  final String productName;
  final double productKcal;
  final double productCarbs;
  final double productProteins;
  final double productFat;
  final Function onAdd;

  const ADialot({
    super.key,
    required this.productName,
    required this.productKcal,
    required this.productCarbs,
    required this.productProteins,
    required this.productFat,
    required this.onAdd,
  });

  @override
  State<ADialot> createState() => _ADialotState();
}

class _ADialotState extends State<ADialot> {
  final List<String> _units = ['g', 'ml'];
  String _selectedUnit = 'g';
  final TextEditingController _weightController = TextEditingController();
  final Map<String, double> _nutrins = {
    'kcal': 0,
    'proteins': 0,
    'carbs': 0,
    'fat': 0,
  };
  double weight = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Dialog(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            elevation: 1,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: Colors.black,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            insetPadding: const EdgeInsets.all(0),
            child: SizedBox(
              child: Column(
                children: [
                  // Dialog title
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
                    child: Center(
                      child: Text(
                        widget.productName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Waga posiłku:',
                                  style: dietInputLabel,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 50,
                                      child: TextField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                            RegExp(r'(^\d*\.?\d*)'),
                                          ),
                                        ],
                                        style: dietInputLabel,
                                        autocorrect: false,
                                        controller: _weightController,
                                        maxLength: 4,
                                        cursorColor: Colors.white,
                                        decoration: const InputDecoration(
                                          counterText: '',
                                          hintText: '0',
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) => setState(
                                          () {
                                            if (value != '' && value != '.') {
                                              weight = double.parse(value);
                                            } else {
                                              weight = 0;
                                            }
                                            _nutrins['kcal'] = Calculation
                                                .calculateNutrinsPer100g(
                                              weight,
                                              widget.productKcal,
                                            );
                                            _nutrins['proteins'] = Calculation
                                                .calculateNutrinsPer100g(
                                              weight,
                                              widget.productProteins,
                                            );
                                            _nutrins['carbs'] = Calculation
                                                .calculateNutrinsPer100g(
                                              weight,
                                              widget.productCarbs,
                                            );
                                            _nutrins['fat'] = Calculation
                                                .calculateNutrinsPer100g(
                                              weight,
                                              widget.productFat,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: _selectedUnit,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            _selectedUnit = newValue!;
                                          });
                                        },
                                        items: _units
                                            .map<DropdownMenuItem<String>>(
                                              (String value) =>
                                                  DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style: dietInputLabel,
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          color: Theme.of(context).colorScheme.secondary,
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  'Wartości odżywcze [na 100 g/ml]:',
                                  style: dietTitleStyle,
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Kcal: ${widget.productKcal.toStringAsFixed(2)}',
                                      style: dietDialog,
                                    ),
                                    Text(
                                      'Białko: ${widget.productProteins.toStringAsFixed(2)}',
                                      style: dietDialog,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Węglowodany: ${widget.productCarbs.toStringAsFixed(2)}',
                                      style: dietDialog,
                                    ),
                                    Text(
                                      'Tłuszcze: ${widget.productFat.toStringAsFixed(2)}',
                                      style: dietDialog,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  'Wartości odżywcze [na ${weight.toStringAsFixed(0)} $_selectedUnit]',
                                  style: dietTitleStyle,
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Kcal: ${_nutrins['kcal']}',
                                      style: dietDialog,
                                    ),
                                    Text(
                                      'Białko: ${_nutrins['proteins']}',
                                      style: dietDialog,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Węglowodany: ${_nutrins['carbs']}',
                                      style: dietDialog,
                                    ),
                                    Text(
                                      'Tłuszcze: ${_nutrins['fat']}',
                                      style: dietDialog,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                              child: Text(
                                'Anuluj',
                                style: dietInputLabel,
                              ),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton(
                              onPressed: () {
                                if (weight == 0) {
                                  return;
                                }
                                widget.onAdd(
                                  {
                                    'mealName': widget.productName,
                                    'kcal': _nutrins['kcal'],
                                    'proteins': _nutrins['proteins'],
                                    'carbs': _nutrins['carbs'],
                                    'fat': _nutrins['fat'],
                                  },
                                );
                              },
                              child:
                                  Text('Dodaj posiłek', style: dietInputLabel),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
