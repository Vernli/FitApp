import 'package:app/config/theme/app_theme.dart';
import 'package:app/presentation/widgets/diet_widgets/a_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductDialog extends StatefulWidget {
  final String mealType;
  final String date; // DateFormat yyyy-MM-dd
  final Function onAdd;

  const ProductDialog({
    super.key,
    required this.mealType,
    required this.date,
    required this.onAdd,
  });

  @override
  _ProductDialogState createState() => _ProductDialogState();
}

class _ProductDialogState extends State<ProductDialog> {
  final TextEditingController _controllerMealName = TextEditingController();
  final TextEditingController _controllerKcal = TextEditingController();
  final TextEditingController _controllerCarbs = TextEditingController();
  final TextEditingController _controllerProtein = TextEditingController();
  final TextEditingController _controllerFat = TextEditingController();

  @override
  void dispose() {
    _controllerMealName.dispose();
    _controllerKcal.dispose();
    _controllerCarbs.dispose();
    _controllerProtein.dispose();
    _controllerFat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Dialog(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            elevation: 2,
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
                    child: const Center(
                      child: Text(
                        'Dane prodkutu',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          'Wartości odżywcze [na 100 g/ml]:',
                          style: dietTitleStyle,
                        ),
                        Row(
                          children: [
                            Text(
                              'Nazwa posiłku:',
                              style: dietInputLabel,
                            ),
                            const SizedBox(width: 30),
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(),
                                controller: _controllerMealName,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a meal name';
                                  }
                                  return null;
                                },
                                style: dietInputLabel,
                                autocorrect: false,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Wartość energetyczna: ',
                              style: dietInputLabel,
                            ),
                            const SizedBox(width: 20),
                            SizedBox(
                              width: 80,
                              child: TextFormField(
                                maxLength: 3,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]'),
                                  ),
                                ],
                                style: dietInputLabel,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  suffixIcon: Text(
                                    'kcal',
                                    style: TextStyle(color: Colors.grey[300]),
                                  ),
                                  suffixIconConstraints: const BoxConstraints(
                                    minWidth: 0,
                                    minHeight: 0,
                                  ),
                                  counterText: '',
                                ),
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                controller: _controllerKcal,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter kcal';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Białka: ', style: dietInputLabel),
                            const SizedBox(width: 20),
                            SizedBox(
                              width: 80,
                              child: TextFormField(
                                maxLength: 4,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'(^\d*\.?\d*)'),
                                  ),
                                ],
                                style: dietInputLabel,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  suffixIcon: Text(
                                    'g',
                                    style: TextStyle(color: Colors.grey[300]),
                                  ),
                                  suffixIconConstraints: const BoxConstraints(
                                    minWidth: 0,
                                    minHeight: 0,
                                  ),
                                  counterText: '',
                                ),
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                controller: _controllerProtein,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter kcal';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Węglowodany: ', style: dietInputLabel),
                            const SizedBox(width: 20),
                            SizedBox(
                              width: 80,
                              child: TextFormField(
                                style: dietInputLabel,
                                autocorrect: false,
                                maxLength: 4,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'(^\d*\.?\d*)'),
                                  ),
                                ],
                                decoration: InputDecoration(
                                  suffixIcon: Text(
                                    'g',
                                    style: TextStyle(color: Colors.grey[300]),
                                  ),
                                  suffixIconConstraints: const BoxConstraints(
                                    minWidth: 0,
                                    minHeight: 0,
                                  ),
                                  counterText: '',
                                ),
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                controller: _controllerCarbs,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter kcal';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tłuszcze: ', style: dietInputLabel),
                            const SizedBox(width: 20),
                            SizedBox(
                              width: 80,
                              child: TextFormField(
                                maxLength: 4,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'(^\d*\.?\d*)'),
                                  ),
                                ],
                                style: dietInputLabel,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  suffixIcon: Text(
                                    'g',
                                    style: TextStyle(color: Colors.grey[300]),
                                  ),
                                  suffixIconConstraints: const BoxConstraints(
                                    minWidth: 0,
                                    minHeight: 0,
                                  ),
                                  counterText: '',
                                ),
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                controller: _controllerFat,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter kcal';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
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
                            const SizedBox(
                              width: 8,
                            ),
                            ElevatedButton(
                              child: Text('Dalej', style: dietInputLabel),
                              onPressed: () {
                                //   TODO SHOW ALERTS
                                if (_controllerMealName.text.isEmpty ||
                                    _controllerKcal.text.isEmpty ||
                                    _controllerCarbs.text.isEmpty ||
                                    _controllerProtein.text.isEmpty ||
                                    _controllerFat.text.isEmpty) {
                                  showDialog(
                                    context: context,
                                    builder: (newContext) {
                                      return AlertDialog(
                                        title: const Text(
                                          'Błąd',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        content: const Text(
                                          'Wartości nie mogą być puste!.',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(newContext);
                                            },
                                            child: Text(
                                              'OK',
                                              style: dietInputLabel,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                                double sumOfNutritions =
                                    double.parse(_controllerCarbs.text) +
                                        double.parse(_controllerProtein.text) +
                                        double.parse(_controllerFat.text);
                                if (sumOfNutritions > 100) {
                                  showDialog(
                                    context: context,
                                    builder: (newContext) {
                                      return AlertDialog(
                                        title: const Text(
                                          'Błąd',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        content: const Text(
                                          'Suma wartości odżywczych przekracza 100g.',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(newContext);
                                            },
                                            child: Text(
                                              'OK',
                                              style: dietInputLabel,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  return;
                                }

                                Navigator.pop(context);

                                showDialog(
                                  context: context,
                                  builder: (newContext) {
                                    return ADialot(
                                      productName: _controllerMealName.text,
                                      productKcal:
                                          double.parse(_controllerKcal.text),
                                      productCarbs:
                                          double.parse(_controllerCarbs.text),
                                      productProteins: double.parse(
                                        _controllerProtein.text,
                                      ),
                                      productFat:
                                          double.parse(_controllerFat.text),
                                      onAdd: widget.onAdd,
                                    );
                                  },
                                );
                              },
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
