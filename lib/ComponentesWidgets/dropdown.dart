// ignore_for_file: file_names

import 'package:flutter/material.dart';

// String dropdownPlantaInvSelected = ' ';

// List<DropDownOptions> arrPlantas = List<DropDownOptions>();

// void onDropDownPlantaChange(String newValue) {
//     setStateIfMounted(() {
//       dropdownPlantaSelected = newValue;
//     });
//     getPlantasInv(newValue);
//   }

Widget dropdown(
    String padrao, List<DropDownOptions> options, ValueChanged<String> function,
    {underlineEnable = true, iconArrowEnable = true}) {
  DropDown drop = DropDown(
      selected: padrao,
      options: options,
      onDropDownChange: function,
      underlineEnable: underlineEnable,
      iconArrowEnable: iconArrowEnable);

  try {
    return drop.show();
  } catch (e) {
    debugPrint('Incompatibilidade no dropdown Error!' + e.toString());
    debugPrint('Reset de preferências!');
    //resetPrefs();
    return const SizedBox();
  }
}

class DropDown {
  String selected;
  List<DropDownOptions> options;
  final ValueChanged<String> onDropDownChange;
  bool underlineEnable;
  bool iconArrowEnable;

  DropDown({
    required this.selected,
    required this.options,
    required this.onDropDownChange,
    this.underlineEnable = true,
    this.iconArrowEnable = true,
  });

  DropdownButton show() {
    return DropdownButton<String>(
      value: selected,
      icon: iconArrowEnable
          ? const Icon(Icons.arrow_drop_down)
          : const Icon(null),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.black, fontSize: 18),
      underline: Container(
        height: underlineEnable ? 2 : 0,
        color: Colors.blue,
      ),
      onChanged: (String? data) {
        onDropDownChange(data!);
      },
      items: options.map<DropdownMenuItem<String>>((DropDownOptions value) {
        return DropdownMenuItem<String>(
          value: value.value,
          //alignment: AlignmentDirectional.center,
          child: Text(value.name),
        );
      }).toList(),
    );
  }
}

class DropDownOptions {
  String name;
  String value;

  DropDownOptions(this.name, this.value);
}
