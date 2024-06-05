import 'package:flutter/material.dart';

class AddMealDialog extends StatefulWidget {
  final String mealType;
  final String date; // DateFormat yyyy-MM-dd
  final Function onAdd;
  const AddMealDialog({
    super.key,
    required this.mealType,
    required this.date,
    required this.onAdd,
  });

  @override
  _AddMealDialogState createState() => _AddMealDialogState();
}

class _AddMealDialogState extends State<AddMealDialog> {
  final _formKey = GlobalKey<FormState>();
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
                        'Uzupełnij dane o posiłku',
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
                              decoration: const InputDecoration(
                                labelText: 'Nazwa posiłku',
                              ),
                              controller: _controllerMealName,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a meal name';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'Kcal'),
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
                            TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Węglowodany (g)'),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: true,
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
                              decoration: const InputDecoration(
                                  labelText: 'Białka (g)'),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: true,
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
                              decoration: const InputDecoration(
                                labelText: 'Tłuszcze (g)',
                              ),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: true,
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
                              if (_controllerMealName.text.isEmpty ||
                                  _controllerKcal.text.isEmpty ||
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
                                  {
                                    'mealName': _controllerMealName.text,
                                    'kcal': _controllerKcal.text,
                                    'carbs': _controllerCarbs.text,
                                    'proteins': _controllerProtein.text,
                                    'fat': _controllerFat.text,
                                  },
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
