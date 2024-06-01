import 'package:flutter/material.dart';

class PlanAddAppbar extends StatefulWidget {
  final double paddingTop;
  final TextEditingController? textController;
  final String? title;
  const PlanAddAppbar({
    super.key,
    this.title,
    this.textController,
    required this.paddingTop,
  });

  @override
  State<PlanAddAppbar> createState() => _PlanAddAppbarState();
}

class _PlanAddAppbarState extends State<PlanAddAppbar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: widget.paddingTop,
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).colorScheme.primary,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          padding: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
            boxShadow: const [
              BoxShadow(
                blurRadius: 2,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              widget.textController != null
                  ? Container(
                      width: 264,
                      decoration: BoxDecoration(
                        color: Colors.red[600]!.withOpacity(0.50),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 0,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: widget.textController,
                        textAlign: TextAlign.center,
                        cursorColor: Colors.white60,
                        cursorHeight: 20,
                        maxLength: 12,
                        decoration: const InputDecoration(
                          counterText: '',
                          hintText: 'Wprowadź nazwę planu',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    )
                  : SizedBox(
                      child: Text(
                        widget.title != null ? widget.title! : '',
                        style:
                            const TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
