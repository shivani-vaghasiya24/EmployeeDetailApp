import 'dart:html' as html;

import 'package:flutter/material.dart';

void popScreen(BuildContext context) {
  html.window.history.back();
}
