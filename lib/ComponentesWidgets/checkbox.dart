import 'package:flutter/material.dart';

class CheckBox {
  final bool? value;
  final ValueChanged<bool> setValue;

  CheckBox({
    Key? key,
    required this.value,
    required this.setValue,
  });

  Checkbox show() {
    return Checkbox(
      value: value,
      onChanged: (bool? value) {
        setValue(value!);
      },
    );
  }
}
