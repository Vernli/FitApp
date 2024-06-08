import 'package:app/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DietGoalDialog extends StatefulWidget {
  final Function onAdd;
  const DietGoalDialog({
    super.key,
    required this.onAdd,
  });

  @override
  State<DietGoalDialog> createState() => _DietGoalDialogState();
}

class _DietGoalDialogState extends State<DietGoalDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerKcal = TextEditingController();
  final TextEditingController _controllerCarbs = TextEditingController();
  final TextEditingController _controllerProtein = TextEditingController();
  final TextEditingController _controllerFat = TextEditingController();

  @override
  void dispose() {
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
                        'Dodaj cel',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),

                  // Form
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      key: _formKey,
                      child: Form(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              maxLength: 3,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              style: dietInputLabel,
                              decoration: const InputDecoration(
                                labelText: 'Kcal',
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              controller: _controllerKcal,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter kcal';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              maxLength: 3,
                              keyboardType: TextInputType.number,
                              style: dietInputLabel,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: const InputDecoration(
                                labelText: 'Węglowodany (g)',
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              controller: _controllerCarbs,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter carbs';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              maxLength: 3,
                              keyboardType: TextInputType.number,
                              style: dietInputLabel,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: const InputDecoration(
                                labelText: 'Białka (g)',
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              controller: _controllerProtein,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter protein';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              maxLength: 3,
                              keyboardType: TextInputType.number,
                              style: dietInputLabel,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: const InputDecoration(
                                labelText: 'Tłuszcze (g)',
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              controller: _controllerFat,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter fat';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Anuluj',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (_controllerKcal.text.isEmpty ||
                                  _controllerCarbs.text.isEmpty ||
                                  _controllerProtein.text.isEmpty ||
                                  _controllerFat.text.isEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext builderContext) {
                                    return AlertDialog(
                                      title: const Text(
                                        'Błąd',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      content: const Text(
                                        'Prosze uzupełnić wszystkie pola',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      actions: [
                                        Card(
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              'OK',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                widget.onAdd(
                                  int.parse(_controllerKcal.text),
                                  int.parse(_controllerCarbs.text),
                                  int.parse(_controllerProtein.text),
                                  int.parse(_controllerFat.text),
                                );
                              }
                            },
                            child: const Text(
                              'Dodaj',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
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
