import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomMethods{
  static IconData getIcon(double temperature){
    return temperature<
        15
        ? Icons.sunny_snowing
        : temperature <
        20 &&
        temperature >
            15
        ? Icons.cloud
        : Icons.sunny;
  }
}