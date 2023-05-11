import 'package:flutter/material.dart';

class DarkModeWidget extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const DarkModeWidget({
    Key? key,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<DarkModeWidget> createState() => _DarkModeWidgetState();
}

class _DarkModeWidgetState extends State<DarkModeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> animation;
  bool switchValue = false;

  @override
  void initState() {
    super.initState();
    switchValue = widget.initialValue;
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    animation = Tween<Offset>(begin: Offset.zero, end: const Offset(1, 0))
        .animate(animationController);
    if (switchValue) {
      animationController.value = 1;
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void switchValueChanged(bool value) {
    setState(() {
      switchValue = value;
    });
    widget.onChanged(switchValue);
    if (switchValue) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switchValueChanged(!switchValue);
      },
      child: Container(
        width: 150,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color:
              switchValue ? Colors.grey : const Color.fromARGB(255, 56, 55, 55),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Stack(
            children: [
              AnimatedAlign(
                alignment:
                    switchValue ? Alignment.centerRight : Alignment.centerLeft,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  width: 75,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: switchValue ? Colors.green : Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
