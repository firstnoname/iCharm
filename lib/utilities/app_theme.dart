import 'package:flutter/material.dart';

const primaryColor = Color.fromRGBO(250, 104, 65, 1.0);
const secondaryColor = Color.fromRGBO(255, 227, 219, 1);

ThemeData appTheme() {
  final ThemeData theme = ThemeData();
  return theme.copyWith(
    colorScheme: theme.colorScheme.copyWith(primary: primaryColor),
  );
}
