import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

const massRatesBaseKg = {
  'Tonne': 0.001,
  'Kg': 1,
  'Gram': 1000,
  'Milligram': 1000000,
  'Microgram': 1000000000,
  'Pound': 2.20462,
};

const speedRatesBaseMs = {
  'Meter/Second': 1,
  'Foot/Second': 3.28084,
  'Kilometer/Hour': 3.6,
  'Mile/Hour': 2.23694,
  'Knot': 1.94384,
};

const pressureRatesBasePa = {
  'Pascal': 1,
  'Bar': 0.00001,
  'Psi': 0.000145038,
  'Torr': 0.00750062,
};

const lengthRatesBaseM = {
  'Meter': 1,
  'Kilometer': 0.001,
  'Mile': 0.000621371,
  'Inch': 39.3701,
};

const volumeRatesBaseCubicM = {
  'Cubic Meter': 1,
  'Liter': 1000,
  'Gallon': 264.172,
};

const options = [
  'Mass',
  'Speed',
  'Pressure',
  'Length',
  'Volume',
];

class ToolController extends GetxController {
  final chosenOption = Rx<String>('Mass');
  final chosenTool = Rx<String>('Converter');

  final fromController = TextEditingController();

  final toController = TextEditingController();

  final options = Rx(massRatesBaseKg);

  final fromOption = Rx<String>(massRatesBaseKg.keys.toList()[0]);

  final toOption = Rx<String>(massRatesBaseKg.keys.toList()[1]);

  void changeConverter(value) {
    chosenOption(value);
    toController.clear();
    fromController.clear();
    switch (value) {
      case "Mass": {
        options(massRatesBaseKg);
        fromOption(massRatesBaseKg.keys.toList()[0]);
        toOption(massRatesBaseKg.keys.toList()[1]);
        break;
      }
      case "Speed": {
        options(speedRatesBaseMs);
        fromOption(speedRatesBaseMs.keys.toList()[0]);
        toOption(speedRatesBaseMs.keys.toList()[1]);
        break;
      }
      case "Pressure": {
        options(pressureRatesBasePa);
        fromOption(pressureRatesBasePa.keys.toList()[0]);
        toOption(pressureRatesBasePa.keys.toList()[1]);
        break;
      }
      case "Length": {
        options(lengthRatesBaseM);
        fromOption(lengthRatesBaseM.keys.toList()[0]);
        toOption(lengthRatesBaseM.keys.toList()[1]);
        break;
      }
      case "Volume": {
        options(volumeRatesBaseCubicM);
        fromOption(volumeRatesBaseCubicM.keys.toList()[0]);
        toOption(volumeRatesBaseCubicM.keys.toList()[1]);
        break;
      }
    }
  }

  void onChange(String value, String type) {
    if (value == "") {
      if (type == "from") {
        toController.clear();
      } else {
        fromController.clear();
      }
    } else if (type == "from") {
      toController.text = (double.parse(value) /
              options.value[fromOption.value]! *
              options.value[toOption.value]!)
          .toString();
    } else {
      fromController.text = (double.parse(value) /
          options.value[toOption.value]! *
          options.value[fromOption.value]!)
          .toString();
    }
  }

  void changeRates(value, String type) {
    if (value == toOption.value && type == "from") {
      toOption(fromOption.value);
      fromOption(value);
      onChange(fromController.text, type);
    } else if (type == "from") {
      fromOption(value);
      onChange(fromController.text, type);
    } else if (value == fromOption.value) {
      fromOption(toOption.value);
      toOption(value);
      onChange(toController.text, type);
    } else {
      toOption(value);
      onChange(toController.text, type);
    }
  }
}
